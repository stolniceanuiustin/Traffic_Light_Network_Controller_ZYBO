#include "HAL.h"
#include "xadcps.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"
#define XADC_DEVICE_ID 0
#define CH_VAUX14 30

typedef uint8_t byte;

XGpio GpioBtns, GpioSws, GpioLeds;
XGpio GpioTxData, GpioTxStart, GpioTxRdy;
XGpio GpioRxData, GpioRxRdy, GpioRxEn;
XAdcPs_Config *xadc_cfg;
XAdcPs xadc_ctl;
// XADC - for future data sending
int init_xadc() {
  xadc_cfg = XAdcPs_LookupConfig(XADC_DEVICE_ID);
  if (!xadc_cfg)
    return XST_FAILURE;
  if (XAdcPs_CfgInitialize(&xadc_ctl, xadc_cfg, xadc_cfg->BaseAddress) !=
      XST_SUCCESS)
    return XST_FAILURE;
  XAdcPs_SetSequencerMode(&xadc_ctl, XADCPS_SEQ_MODE_SAFE);
  XAdcPs_SetSeqChEnables(&xadc_ctl, (1 << CH_VAUX14));
  XAdcPs_SetSequencerMode(&xadc_ctl, XADCPS_SEQ_MODE_CONTINPASS);
  return XST_SUCCESS;
}

int init_gpio() {
  int Status;
  Status = XGpio_Initialize(&GpioTxData, XPAR_AXI_GPIO_TX_DATA_BASEADDR);
  if (Status != XST_SUCCESS)
    return XST_FAILURE;
  XGpio_SetDataDirection(&GpioTxData, 1, 0x00);
  Status = XGpio_Initialize(&GpioTxStart, XPAR_AXI_GPIO_TX_START_BASEADDR);
  if (Status != XST_SUCCESS)
    return XST_FAILURE;
  XGpio_SetDataDirection(&GpioTxStart, 1, 0x00);
  Status = XGpio_Initialize(&GpioTxRdy, XPAR_AXI_GPIO_TX_RDY_BASEADDR);
  if (Status != XST_SUCCESS)
    return XST_FAILURE;
  Status = XGpio_Initialize(&GpioRxData, XPAR_AXI_GPIO_RX_DATA_BASEADDR);
  if (Status != XST_SUCCESS)
    return XST_FAILURE;
  XGpio_SetDataDirection(&GpioRxData, 1, 0xFF);
  Status = XGpio_Initialize(&GpioRxRdy, XPAR_AXI_GPIO_RX_READY_BASEADDR);
  if (Status != XST_SUCCESS)
    return XST_FAILURE;
    XGpio_SetDataDirection(&GpioRxRdy, 1, 0xFF);
  Status = XGpio_Initialize(&GpioRxEn, XPAR_AXI_GPIO_RX_EN_BASEADDR);
  if (Status != XST_SUCCESS)
    return XST_FAILURE;
  XGpio_SetDataDirection(&GpioRxEn, 1, 0x00);
  
  Status = XGpio_Initialize(&GpioBtns, XPAR_AXI_GPIO_BTNS_BASEADDR);
  if (Status != XST_SUCCESS)
    return XST_FAILURE;
  XGpio_SetDataDirection(&GpioBtns, 1, 0xFF);
  Status = XGpio_Initialize(&GpioSws, XPAR_AXI_GPIO_SWS_BASEADDR);
  if (Status != XST_SUCCESS)
    return XST_FAILURE;
  XGpio_SetDataDirection(&GpioSws, 1, 0xFF);
    return XST_SUCCESS;
}

// Helper function that sends one byte of data via UART
void serial_write(uint8_t data) {
  uint32_t tx_ready_raw;

  do {
    tx_ready_raw = XGpio_DiscreteRead(&GpioTxRdy, 1);
  } while (tx_ready_raw == 0);

  XGpio_DiscreteWrite(&GpioTxData, 1, data);

  // D. Pulse the TX Start Signal (Low -> High -> Low)
  XGpio_DiscreteWrite(&GpioTxStart, 1, 1);
  for (volatile int i = 0; i < 20000; i++)
    ;

  XGpio_DiscreteWrite(&GpioTxStart, 1, 0);
}

void uart_transmit_string(const uint8_t *msg, const size_t size) {
  for (int i = 0; i < size; i++) {
    serial_write(msg[i]);
  }
}

bool serial_available() { return XGpio_DiscreteRead(&GpioRxRdy, 1); }

// Reads a byte.
byte serial_read() {
  byte data = (byte)XGpio_DiscreteRead(&GpioRxData, 1);

  // this pops an element for the buffer for the next
  XGpio_DiscreteWrite(&GpioRxEn, 1, 1);
  XGpio_DiscreteWrite(&GpioRxEn, 1, 0);

  return data;
}

uint16_t map(uint16_t x, uint16_t in_min, uint16_t in_max, uint16_t out_min, uint16_t out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

uint16_t read_potentiometer() {
  uint16_t raw_value = XAdcPs_GetAdcData(&xadc_ctl, CH_VAUX14);
  return map(raw_value, 0, 4095, 0, 127);
}

uint8_t digital_read(uint8_t btn_id) { 
    uint8_t raw_data = XGpio_DiscreteRead(&GpioBtns, 1);
    return (raw_data >> btn_id) & 1;
}

uint8_t intersection_to_pin[2] = {0, 1};


bool ped_btn_is_pressed(Intersection_ID intr) {
  return digital_read(intersection_to_pin[intr]) == 1;
}

bool switch_is_pressed(int switch_cnt){
    return (XGpio_DiscreteRead(&GpioSws, 1) >> switch_cnt) & 1;
}
