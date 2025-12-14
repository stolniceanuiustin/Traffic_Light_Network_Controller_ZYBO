#ifndef HAL_H
#define HAL_H
#include <Arduino.h>
#include <TrafficController.h>
/*
This Hardware Abstraction Layer attempts to make this code compatible across any embedded device, 
provided it also comes with a similar HAL! This one is for Arduino UNO
*/
enum Intersection_ID {
    TL_WEST,
    TL_EAST
};

const uint8_t intersection_to_pin[2] = {4, 5};

void uart_transmit_string(const uint8_t *msg, const size_t size);
bool ped_btn_is_pressed(Intersection_ID intr);
#endif