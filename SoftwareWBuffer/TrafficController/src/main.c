#include "HAL.h"
#include "IntersectionEast.h"
#include "IntersectionGraph.h"
#include "IntersectionWest.h"
#include "TrafficController.h"
#include "xadcps.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#define MAX_MESSAGE_SIZE 64
const uint8_t START_STOP_DELIMITER = 0xFF;


uint8_t traffic_string[MAX_MESSAGE_SIZE];
int traffic_string_idx = 0;

int message_count = 0;

typedef enum { IDLE, IN_PROGRESS } MessageState;
MessageState current_state = IDLE;
volatile bool message_complete = false;

// --- GLOBALS ---
Intersection tl_west;
Intersection tl_east;

void setup() {
  init_gpio();
  init_xadc();
  init_tl_west(&tl_west);
  init_tl_east(&tl_east);
  xil_printf("---- Max Pressure Traffic Contorller ----\r\n");
}

void my_serial_event() {
  uint8_t inByte = serial_read();
  switch (current_state) {

  case IDLE:
    if (inByte == START_STOP_DELIMITER) {
      // Found the START delimiter (0xFF)
      current_state = IN_PROGRESS;
      traffic_string_idx = 0; // Reset buffer for new message
      memset(traffic_string, 0, 64);
    }
    break;

  case IN_PROGRESS:

    if (inByte == START_STOP_DELIMITER) {
      // Found the STOP delimiter (0xFF)
      // Message is complete! Signal loop()
      message_complete = true;
      message_count = (message_count + 1) % 2;
      // Note: State remains IN_PROGRESS until loop() processes it and resets
      // to IDLE
    } else if (traffic_string_idx < MAX_MESSAGE_SIZE - 1) {
      // 3. Receive Data and Apply Correction (Value is NOT a delimiter)

      // Apply the encoding logic: actual_value = raw_value - 1
      uint8_t corrected_value = inByte - 1;

      traffic_string[traffic_string_idx++] = corrected_value;
    } else {
      current_state = IDLE; // Abandon current message
      traffic_string_idx = 0;
    }
    break;
  }
}
void loop() {
  while (serial_available()) {
      my_serial_event();
  }
  if (message_complete)
    {
        // First we send traffic data for WEST intersection then for EAST intersection
        if (message_count == 0)
        {
            // we will need to parse the values here
            // uart_transmit_string(traffic_string, traffic_string_idx);
            parse_traffic_values(&tl_west, traffic_string, traffic_string_idx);

            run_traffic_controller(&tl_west, PEDESTRIAN_LANE_TL_WEST);
            send_traffic_state(&tl_west, 'W', 2);
        }
        else
        {
            parse_traffic_values(&tl_east, traffic_string, traffic_string_idx);
            run_traffic_controller(&tl_east, PEDESTRIAN_LANE_TL_EAST);
            send_traffic_state(&tl_east, 'E', 2);
        }
        traffic_string_idx = 0;
        message_complete = 0;
        current_state = IDLE;
    }
    
    if (ped_btn_is_pressed(TL_WEST))
    {
        signal_pedestrian(&tl_west, PEDESTRIAN_LANE_TL_WEST);
        // Serial.println("BUTTON PRESSED");
    }
    if(ped_btn_is_pressed(TL_EAST)){
        signal_pedestrian(&tl_east, PEDESTRIAN_LANE_TL_EAST);
    }
}

int main() {
  setup();
  for(;;)
  {
    loop();
  }
}
