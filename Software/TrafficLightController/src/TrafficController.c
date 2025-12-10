#include "IntersectionGraph.h"
#include "xgpio.h"
#include <stdio.h>
#include <string.h>

// --- CONSTANTS ---
#define MAX_GREEN_TIME_MS 15000  
#define YELLOW_DURATION_MS 3000   
#define MIN_GREEN_TIME_MS 5000    
#define STARVATION_THRESHOLD_MS 20000
extern volatile uint64_t system_ticks; 
extern void uart_transmit_string(const char *msg);

typedef enum { STATE_GREEN_RUNNING, STATE_YELLOW_TRANSITION } ControllerState;

static ControllerState current_state = STATE_GREEN_RUNNING;
static uint64_t phase_start_time = 0;
static uint64_t transition_start_time = 0;
static uint64_t last_tx_time = 0;
static int next_phase_idx = 0;
static uint64_t phase_last_serviced[MAX_PHASE_CNT];

// --- SIMPLE TIME GETTER ---
uint64_t get_time_ms() {
    return system_ticks;
}

int calculate_pressure(Intersection *intr, int phase_idx) {
    if(phase_idx < 0 || phase_idx >= (int)intr->phase_cnt) return 0;
    Phase *p = &intr->phases[phase_idx];
    int pressure = 0;
    for (int i = 0; i < p->connection_count; i++) {
        int conn = p->connection_indices[i];
        pressure += (intr->lanes[intr->connections[conn].source_lane_idx].car_count - 
                     intr->lanes[intr->connections[conn].target_lane_idx].car_count);
    }
    return pressure;
}

int determine_next_phase(Intersection *intr) {
    uint64_t now = get_time_ms();
    int current_idx = intr->current_phase_idx;
    
    // Starvation
    int starved_phase = -1;
    uint64_t max_wait = 0;
    for(int i=0; i<(int)intr->phase_cnt; i++) {
        if(i == current_idx) continue;
        if(calculate_pressure(intr, i) > 0) {
            uint64_t wait = now - phase_last_serviced[i];
            if(wait > STARVATION_THRESHOLD_MS && wait > max_wait) {
                max_wait = wait; starved_phase = i;
            }
        }
    }
    if(starved_phase != -1) return starved_phase;

    // Max Pressure
    int best_phase = current_idx;
    int max_pressure = -9999;
    int current_duration = now - phase_start_time;

    for(int i=0; i<(int)intr->phase_cnt; i++) {
        if (current_duration > MAX_GREEN_TIME_MS && i == current_idx) continue;
        int p = calculate_pressure(intr, i);
        if(p > max_pressure) {
            max_pressure = p; best_phase = i;
        }
    }
    return best_phase;
}

void update_lane_status(Intersection *intr, char global_status) {
    for(int i=0; i<(int)intr->lane_cnt; i++) intr->lanes[i].current_light = 'N';
    for(int c=0; c<(int)intr->connection_cnt; c++) intr->lanes[intr->connections[c].source_lane_idx].current_light = 'R';

    Phase *curr_p = &intr->phases[intr->current_phase_idx];
    for(int i=0; i < curr_p->connection_count; i++) {
        int src = intr->connections[curr_p->connection_indices[i]].source_lane_idx;
        intr->lanes[src].current_light = (current_state == STATE_YELLOW_TRANSITION) ? 'Y' : global_status;
    }
}


void send_traffic_state(Intersection *intr) {
    uart_transmit_string("$"); 

    // 1. CAR TRAFFIC LIGHTS (Lanes 0 to 16)
    // We iterate by ID to ensure the string order is always Lane 0 -> Lane 16
    for (int id = 0; id <= 16; id++) {
        
        // Find the lane in the array
        int idx = get_lane_index_by_id(intr, id);
        char status = 'N'; // Default safety value

        if (idx != -1) {
            status = intr->lanes[idx].current_light;
        }

        // Sanity Check: If memory is garbage, send '?'
        if (status != 'R' && status != 'G' && status != 'Y' && status != 'N') {
            status = '?';
        }

        // Send single character
        char s[2] = {status, '\0'};
        uart_transmit_string(s);

        // Tiny delay to keep UART FIFO happy
        for(volatile int k=0; k<100; k++); 
    }

    // 2. PEDESTRIAN LIGHTS (2 Lights)
    // Logic: If Controller is in Pedestrian Mode, Peds are GREEN. Otherwise RED.
    char ped_status = 'R'; //(current_state == STATE_PEDESTRIAN_RED) ? 'G' : 'R';
    char p[2] = {ped_status, '\0'};

    // Send Pedestrian 1
    uart_transmit_string(p);
    for(volatile int k=0; k<100; k++); 

    // Send Pedestrian 2
    uart_transmit_string(p);
    for(volatile int k=0; k<100; k++); 

    // End Packet
    uart_transmit_string("$\r\n"); 
}

void run_traffic_controller(Intersection *intr) {
    uint64_t now = get_time_ms();
    if (phase_start_time == 0) phase_start_time = now;

    // Send the new traffic configuration every 500 ms.
    if (now - last_tx_time > 250) {
        if (current_state == STATE_GREEN_RUNNING) 
            update_lane_status(intr, 'G');
        send_traffic_state(intr);
        last_tx_time = now;
    }

    //state machine for traffic light
    switch (current_state) {
        case STATE_GREEN_RUNNING:
            if (now - phase_start_time > MIN_GREEN_TIME_MS) {
                int best = determine_next_phase(intr);
                if (best != intr->current_phase_idx) {
                    next_phase_idx = best;
                    current_state = STATE_YELLOW_TRANSITION;
                    transition_start_time = now;
                    update_lane_status(intr, 'Y');
                }
            }
            break;
        case STATE_YELLOW_TRANSITION:
            if (now - transition_start_time > YELLOW_DURATION_MS) {
                intr->current_phase_idx = next_phase_idx;
                current_state = STATE_GREEN_RUNNING;
                phase_start_time = now;
                phase_last_serviced[next_phase_idx] = now;
                update_lane_status(intr, 'G');
            }
            break;
    }
}