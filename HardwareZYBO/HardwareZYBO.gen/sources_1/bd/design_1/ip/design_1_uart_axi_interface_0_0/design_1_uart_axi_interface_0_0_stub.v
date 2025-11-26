// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Wed Nov 26 16:26:23 2025
// Host        : Iustin-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/ProiectSSC/HardwareZYBO/HardwareZYBO.gen/sources_1/bd/design_1/ip/design_1_uart_axi_interface_0_0/design_1_uart_axi_interface_0_0_stub.v
// Design      : design_1_uart_axi_interface_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_uart_axi_interface_0_0,uart_axi_interface,{}" *) (* core_generation_info = "design_1_uart_axi_interface_0_0,uart_axi_interface,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=uart_axi_interface,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* ip_definition_source = "module_ref" *) (* x_core_info = "uart_axi_interface,Vivado 2024.2" *) 
module design_1_uart_axi_interface_0_0(clk, rx_pin, tx_pin, gpio_tx_data, gpio_tx_start, 
  gpio_rx_data, gpio_rx_ready, gpio_tx_rdy)
/* synthesis syn_black_box black_box_pad_pin="rx_pin,tx_pin,gpio_tx_data[7:0],gpio_tx_start,gpio_rx_data[7:0],gpio_rx_ready,gpio_tx_rdy" */
/* synthesis syn_force_seq_prim="clk" */;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_mode = "slave clk" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk /* synthesis syn_isclock = 1 */;
  input rx_pin;
  output tx_pin;
  input [7:0]gpio_tx_data;
  input gpio_tx_start;
  output [7:0]gpio_rx_data;
  output gpio_rx_ready;
  output gpio_tx_rdy;
endmodule
