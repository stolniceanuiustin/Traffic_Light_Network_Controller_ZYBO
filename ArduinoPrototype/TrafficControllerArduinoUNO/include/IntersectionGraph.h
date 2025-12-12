#ifndef INTERSECTION_GRAPH_H
#define INTERSECTION_GRAPH_H

#include <stdint.h>
#include <stdbool.h>

#define MAX_LANE_CNT 32
#define MAX_CONNECTION_CNT 20
#define MAX_PHASE_CNT 10
#define MAX_CONNS_PER_PHASE 16 

// Represents a single lane
typedef struct {
    uint32_t id;          
    uint16_t car_count;
    // 'R'=Red, 'G'=Green, 'Y'=Yellow, 'N'=None/Downstream
    char current_light;   
} Lane;

// Represents a path from Upstream -> Downstream
typedef struct {
    uint32_t source_lane_idx; 
    uint32_t target_lane_idx; 
} Connection;

// Represents a Green Light state
typedef struct {
    int connection_indices[MAX_CONNS_PER_PHASE]; 
    int connection_count;
    uint32_t min_duration_ms;
} Phase;

// The main Intersection Object
typedef struct {
    Lane lanes[MAX_LANE_CNT];
    uint32_t lane_cnt;

    Connection connections[MAX_CONNECTION_CNT];
    uint32_t connection_cnt;

    Phase phases[MAX_PHASE_CNT];
    uint32_t phase_cnt;

    int current_phase_idx;
} Intersection;

void intersection_init(Intersection *intr);
int add_lane(Intersection *intr, uint32_t external_id);
int add_connection(Intersection *intr, int src_lane_idx, int tgt_lane_idx);
int add_phase(Intersection *intr, int conn_idxs[], int count, uint32_t min_duration_ms);
int get_lane_index_by_id(Intersection *intr, uint32_t id);
void parse_uart_packet(Intersection *intr, char* buffer);

#endif