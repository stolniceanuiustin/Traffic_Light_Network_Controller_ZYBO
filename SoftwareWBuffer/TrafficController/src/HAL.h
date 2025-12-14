#ifndef HAL_H
#define HAL_H
#include "xadcps.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"
#include <stdint.h>
#include <stdbool.h>

typedef uint8_t byte;

int init_xadc();
int init_gpio();
void uart_transmit_string(const uint8_t *msg, const size_t size);
bool serial_available();
byte serial_read();
uint16_t read_potentiometer();

extern XGpio GpioTxData;
extern XGpio GpioTxStart; 
extern XGpio GpioTxRdy; 
extern XGpio GpioRxData;
extern XGpio GpioRxRdy;
extern XGpio GpioRxEn;
extern XAdcPs_Config *xadc_cfg;
extern XAdcPs xadc_ctl;

typedef enum {
    TL_WEST,
    TL_EAST
}Intersection_ID;

uint8_t digital_read(uint8_t btn_id);

bool ped_btn_is_pressed(Intersection_ID intr);
#endif