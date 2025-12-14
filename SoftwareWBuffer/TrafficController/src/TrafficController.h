#ifndef TRAFFIC_H
#define TRAFFIC_H
#include "IntersectionGraph.h"
#include <stdint.h>
extern uint16_t global_simulation_time;
void run_traffic_controller(Intersection *intr);
void parse_traffic_values(Intersection *intr, uint8_t* string, uint8_t size);
void send_traffic_state(Intersection *intr, char INT_CHAR_ID);
void signal_pedestrian(Intersection *intr);
#endif