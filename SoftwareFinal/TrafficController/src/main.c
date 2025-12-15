#include "HAL.h"
#include "IntersectionEast.h"
#include "IntersectionGraph.h"
#include "IntersectionWest.h"
#include "TrafficController.h"
#include "xadcps.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#define MAX_MESSAGE_SIZE 64
const uint8_t START_STOP_DELIMITER = 0xFF;

uint8_t traffic_string[MAX_MESSAGE_SIZE];
int traffic_string_idx = 0;

// 0 = Expecting West, 1 = Expecting East
int message_count = 0;

typedef enum { IDLE, IN_PROGRESS } MessageState;
MessageState current_state = IDLE;
volatile bool message_complete = false;

Intersection tl_west;
Intersection tl_east;

void setup() {
  xil_printf("---- Max Pressure Traffic Controller ----\r\n");
  init_gpio();
  init_xadc();
  init_tl_west(&tl_west);
  init_tl_east(&tl_east);
}

void my_serial_event() {
  uint8_t inByte = serial_read();

  switch (current_state) {
  case IDLE:
    if (inByte == START_STOP_DELIMITER) {
      current_state = IN_PROGRESS;
      traffic_string_idx = 0;
      memset(traffic_string, 0, MAX_MESSAGE_SIZE);
    }
    break;

  case IN_PROGRESS:
    if (inByte == START_STOP_DELIMITER) {
      message_complete = true;
      current_state = IDLE;
    } else if (traffic_string_idx < MAX_MESSAGE_SIZE - 1) {
      // Decode: 1-255 -> 0-254
      uint8_t corrected_value = inByte - 1;
      traffic_string[traffic_string_idx++] = corrected_value;
    } else {
      current_state = IDLE;
      traffic_string_idx = 0;
    }
    break;
  }
}

void loop() {
  while (serial_available()) {
    my_serial_event();
    if (message_complete)
      break;
  }

  if (message_complete) {
    if (switch_is_pressed(3)) {
      for (int i = 0; i < traffic_string_idx; i++) {
        xil_printf("%u ", (unsigned int)traffic_string[i]);
      }
      xil_printf("\r\n");
    }
    if (message_count == 0) {
      // --- WEST LOGIC ---
      parse_traffic_values(&tl_west, traffic_string, traffic_string_idx);
      run_traffic_controller(&tl_west, PEDESTRIAN_LANE_TL_WEST);
      send_traffic_state(&tl_west, 'W', 2);
    } else {
      // --- EAST LOGIC ---
      parse_traffic_values(&tl_east, traffic_string, traffic_string_idx);
      run_traffic_controller(&tl_east, PEDESTRIAN_LANE_TL_EAST);

      send_traffic_state(&tl_east, 'E', 2);
    }

    traffic_string_idx = 0;
    message_complete = false;
    message_count = (message_count + 1) % 2;
  }
//   if (ped_btn_is_pressed(TL_EAST)) {
//     xil_printf("PEDESTRIAN WANTS TO CROSS in EAST!");
//     signal_pedestrian(&tl_east, PEDESTRIAN_LANE_TL_EAST);
//   }
//   if (ped_btn_is_pressed(TL_WEST)) {
//     xil_printf("PEDESTRIAN WANTS TO CROSS in WEST!");
//     signal_pedestrian(&tl_west, PEDESTRIAN_LANE_TL_WEST);
//   }
}

int main() {
  setup();
  for (;;) {
    loop();
  }
}