#include <Arduino.h>
#include <stdint.h>
#include "IntersectionGraph.h"
#include "IntersectionWest.h"
#include "TrafficController.h"
// we will recieve an array that will look like this:
// 0xFF(traffic_val_lane1)(traffic_val_lane2)(traffic_val_lane3)...0xFF
// 0xFF and 0 are reserved, so we can't use them
// each traffic value will be +1, so we have to substract before we update our values

// Serial buffer of an Arduino UNO is 64 bytes wide!! BUT WE WILL ONLY SEND 8 bytes at a time to simulate
// The Python server will send 7 actual values + one stop value(0)
// Our ZYBO UART buffer of only 8 bytes; we will construct the data
const uint8_t START_STOP_DELIMITER = 0xFF;
const int MAX_MESSAGE_SIZE = 64;

uint8_t traffic_string[MAX_MESSAGE_SIZE];
int traffic_string_idx = 0;

enum MessageState
{
    IDLE,
    IN_PROGRESS
};
MessageState current_state = IDLE;

volatile bool message_complete = false;

Intersection tl_west;

void uart_transmit_string(const uint8_t *msg, const size_t size)
{
    for(int i=0; i<size; i++){
        Serial.write(msg[i]);
    }
}



void setup()
{
    Serial.begin(9600);
    delay(2000);
    memset(traffic_string, 0, 64);
    pinMode(4, INPUT_PULLUP);
    init_tl_west(&tl_west);
}
void loop()
{
    if (message_complete)
    {
        //we will need to parse the values here
        //uart_transmit_string(traffic_string, traffic_string_idx);
        parse_traffic_values(&tl_west, traffic_string, traffic_string_idx);


        run_traffic_controller(&tl_west);
        send_traffic_state(&tl_west);
        traffic_string_idx = 0;
        message_complete = false;
        current_state = IDLE;
    }
    if(digitalRead(4) == 0){
        signal_pedestrian(&tl_west);
        // Serial.println("BUTTON PRESSED");
    }
}

void serialEvent()
{
    while (Serial.available())
    {
        uint8_t inByte = Serial.read();

        // State Machine Logic (Determines if the byte is a delimiter or data)
        switch (current_state)
        {

        case IDLE:
            if (inByte == START_STOP_DELIMITER)
            {
                // Found the START delimiter (0xFF)
                current_state = IN_PROGRESS;
                traffic_string_idx = 0; // Reset buffer for new message
                memset(traffic_string, 0, 64);
            }
            break;

        case IN_PROGRESS:

            if (inByte == START_STOP_DELIMITER)
            {
                // Found the STOP delimiter (0xFF)
                // Message is complete! Signal loop()
                message_complete = true;
                // Note: State remains IN_PROGRESS until loop() processes it and resets to IDLE
            }
            else if (traffic_string_idx < MAX_MESSAGE_SIZE - 1)
            {
                // 3. Receive Data and Apply Correction (Value is NOT a delimiter)

                // Apply the encoding logic: actual_value = raw_value - 1
                uint8_t corrected_value = inByte - 1;

                traffic_string[traffic_string_idx++] = corrected_value;
            }
            else
            {
                current_state = IDLE; // Abandon current message
                traffic_string_idx = 0;
            }
            break;
        }
    }
}