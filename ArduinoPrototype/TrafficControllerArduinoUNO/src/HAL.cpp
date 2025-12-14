#include "HAL.h"


void uart_transmit_string(const uint8_t *msg, const size_t size)
{
    for (int i = 0; i < size; i++)
    {
        Serial.write(msg[i]);
    }
}

//assuming the button is on pin4 with a pullup resistence
bool ped_btn_is_pressed(Intersection_ID intr) {
    return digitalRead(intersection_to_pin[intr]) == 0;
}
