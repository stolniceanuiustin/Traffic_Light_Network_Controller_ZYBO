#include "IntersectionGraph.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void intersection_init(Intersection *intr) {
  if (!intr)
    return;
  memset(intr, 0, sizeof(Intersection));
  intr->lane_cnt = 0;
  intr->connection_cnt = 0;
  intr->phase_cnt = 0;
  intr->current_phase_idx = 0;

  // Clear memory (Optional but good for safety)
  memset(intr->lanes, 0, sizeof(intr->lanes));
  memset(intr->connections, 0, sizeof(intr->connections));
  memset(intr->phases, 0, sizeof(intr->phases));
}

// Adds a lane to the graph. Returns the internal index (0..MAX-1) or -1 on
// failure.
int add_lane(Intersection *intr, uint32_t external_id) {
  if (!intr || intr->lane_cnt >= MAX_LANE_CNT)
    return -1;

  // Check for duplicate IDs
  for (uint32_t i = 0; i < intr->lane_cnt; i++) {
    if (intr->lanes[i].id == external_id)
      return i; // Return existing
  }

  int idx = intr->lane_cnt;
  intr->lanes[idx].id = external_id;
  intr->lanes[idx].car_count = 0;
  intr->lane_cnt++;

  return idx;
}

// Adds a connection between two internal lane indices. Returns connection
// index.
int add_connection(Intersection *intr, int src_lane_idx, int tgt_lane_idx) {
  if (!intr || intr->connection_cnt >= MAX_CONNECTION_CNT)
    return -1;
  if (src_lane_idx >= (int)intr->lane_cnt ||
      tgt_lane_idx >= (int)intr->lane_cnt)
    return -1;

  int idx = intr->connection_cnt;
  intr->connections[idx].source_lane_idx = src_lane_idx;
  intr->connections[idx].target_lane_idx = tgt_lane_idx;
  intr->connection_cnt++;

  return idx;
}

// Adds a phase composed of multiple connection indices.
int add_phase(Intersection *intr, int conn_idxs[], int count,
              uint32_t min_duration_ms) {
  if (!intr || intr->phase_cnt >= MAX_PHASE_CNT)
    return -1;

  int idx = intr->phase_cnt;
  Phase *p = &intr->phases[idx];

  p->connection_count = 0;
  p->min_duration_ms = min_duration_ms;

  // Copy connection indices into the struct
  for (int i = 0; i < count; i++) {
    if (i < MAX_CONNS_PER_PHASE) {
      p->connection_indices[i] = conn_idxs[i];
      p->connection_count++;
    }
  }
  intr->phase_cnt++;
  return idx;
}

// Helper: Find internal index by external ID (e.g., ID 101 -> Index 0)
int get_lane_index_by_id(Intersection *intr, uint32_t id) {
  for (uint32_t i = 0; i < intr->lane_cnt; i++) {
    if (intr->lanes[i].id == id)
      return i;
  }
  return -1;
}


void parse_uart_packet(Intersection *intr, char *buffer) {
    // Expected Packet Layout:
    // buffer[0]  = Start Marker '$' (0x24)
    // buffer[1]  = Lane 0 Count + 1
    // buffer[2]  = Lane 1 Count + 1
    // ...
    // buffer[17] = Lane 16 Count + 1
    // buffer[18] = End Marker '$' (0x24)

    const int EXPECTED_DATA_BYTES = 17; // Lanes 0 through 16

    // 1. Validation: Check start marker
    if (buffer == NULL || buffer[0] != 0xFF) {
        printf("Error: Invalid packet start marker.\n");
        return;
    }

    // 2. Loop through the data bytes (from buffer[1] to buffer[17])
    for (int i = 0; i < EXPECTED_DATA_BYTES; i++) {
        // The lane ID corresponds to the loop counter 'i' (0 to 16)
        int lane_id = i;
        
        // The data byte is at offset i + 1 in the buffer.
        // We cast to uint8_t to ensure correct reading of raw byte data.
        uint8_t received_val = (uint8_t)buffer[i + 1];
        
        // --- Step B: Subtract 1 to get the true car count ---
        uint16_t car_count = (uint16_t)received_val - 1;
        
        // 3. Update the Lane in the Intersection structure
        int idx = get_lane_index_by_id(intr, lane_id);

        if (idx != -1) {
            intr->lanes[idx].car_count = car_count;

            printf("Updated Lane ID %d (Idx %d) to %d cars\n", lane_id, idx, car_count);
        } else {
            printf("Warning: Lane ID %d not found in graph\n", lane_id);
        }
    }
}
// Calculates MaxPressure = Sum(Source_Cars - Target_Cars) for all active
// connections
int calculate_phase_pressure(Intersection *intr, int phase_idx) {
  if (!intr || phase_idx >= (int)intr->phase_cnt)
    return -9999;

  Phase *p = &intr->phases[phase_idx];
  int total_pressure = 0;

  for (int i = 0; i < p->connection_count; i++) {
    int conn_idx = p->connection_indices[i];

    // Lookup the lanes involved in this connection
    int src_idx = intr->connections[conn_idx].source_lane_idx;
    int tgt_idx = intr->connections[conn_idx].target_lane_idx;

    int cars_in = intr->lanes[src_idx].car_count;
    int cars_out = intr->lanes[tgt_idx].car_count;

    // Pressure formula
    total_pressure += (cars_in - cars_out);
  }

  // Negative pressure is mathematically valid (downstream is full).
  return total_pressure;
}