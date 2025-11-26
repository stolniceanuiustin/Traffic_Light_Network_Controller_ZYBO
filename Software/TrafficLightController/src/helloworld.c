#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"

XGpio GpioTxData;
XGpio GpioTxStart;
XGpio GpioTxRdy;
XGpio GpioRxData;
XGpio GpioRxRdy;

#define CYCLES_PER_MS 100000000

int init_gpio() {
  int Status;

  Status = XGpio_Initialize(&GpioTxData, XPAR_AXI_GPIO_TX_DATA_BASEADDR);
  if (Status != XST_SUCCESS)
    xil_printf("FAILED 0!");
  XGpio_SetDataDirection(&GpioTxData, 1, 0x00); // 0=Out

  Status = XGpio_Initialize(&GpioTxStart, XPAR_AXI_GPIO_TX_START_BASEADDR);
  if (Status != XST_SUCCESS)
    xil_printf("FAILED 1!");
  XGpio_SetDataDirection(&GpioTxStart, 1, 0x00);

  Status = XGpio_Initialize(&GpioTxRdy, XPAR_AXI_GPIO_TX_RDY_BASEADDR);
  if (Status != XST_SUCCESS)
    xil_printf("FAILED 2!");

  Status = XGpio_Initialize(&GpioRxData, XPAR_AXI_GPIO_RX_DATA_BASEADDR);
  if (Status != XST_SUCCESS)
    xil_printf("FAILED 3!");
  XGpio_SetDataDirection(&GpioRxData, 1, 0xFF);
  Status = XGpio_Initialize(&GpioRxRdy, XPAR_AXI_GPIO_RX_READY_BASEADDR);
  if (Status != XST_SUCCESS)
    xil_printf("FAILED 4!");
  XGpio_SetDataDirection(&GpioRxData, 1, 0b1);

  return XST_SUCCESS;
}


// void delay_ms(uint32_t ms) {
//     volatile uint32_t cycles = (CYCLES_PER_MS / 100) * ms; 
//     for(volatile uint32_t i = 0; i < cycles; i++);
// }


void uart_transmit_byte(uint8_t data) {
    uint32_t tx_ready_raw;
    
    do {
        tx_ready_raw = XGpio_DiscreteRead(&GpioTxRdy, 1);
    } while (tx_ready_raw == 0);

    XGpio_DiscreteWrite(&GpioTxData, 1, data);

    // D. Pulse the TX Start Signal (Low -> High -> Low)
    XGpio_DiscreteWrite(&GpioTxStart, 1, 1);
    for(volatile int i=0; i<20000; i++)
        ; 
    
    XGpio_DiscreteWrite(&GpioTxStart, 1, 0);
}


void transmit_hello_periodically() {
    const char *message = "hello\r\n";
    for (int i = 0; message[i] != '\0'; i++) {
        uart_transmit_byte(message[i]);
    }
}

int main() {
  // Changed u32 to uint32_t
  uint32_t rx_data = 0;
  uint32_t rx_ready_raw = 0;
  uint32_t tx_ready_raw = 0;

  uint32_t prev_rx_flag = 0;

  uint32_t counter = 0;

  xil_printf("--- UART Echo Test Start (9600 Baud) ---\r\n");

  if (init_gpio() != XST_SUCCESS) {
    xil_printf("GPIO Initialization Failed\r\n");
    return XST_FAILURE;
  }

  // Ensure Start bit starts Low
  XGpio_DiscreteWrite(&GpioTxStart, 1, 0);

  while (1) {
    rx_ready_raw = XGpio_DiscreteRead(&GpioRxRdy, 1);

    if (rx_ready_raw == 1 && prev_rx_flag == 0) {

      rx_data = XGpio_DiscreteRead(&GpioRxData, 1);

      // Optional: Print to debug console
      xil_printf("Recv: 0x%02x\r\n", rx_data);



    //   // C. Write the data to the TX Data GPIO
    //   XGpio_DiscreteWrite(&GpioTxData, 1, rx_data);

    //   // D. Pulse the TX Start Signal (Low -> High -> Low)
    //   XGpio_DiscreteWrite(&GpioTxStart, 1, 1);

    //   // Small software delay to ensure pulse width is detected by FPGA logic
    //   for (volatile int i = 0; i < 500; i++)
    //     ;

    //   XGpio_DiscreteWrite(&GpioTxStart, 1, 0);
    }

    // 3. Update previous state for the next loop iteration
    prev_rx_flag = rx_ready_raw;

    if (counter >= 10000000) { 
             xil_printf("Sending periodic message...\r\n");
             transmit_hello_periodically();
             counter = 0; 
        }
        counter++;
  }

  return 0;
}