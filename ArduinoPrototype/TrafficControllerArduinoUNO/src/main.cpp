#include <Arduino.h>
#include <stdint.h>

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

void setup()
{
    Serial.begin(9600);
    delay(2000);
    memset(traffic_string, 0, 64);
    Serial.println("Setup ready. Waiting for 8byte chunks on serial port");
}
void loop()
{
    if (message_complete)
    {

        Serial.println("\n--- MESSAGE RECEIVED ---");
        Serial.print("Total Assembled Size: ");
        Serial.println(traffic_string_idx);

        // The traffic_string now contains  only the data we need
        // traffic_string[0] to [traffic_string_index] = Data (corrected: value - 1)

        for (int i = 0; i <= 100; i++)
        {
            Serial.print("Corrected Values: ");
            for (int i = 0; i < traffic_string_idx; i++)
            {
                Serial.print((uint32_t)traffic_string[i]);
                Serial.print(" ");
            }
            Serial.println();
            delay(100);
        }
        traffic_string_idx = 0;
        message_complete = false;
        current_state = IDLE;
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

                Serial.println("START frame detected. Receiving data...");
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
                // Buffer Overflow Safety Check. Should never get here
                Serial.println("ERROR: Message too large. Buffer overflow!");
                current_state = IDLE; // Abandon current message
                traffic_string_idx = 0;
            }
            break;
        }
    }
}