#include "IntersectionGraph.h"
#include "IntersectionWest.h"
#include "xadcps.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"
#include <stdint.h>
#include <string.h>
#include <unistd.h>

// --- CONFIG ---
#define RX_BUFFER_SIZE 128
#define XADC_DEVICE_ID 0
#define CH_VAUX14 30

// --- CALIBRATION FOR 100MHz ---
// 100MHz = 10ns period. 1ms = 100,000 ticks.
// A loop takes approx 10-20 cycles.
// Start with 10000. Tune this if your seconds feel too fast/slow.
#define DELAY_1MS_COUNT 10000

// --- GLOBALS ---
XGpio GpioTxData, GpioTxStart, GpioTxRdy, GpioRxData, GpioRxRdy;
Intersection tl_west;
char rx_buf[RX_BUFFER_SIZE];
int rx_idx = 0;
int is_receiving_packet = 0;

// The "Global Clock"
volatile uint64_t system_ticks = 0;

static XAdcPs_Config *xadc_cfg;
static XAdcPs xadc_ctl;

// --- GPIO INIT ---
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
  XGpio_SetDataDirection(&GpioRxRdy, 1, 0x01);
  return XST_SUCCESS;
}

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

// UART
void uart_transmit_byte(uint8_t data) {
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

void uart_transmit_string(const char *msg) {
  while (*msg)
    uart_transmit_byte(*msg++);
}

// --- PROTOTYPE ---
void run_traffic_controller(Intersection *intr);
// ---------------- MAIN ----------------
int main() {
  uint32_t rx_ready_raw = 0;
  uint32_t prev_rx_flag = 0;

  // Non-blocking timer variables
  volatile uint64_t loop_counter = 0;
  const uint64_t CYCLES_PER_MS =
      DELAY_1MS_COUNT; // Using your existing calibration value

  init_gpio();
  init_xadc();
  init_tl_west(&tl_west);

  xil_printf("---- Max Pressure Controller (Non-Blocking) ---\r\n");

  while (1) {

    // 1. UART POLLING
    uint8_t rx_data;
    rx_ready_raw = XGpio_DiscreteRead(&GpioRxRdy, 1);

    if (rx_ready_raw == 1 && prev_rx_flag == 0) {
      // Read the incoming byte
      rx_data = XGpio_DiscreteRead(&GpioRxData, 1);

      // Optional: Print to debug console
      // xil_printf("Recieved: 0x%02x\r\n", rx_data);

      // --- Packet Building Logic ---
      if (rx_data == 0xFF) {
        if (!is_receiving_packet) {
          // Case 1: Start of a new packet ($)
          is_receiving_packet = 1;
          rx_idx = 0;
          // Store the start marker
          rx_buf[rx_idx++] = rx_data;
          xil_printf("Packet Start (Idx 0) \r\n");

        } else if (rx_idx == 19) {
          // Case 2: End of a complete packet ($), should be the 20th byte
          // (index 19)
          rx_buf[rx_idx++] = rx_data; // Store the end marker
          rx_buf[rx_idx] =
              '\0'; // Null-terminate the buffer (optional, but good practice)
          is_receiving_packet = 0; // Reset the flag

          // --- Packet Complete ---
          xil_printf("Packet End. Full Packet (%d bytes): ", rx_idx);
          for (int i = 0; i < rx_idx; i++) {
            xil_printf("0x%02x ", (uint8_t)rx_buf[i]);
          }
          xil_printf("\r\n");

          // You would call your parsing function here.
          // Note: Your original parse_uart_packet was designed for a text-based
          // format
          // ($1,10,2,5), not raw binary bytes. You'll need to adapt it
          // to this new fixed-length 18-byte format.
          // parse_fixed_binary_packet(&tl_west, rx_buf);

          // Reset for the next packet
          parse_uart_packet(&tl_west, rx_buf);
          rx_idx = 0;

        } else if (is_receiving_packet && rx_idx < 19) {
          // Case 3: Error - Received '$' too early (treat as normal data if
          // your protocol allows) For strict 20-byte protocol, this should be
          // treated as an error/reset
          xil_printf("ERROR: Premature '$' at index %d\r\n", rx_idx);
          is_receiving_packet = 0;
          rx_idx = 0;
        }

      } else if (is_receiving_packet && rx_idx < 19) {
        // Case 4: Receiving a data byte (Lane value)
        rx_buf[rx_idx++] = rx_data;
        // xil_printf("Data Recieved: 0x%02x (Idx %d)\r\n", rx_data, rx_idx -
        // 1);

      } else if (rx_idx >= RX_BUFFER_SIZE) {
        // Case 5: Buffer overflow (safety check)
        xil_printf("ERROR: Buffer Overflow.\r\n");
        is_receiving_packet = 0;
        rx_idx = 0;
      }
    }
    prev_rx_flag = rx_ready_raw;

    // 2. CONTROLLER LOGIC (Executes every loop iteration)
    run_traffic_controller(&tl_west);

    // 3. NON-BLOCKING TIME ADVANCEMENT
    // This keeps the loop running fast but only advances the system_ticks
    // when enough fast iterations have occurred, simulating a 1ms period.

    loop_counter++;

    if (loop_counter >= CYCLES_PER_MS) {
      system_ticks++;
      loop_counter = 0;

      // xil_printf("Tick: %llu\r\n", system_ticks);
    }
  }
  return 0;
}