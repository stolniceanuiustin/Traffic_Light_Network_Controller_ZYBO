#include "IntersectionGraph.h"
#include <stdio.h>
#include <string.h>
#include "TrafficController.h"
#include <Arduino.h>

// --- CONSTANTS ---
#define MAX_GREEN_TIME_MS 60000
#define YELLOW_DURATION_MS 2000
#define MIN_GREEN_TIME_MS 5000
#define STARVATION_THRESHOLD_MS 99999
uint16_t global_simulation_time = 0;
// By convention, the pedestrian phase will be phase number 3.
// Sorry for the hardcoding. Maybe i will fix this someday so pedestrian lanes are actually used!
#define PEDESTRIAN_PHASE_IDX 3
#define PEDESTRIAN_LANE_TL_WEST 17

extern volatile uint16_t system_ticks;
extern void uart_transmit_string(const uint8_t *msg, const size_t size);

typedef enum
{
    STATE_GREEN_RUNNING,
    STATE_YELLOW_TRANSITION
} ControllerState;

static ControllerState current_state = STATE_GREEN_RUNNING;

static uint16_t phase_start_time = 0;
static uint16_t transition_start_time = 0;
static uint16_t last_update_time = 0;

static int next_phase_idx = 0;
static uint16_t phase_last_serviced[MAX_PHASE_CNT];

// --- SIMPLE TIME GETTER FOR ZYNQ COMPATIBILITY
uint16_t get_time_ms()
{
    return global_simulation_time * 1000;
}

int calculate_pressure(Intersection *intr, int phase_idx)
{
    if (phase_idx < 0 || phase_idx >= (int)intr->phase_cnt)
        return 0;
    Phase *p = &intr->phases[phase_idx];
    int pressure = 0;
    for (int i = 0; i < p->connection_count; i++)
    {
        int conn = p->connection_indices[i];
        pressure += (intr->lanes[intr->connections[conn].source_lane_idx].car_count -
                     intr->lanes[intr->connections[conn].target_lane_idx].car_count);
    }
    return pressure;
}

int determine_next_phase(Intersection *intr)
{
    uint64_t now = get_time_ms();
    int current_idx = intr->current_phase_idx;

    // === STARVATION LOGIC ===
    // If a phase has 0 pressure, it is NOT affected by starvation.
    int starved_phase = -1;
    uint64_t max_wait = 0;

    for (int i = 0; i < (int)intr->phase_cnt; i++)
    {
        if (i == current_idx)
            continue;

        int p = calculate_pressure(intr, i);

        if (p > 0)
        {
            uint64_t wait = now - phase_last_serviced[i];
            if (wait > STARVATION_THRESHOLD_MS && wait > max_wait)
            {
                max_wait = wait;
                starved_phase = i;
            }
        }
    }

    if (starved_phase != -1)
        return starved_phase;

    // === IF NO STARVATION, PROCEED TO DO MAX PRESSURE ALGORITHM
    int best_phase = current_idx;
    int max_pressure = -9999;
    int current_duration = now - phase_start_time;

    int current_phase_pressure = calculate_pressure(intr, current_idx);
    max_pressure = current_phase_pressure;

    for (int i = 0; i < (int)intr->phase_cnt; i++)
    {
        // If current phase has run longer than Max Green time, force a switch
        // by skipping it in the search
        if (current_duration > MAX_GREEN_TIME_MS && i == current_idx)
            continue;

        int p = calculate_pressure(intr, i);

        if (p > 0)
        {
            if (p >= max_pressure)
            {
                max_pressure = p;
                best_phase = i;
            }
        }
    }

    return best_phase;
}

void update_lane_status(Intersection *intr, char global_status)
{
    for (int i = 0; i < (int)intr->lane_cnt; i++)
        intr->lanes[i].current_light = 'N'; // 'N' means downstream lane
    for (int c = 0; c < (int)intr->connection_cnt; c++)
        intr->lanes[intr->connections[c].source_lane_idx].current_light = 'R';

    // Set green or yellow
    Phase *curr_p = &intr->phases[intr->current_phase_idx];
    for (int i = 0; i < curr_p->connection_count; i++)
    {
        int src = intr->connections[curr_p->connection_indices[i]].source_lane_idx;
        intr->lanes[src].current_light = (current_state == STATE_YELLOW_TRANSITION) ? 'Y' : global_status;
    }
}

void send_traffic_state(Intersection *intr)
{
    char status_buffer[2 + intr->lane_cnt + 2 + 1];
    uint8_t buffer_idx = 1;

    status_buffer[buffer_idx++] = '$';

    // Send Lane Status (Cars). We do not send the lane status for pedestrian here, as we send them separately
    for (int i = 0; i < intr->lane_cnt - 2; i++)
    {
        int idx = get_lane_index_by_id(intr, i);
        char status = 'N';
        if (idx != -1)
        {
            status = intr->lanes[idx].current_light;
        }
        status_buffer[buffer_idx++] = status;
    }

    // Send Pedestrian Status (Linked to Phase 3)
    // If the current active phase is PEDESTRIAN_PHASE_IDX, send Green (or Yellow), else Red
    char ped_status = 'R';

    if (intr->current_phase_idx == PEDESTRIAN_PHASE_IDX)
    {
        if (current_state == STATE_YELLOW_TRANSITION)
        {
            // Usually peds go Red immediately on yellow, or flash, but let's use Y for now if logic demands
            ped_status = 'Y';
        }
        else
        {
            ped_status = 'G';
        }
    }

    status_buffer[buffer_idx++] = ped_status;
    status_buffer[buffer_idx++] = ped_status;

    status_buffer[buffer_idx++] = '$';

    uint8_t payload_size = buffer_idx - 1;
    status_buffer[0] = (char)payload_size;

    uart_transmit_string((uint8_t *)status_buffer, buffer_idx);
}

void parse_traffic_values(Intersection *intr, uint8_t *string, size_t size)
{
    // Expected string
    // string[0] = lane 0 count
    // string[1] = lane 1 count

    for (uint8_t i = 0; i < size; i++)
    {
        int lane_id = i;
        uint8_t recieved_val = (uint8_t)string[i];
        int idx = get_lane_index_by_id(intr, lane_id);
        if (idx != -1)
        {
            intr->lanes[idx].car_count = recieved_val;
        }
    }

    global_simulation_time++; // Simulation sends this once per simulation step.
}

void signal_pedestrian(Intersection *intr)
{
    intr->lanes[get_lane_index_by_id(intr, PEDESTRIAN_LANE_TL_WEST)].car_count = 1000; // So we have MAX PRESSURE on pedestrian
    // Pedestrians get green as soon as they show up, because i love pedestrians and i want it that way!
}

void run_traffic_controller(Intersection *intr)
{
    uint16_t now = get_time_ms();
    if (phase_start_time == 0)
        phase_start_time = now;

    if (current_state == STATE_GREEN_RUNNING)
        update_lane_status(intr, 'G');

    // State machine
    switch (current_state)
    {
    case STATE_GREEN_RUNNING:
        if (now - phase_start_time > MIN_GREEN_TIME_MS)
        {
            int best = determine_next_phase(intr);
            if (best != intr->current_phase_idx)
            {
                next_phase_idx = best;
                current_state = STATE_YELLOW_TRANSITION;
                transition_start_time = now;
                update_lane_status(intr, 'Y');
            }
        }
        break;
    case STATE_YELLOW_TRANSITION:
        if (now - transition_start_time > YELLOW_DURATION_MS)
        {
            intr->current_phase_idx = next_phase_idx;

            if (next_phase_idx == PEDESTRIAN_PHASE_IDX)
            {
                // TODO REFACTOR THIS SO ITS NOT HARDCODED
                int ped_lane_idx = get_lane_index_by_id(intr, PEDESTRIAN_LANE_TL_WEST);
                if (ped_lane_idx != -1)
                {
                    intr->lanes[ped_lane_idx].car_count = 0;
                }
            }

            current_state = STATE_GREEN_RUNNING;
            phase_start_time = now;
            phase_last_serviced[next_phase_idx] = now;
            update_lane_status(intr, 'G');
        }
        break;
    }
}