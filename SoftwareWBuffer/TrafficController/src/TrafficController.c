#include <stdio.h>
#include <string.h>
#include "TrafficController.h"
#include "IntersectionGraph.h"
#include "HAL.h"
// --- CONSTANTS ---
#define PEDESTRIAN_COUNT_PER_BUTTON 5
#define MAX_GREEN_TIME_MS 60000
#define YELLOW_DURATION_MS 2000
#define MIN_GREEN_TIME_MS 5000
#define STARVATION_THRESHOLD_MS 99999
uint16_t global_simulation_time = 0;

// By convention, the pedestrian phase will be phase number 3.
// Sorry for the hardcoding. Maybe i will fix this someday so pedestrian lanes are actually used!
#define PEDESTRIAN_PHASE_IDX 3
#define PEDESTRIAN_LANE_TL_WEST 17
#define PEDESTRIAN_LANE_TL_EAST 16

extern volatile uint16_t system_ticks;


// --- Make sure we run on simulation time, not on real time, as we are running a simulaion
// In real life, we would use real time(obviously :))) )
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
            uint64_t wait = now - intr->phase_last_serviced[i];
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
    int current_duration = now - intr->phase_start_time;

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
        intr->lanes[src].current_light = (intr->current_state == STATE_YELLOW_TRANSITION) ? 'Y' : global_status;
    }
}

void send_traffic_state(Intersection *intr, char INT_CHAR_ID)
{
    char status_buffer[2 + intr->lane_cnt + 2 + 1];
    uint8_t buffer_idx = 1;

    status_buffer[buffer_idx++] = INT_CHAR_ID;

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
        if (intr->current_state == STATE_YELLOW_TRANSITION)
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

    //AFTER ALL LANES WE SEND THE intersection id and potentiometer value(to dirrectly influence traffic values!)
    status_buffer[buffer_idx++] = (char)'4';
    status_buffer[buffer_idx++] = (char)'E';
    status_buffer[buffer_idx++] = INT_CHAR_ID;

    uint8_t payload_size = buffer_idx - 1;
    status_buffer[0] = (char)payload_size;

    uart_transmit_string((uint8_t *)status_buffer, buffer_idx);
}

bool update_time = false;
void parse_traffic_values(Intersection *intr, uint8_t *string, uint8_t size)
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

    update_time = !update_time;
    if(update_time == true)
        global_simulation_time++; // Simulation sends this TWICE per simulation step!!.
}

void signal_pedestrian(Intersection *intr)
{
    intr->lanes[get_lane_index_by_id(intr, PEDESTRIAN_LANE_TL_WEST)].car_count = PEDESTRIAN_COUNT_PER_BUTTON; 
}

void run_traffic_controller(Intersection *intr)
{
    uint16_t now = get_time_ms();
    if (intr->phase_start_time == 0)
        intr->phase_start_time = now;

    if (intr->current_state == STATE_GREEN_RUNNING)
        update_lane_status(intr, 'G');

    // State machine
    switch (intr->current_state)
    {
    case STATE_GREEN_RUNNING:
        if (now - intr->phase_start_time > MIN_GREEN_TIME_MS)
        {
            int best = determine_next_phase(intr);
            if (best != intr->current_phase_idx)
            {
                intr->next_phase_idx = best;
                intr->current_state = STATE_YELLOW_TRANSITION;
                intr->transition_start_time = now;
                update_lane_status(intr, 'Y');
            }
        }
        break;
    case STATE_YELLOW_TRANSITION:
        if (now - intr->transition_start_time > YELLOW_DURATION_MS)
        {
            intr->current_phase_idx = intr->next_phase_idx;

            if (intr->next_phase_idx == PEDESTRIAN_PHASE_IDX)
            {
                // TODO REFACTOR THIS SO ITS NOT HARDCODED
                int ped_lane_idx = get_lane_index_by_id(intr, PEDESTRIAN_LANE_TL_WEST);
                if (ped_lane_idx != -1)
                {
                    intr->lanes[ped_lane_idx].car_count = 0;
                }
            }

            intr->current_state = STATE_GREEN_RUNNING;
            intr->phase_start_time = now;
            intr->phase_last_serviced[intr->next_phase_idx] = now;
            update_lane_status(intr, 'G');
        }
        break;
    }
}