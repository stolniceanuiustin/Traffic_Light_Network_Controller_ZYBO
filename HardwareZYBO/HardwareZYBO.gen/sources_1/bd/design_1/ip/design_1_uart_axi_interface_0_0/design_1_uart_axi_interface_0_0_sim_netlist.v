// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Wed Nov 26 16:26:23 2025
// Host        : Iustin-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/ProiectSSC/HardwareZYBO/HardwareZYBO.gen/sources_1/bd/design_1/ip/design_1_uart_axi_interface_0_0/design_1_uart_axi_interface_0_0_sim_netlist.v
// Design      : design_1_uart_axi_interface_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_uart_axi_interface_0_0,uart_axi_interface,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "uart_axi_interface,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module design_1_uart_axi_interface_0_0
   (clk,
    rx_pin,
    tx_pin,
    gpio_tx_data,
    gpio_tx_start,
    gpio_rx_data,
    gpio_rx_ready,
    gpio_tx_rdy);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_mode = "slave clk" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk;
  input rx_pin;
  output tx_pin;
  input [7:0]gpio_tx_data;
  input gpio_tx_start;
  output [7:0]gpio_rx_data;
  output gpio_rx_ready;
  output gpio_tx_rdy;

  wire clk;
  wire [7:0]gpio_rx_data;
  wire gpio_rx_ready;
  wire [7:0]gpio_tx_data;
  wire gpio_tx_rdy;
  wire gpio_tx_start;
  wire rx_pin;
  wire tx_pin;

  design_1_uart_axi_interface_0_0_uart_axi_interface U0
       (.clk(clk),
        .gpio_rx_data(gpio_rx_data),
        .gpio_rx_ready(gpio_rx_ready),
        .gpio_tx_data(gpio_tx_data),
        .gpio_tx_rdy(gpio_tx_rdy),
        .gpio_tx_start(gpio_tx_start),
        .rx_pin(rx_pin),
        .tx_pin(tx_pin));
endmodule

(* ORIG_REF_NAME = "receivefsm" *) 
module design_1_uart_axi_interface_0_0_receivefsm
   (gpio_rx_data,
    gpio_rx_ready,
    clk,
    \bit_cnt_reg[0]_0 ,
    rx_pin);
  output [7:0]gpio_rx_data;
  output gpio_rx_ready;
  input clk;
  input \bit_cnt_reg[0]_0 ;
  input rx_pin;

  wire baud_cnt0;
  wire \baud_cnt[0]_i_1_n_0 ;
  wire \baud_cnt[1]_i_1_n_0 ;
  wire \baud_cnt[1]_i_2_n_0 ;
  wire \baud_cnt[2]_i_1_n_0 ;
  wire \baud_cnt[3]_i_2_n_0 ;
  wire \baud_cnt[3]_i_3_n_0 ;
  wire \baud_cnt_reg_n_0_[0] ;
  wire \baud_cnt_reg_n_0_[1] ;
  wire \baud_cnt_reg_n_0_[2] ;
  wire \baud_cnt_reg_n_0_[3] ;
  wire [2:0]bit_cnt;
  wire bit_cnt0;
  wire \bit_cnt[0]_i_1_n_0 ;
  wire \bit_cnt[0]_i_2_n_0 ;
  wire \bit_cnt[1]_i_1_n_0 ;
  wire \bit_cnt[2]_i_1_n_0 ;
  wire \bit_cnt_reg[0]_0 ;
  wire clk;
  wire [7:0]gpio_rx_data;
  wire gpio_rx_ready;
  wire \rx_data[0]_i_1_n_0 ;
  wire \rx_data[1]_i_1_n_0 ;
  wire \rx_data[2]_i_1_n_0 ;
  wire \rx_data[3]_i_1_n_0 ;
  wire \rx_data[4]_i_1_n_0 ;
  wire \rx_data[5]_i_1_n_0 ;
  wire \rx_data[6]_i_1_n_0 ;
  wire \rx_data[7]_i_1_n_0 ;
  wire \rx_data[7]_i_2_n_0 ;
  wire rx_pin;
  wire [0:0]state;
  wire \state[0]_i_1_n_0 ;
  wire \state[1]_i_1_n_0 ;
  wire \state[1]_i_2_n_0 ;
  wire \state[1]_i_3_n_0 ;
  wire \state[1]_i_4_n_0 ;
  wire \state[2]_i_1_n_0 ;
  wire \state[2]_i_2_n_0 ;
  wire \state_reg_n_0_[0] ;
  wire \state_reg_n_0_[1] ;
  wire \state_reg_n_0_[2] ;

  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h0F0F0F02)) 
    \baud_cnt[0]_i_1 
       (.I0(\state_reg_n_0_[0] ),
        .I1(\baud_cnt_reg_n_0_[3] ),
        .I2(\baud_cnt_reg_n_0_[0] ),
        .I3(\state_reg_n_0_[1] ),
        .I4(\state_reg_n_0_[2] ),
        .O(\baud_cnt[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000EEFEEEFE0000)) 
    \baud_cnt[1]_i_1 
       (.I0(\state_reg_n_0_[1] ),
        .I1(\state_reg_n_0_[2] ),
        .I2(\state_reg_n_0_[0] ),
        .I3(\baud_cnt[1]_i_2_n_0 ),
        .I4(\baud_cnt_reg_n_0_[1] ),
        .I5(\baud_cnt_reg_n_0_[0] ),
        .O(\baud_cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hEAAA)) 
    \baud_cnt[1]_i_2 
       (.I0(\baud_cnt_reg_n_0_[3] ),
        .I1(\baud_cnt_reg_n_0_[2] ),
        .I2(\baud_cnt_reg_n_0_[0] ),
        .I3(\baud_cnt_reg_n_0_[1] ),
        .O(\baud_cnt[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00AEAE00AE00AE00)) 
    \baud_cnt[2]_i_1 
       (.I0(\baud_cnt[3]_i_3_n_0 ),
        .I1(\state_reg_n_0_[0] ),
        .I2(\baud_cnt_reg_n_0_[3] ),
        .I3(\baud_cnt_reg_n_0_[2] ),
        .I4(\baud_cnt_reg_n_0_[0] ),
        .I5(\baud_cnt_reg_n_0_[1] ),
        .O(\baud_cnt[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h1100DF00)) 
    \baud_cnt[3]_i_1 
       (.I0(\state_reg_n_0_[0] ),
        .I1(\state_reg_n_0_[1] ),
        .I2(rx_pin),
        .I3(\bit_cnt_reg[0]_0 ),
        .I4(\state_reg_n_0_[2] ),
        .O(baud_cnt0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h28888888)) 
    \baud_cnt[3]_i_2 
       (.I0(\baud_cnt[3]_i_3_n_0 ),
        .I1(\baud_cnt_reg_n_0_[3] ),
        .I2(\baud_cnt_reg_n_0_[1] ),
        .I3(\baud_cnt_reg_n_0_[0] ),
        .I4(\baud_cnt_reg_n_0_[2] ),
        .O(\baud_cnt[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \baud_cnt[3]_i_3 
       (.I0(\state_reg_n_0_[1] ),
        .I1(\state_reg_n_0_[2] ),
        .O(\baud_cnt[3]_i_3_n_0 ));
  FDRE \baud_cnt_reg[0] 
       (.C(clk),
        .CE(baud_cnt0),
        .D(\baud_cnt[0]_i_1_n_0 ),
        .Q(\baud_cnt_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \baud_cnt_reg[1] 
       (.C(clk),
        .CE(baud_cnt0),
        .D(\baud_cnt[1]_i_1_n_0 ),
        .Q(\baud_cnt_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \baud_cnt_reg[2] 
       (.C(clk),
        .CE(baud_cnt0),
        .D(\baud_cnt[2]_i_1_n_0 ),
        .Q(\baud_cnt_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \baud_cnt_reg[3] 
       (.C(clk),
        .CE(baud_cnt0),
        .D(\baud_cnt[3]_i_2_n_0 ),
        .Q(\baud_cnt_reg_n_0_[3] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFDFDFD00000200)) 
    \bit_cnt[0]_i_1 
       (.I0(\bit_cnt_reg[0]_0 ),
        .I1(\state_reg_n_0_[0] ),
        .I2(\state_reg_n_0_[2] ),
        .I3(\state_reg_n_0_[1] ),
        .I4(\bit_cnt[0]_i_2_n_0 ),
        .I5(bit_cnt[0]),
        .O(\bit_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    \bit_cnt[0]_i_2 
       (.I0(\baud_cnt_reg_n_0_[2] ),
        .I1(\baud_cnt_reg_n_0_[0] ),
        .I2(\baud_cnt_reg_n_0_[1] ),
        .I3(\baud_cnt_reg_n_0_[3] ),
        .O(\bit_cnt[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h2F80)) 
    \bit_cnt[1]_i_1 
       (.I0(\state_reg_n_0_[1] ),
        .I1(bit_cnt[0]),
        .I2(bit_cnt0),
        .I3(bit_cnt[1]),
        .O(\bit_cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h2AFF8000)) 
    \bit_cnt[2]_i_1 
       (.I0(\state_reg_n_0_[1] ),
        .I1(bit_cnt[0]),
        .I2(bit_cnt[1]),
        .I3(bit_cnt0),
        .I4(bit_cnt[2]),
        .O(\bit_cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00020202)) 
    \bit_cnt[2]_i_2 
       (.I0(\bit_cnt_reg[0]_0 ),
        .I1(\state_reg_n_0_[0] ),
        .I2(\state_reg_n_0_[2] ),
        .I3(\state_reg_n_0_[1] ),
        .I4(\bit_cnt[0]_i_2_n_0 ),
        .O(bit_cnt0));
  FDRE \bit_cnt_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\bit_cnt[0]_i_1_n_0 ),
        .Q(bit_cnt[0]),
        .R(1'b0));
  FDRE \bit_cnt_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\bit_cnt[1]_i_1_n_0 ),
        .Q(bit_cnt[1]),
        .R(1'b0));
  FDRE \bit_cnt_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\bit_cnt[2]_i_1_n_0 ),
        .Q(bit_cnt[2]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h8)) 
    gpio_rx_ready_INST_0
       (.I0(\state_reg_n_0_[1] ),
        .I1(\state_reg_n_0_[0] ),
        .O(gpio_rx_ready));
  LUT6 #(
    .INIT(64'hFFFEFFFF00020000)) 
    \rx_data[0]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[2]),
        .I2(bit_cnt[1]),
        .I3(bit_cnt[0]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(gpio_rx_data[0]),
        .O(\rx_data[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \rx_data[1]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[0]),
        .I2(bit_cnt[1]),
        .I3(bit_cnt[2]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(gpio_rx_data[1]),
        .O(\rx_data[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \rx_data[2]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[2]),
        .I2(bit_cnt[1]),
        .I3(bit_cnt[0]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(gpio_rx_data[2]),
        .O(\rx_data[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEFFFFFFF20000000)) 
    \rx_data[3]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[2]),
        .I2(bit_cnt[0]),
        .I3(bit_cnt[1]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(gpio_rx_data[3]),
        .O(\rx_data[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \rx_data[4]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[1]),
        .I2(bit_cnt[2]),
        .I3(bit_cnt[0]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(gpio_rx_data[4]),
        .O(\rx_data[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFBFFFFF00800000)) 
    \rx_data[5]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[0]),
        .I2(bit_cnt[2]),
        .I3(bit_cnt[1]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(gpio_rx_data[5]),
        .O(\rx_data[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFBFFFFF00800000)) 
    \rx_data[6]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[2]),
        .I2(bit_cnt[1]),
        .I3(bit_cnt[0]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(gpio_rx_data[6]),
        .O(\rx_data[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBFFFFFFF80000000)) 
    \rx_data[7]_i_1 
       (.I0(rx_pin),
        .I1(\rx_data[7]_i_2_n_0 ),
        .I2(bit_cnt[2]),
        .I3(bit_cnt[0]),
        .I4(bit_cnt[1]),
        .I5(gpio_rx_data[7]),
        .O(\rx_data[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h01000000)) 
    \rx_data[7]_i_2 
       (.I0(\bit_cnt[0]_i_2_n_0 ),
        .I1(\state_reg_n_0_[2] ),
        .I2(\state_reg_n_0_[0] ),
        .I3(\state_reg_n_0_[1] ),
        .I4(\bit_cnt_reg[0]_0 ),
        .O(\rx_data[7]_i_2_n_0 ));
  FDRE \rx_data_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[0]_i_1_n_0 ),
        .Q(gpio_rx_data[0]),
        .R(1'b0));
  FDRE \rx_data_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[1]_i_1_n_0 ),
        .Q(gpio_rx_data[1]),
        .R(1'b0));
  FDRE \rx_data_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[2]_i_1_n_0 ),
        .Q(gpio_rx_data[2]),
        .R(1'b0));
  FDRE \rx_data_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[3]_i_1_n_0 ),
        .Q(gpio_rx_data[3]),
        .R(1'b0));
  FDRE \rx_data_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[4]_i_1_n_0 ),
        .Q(gpio_rx_data[4]),
        .R(1'b0));
  FDRE \rx_data_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[5]_i_1_n_0 ),
        .Q(gpio_rx_data[5]),
        .R(1'b0));
  FDRE \rx_data_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[6]_i_1_n_0 ),
        .Q(gpio_rx_data[6]),
        .R(1'b0));
  FDRE \rx_data_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[7]_i_1_n_0 ),
        .Q(gpio_rx_data[7]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \state[0]_i_1 
       (.I0(state),
        .I1(\bit_cnt_reg[0]_0 ),
        .I2(\state_reg_n_0_[0] ),
        .O(\state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000300C040055)) 
    \state[0]_i_2 
       (.I0(rx_pin),
        .I1(\state[1]_i_4_n_0 ),
        .I2(\baud_cnt_reg_n_0_[3] ),
        .I3(\state_reg_n_0_[1] ),
        .I4(\state_reg_n_0_[0] ),
        .I5(\state_reg_n_0_[2] ),
        .O(state));
  LUT6 #(
    .INIT(64'hFFC8FFFFFFC80000)) 
    \state[1]_i_1 
       (.I0(\state[2]_i_2_n_0 ),
        .I1(\state[1]_i_2_n_0 ),
        .I2(\bit_cnt[0]_i_2_n_0 ),
        .I3(\state[1]_i_3_n_0 ),
        .I4(\bit_cnt_reg[0]_0 ),
        .I5(\state_reg_n_0_[1] ),
        .O(\state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \state[1]_i_2 
       (.I0(\state_reg_n_0_[2] ),
        .I1(\state_reg_n_0_[0] ),
        .I2(\state_reg_n_0_[1] ),
        .O(\state[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0010041422220010)) 
    \state[1]_i_3 
       (.I0(\state_reg_n_0_[1] ),
        .I1(\state_reg_n_0_[2] ),
        .I2(\state_reg_n_0_[0] ),
        .I3(rx_pin),
        .I4(\state[1]_i_4_n_0 ),
        .I5(\baud_cnt_reg_n_0_[3] ),
        .O(\state[1]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \state[1]_i_4 
       (.I0(\baud_cnt_reg_n_0_[1] ),
        .I1(\baud_cnt_reg_n_0_[0] ),
        .I2(\baud_cnt_reg_n_0_[2] ),
        .O(\state[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0300FFFF00040000)) 
    \state[2]_i_1 
       (.I0(\state[2]_i_2_n_0 ),
        .I1(\state_reg_n_0_[1] ),
        .I2(\state_reg_n_0_[0] ),
        .I3(\bit_cnt[0]_i_2_n_0 ),
        .I4(\bit_cnt_reg[0]_0 ),
        .I5(\state_reg_n_0_[2] ),
        .O(\state[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h7F)) 
    \state[2]_i_2 
       (.I0(bit_cnt[1]),
        .I1(bit_cnt[0]),
        .I2(bit_cnt[2]),
        .O(\state[2]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\state[0]_i_1_n_0 ),
        .Q(\state_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \state_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\state[1]_i_1_n_0 ),
        .Q(\state_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \state_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\state[2]_i_1_n_0 ),
        .Q(\state_reg_n_0_[2] ),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "transmitfsm" *) 
module design_1_uart_axi_interface_0_0_transmitfsm
   (gpio_tx_rdy,
    tx_pin,
    baud_en,
    clk,
    gpio_tx_start,
    gpio_tx_data);
  output gpio_tx_rdy;
  output tx_pin;
  input baud_en;
  input clk;
  input gpio_tx_start;
  input [7:0]gpio_tx_data;

  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire baud_en;
  wire \bit_cnt[0]_i_1_n_0 ;
  wire \bit_cnt[1]_i_1_n_0 ;
  wire \bit_cnt[2]_i_1_n_0 ;
  wire \bit_cnt_reg_n_0_[0] ;
  wire \bit_cnt_reg_n_0_[1] ;
  wire \bit_cnt_reg_n_0_[2] ;
  wire clk;
  wire [7:0]gpio_tx_data;
  wire gpio_tx_rdy;
  wire gpio_tx_start;
  wire [1:0]state;
  wire [0:0]state__0;
  wire tx_pin;
  wire tx_pin_INST_0_i_1_n_0;
  wire tx_pin_INST_0_i_2_n_0;

  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(state__0),
        .I1(baud_en),
        .I2(state[0]),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000E2222222)) 
    \FSM_sequential_state[0]_i_2 
       (.I0(gpio_tx_start),
        .I1(state[1]),
        .I2(\bit_cnt_reg_n_0_[1] ),
        .I3(\bit_cnt_reg_n_0_[0] ),
        .I4(\bit_cnt_reg_n_0_[2] ),
        .I5(state[0]),
        .O(state__0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(state[0]),
        .I1(baud_en),
        .I2(state[1]),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "idle:00,start:01,stop:11,bits:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state[0]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "idle:00,start:01,stop:11,bits:10" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(state[1]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hF308)) 
    \bit_cnt[0]_i_1 
       (.I0(state[1]),
        .I1(baud_en),
        .I2(state[0]),
        .I3(\bit_cnt_reg_n_0_[0] ),
        .O(\bit_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hFF2F0080)) 
    \bit_cnt[1]_i_1 
       (.I0(state[1]),
        .I1(\bit_cnt_reg_n_0_[0] ),
        .I2(baud_en),
        .I3(state[0]),
        .I4(\bit_cnt_reg_n_0_[1] ),
        .O(\bit_cnt[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF2AFF00008000)) 
    \bit_cnt[2]_i_1 
       (.I0(state[1]),
        .I1(\bit_cnt_reg_n_0_[1] ),
        .I2(\bit_cnt_reg_n_0_[0] ),
        .I3(baud_en),
        .I4(state[0]),
        .I5(\bit_cnt_reg_n_0_[2] ),
        .O(\bit_cnt[2]_i_1_n_0 ));
  FDRE \bit_cnt_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\bit_cnt[0]_i_1_n_0 ),
        .Q(\bit_cnt_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \bit_cnt_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\bit_cnt[1]_i_1_n_0 ),
        .Q(\bit_cnt_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \bit_cnt_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\bit_cnt[2]_i_1_n_0 ),
        .Q(\bit_cnt_reg_n_0_[2] ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h1)) 
    gpio_tx_rdy_INST_0
       (.I0(state[0]),
        .I1(state[1]),
        .O(gpio_tx_rdy));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'hFF00B8FF)) 
    tx_pin_INST_0
       (.I0(tx_pin_INST_0_i_1_n_0),
        .I1(\bit_cnt_reg_n_0_[2] ),
        .I2(tx_pin_INST_0_i_2_n_0),
        .I3(state[1]),
        .I4(state[0]),
        .O(tx_pin));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    tx_pin_INST_0_i_1
       (.I0(gpio_tx_data[7]),
        .I1(gpio_tx_data[6]),
        .I2(\bit_cnt_reg_n_0_[1] ),
        .I3(gpio_tx_data[5]),
        .I4(\bit_cnt_reg_n_0_[0] ),
        .I5(gpio_tx_data[4]),
        .O(tx_pin_INST_0_i_1_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    tx_pin_INST_0_i_2
       (.I0(gpio_tx_data[3]),
        .I1(gpio_tx_data[2]),
        .I2(\bit_cnt_reg_n_0_[1] ),
        .I3(gpio_tx_data[1]),
        .I4(\bit_cnt_reg_n_0_[0] ),
        .I5(gpio_tx_data[0]),
        .O(tx_pin_INST_0_i_2_n_0));
endmodule

(* ORIG_REF_NAME = "uart_axi_interface" *) 
module design_1_uart_axi_interface_0_0_uart_axi_interface
   (gpio_rx_data,
    gpio_tx_rdy,
    tx_pin,
    gpio_rx_ready,
    clk,
    rx_pin,
    gpio_tx_start,
    gpio_tx_data);
  output [7:0]gpio_rx_data;
  output gpio_tx_rdy;
  output tx_pin;
  output gpio_rx_ready;
  input clk;
  input rx_pin;
  input gpio_tx_start;
  input [7:0]gpio_tx_data;

  wire baud_en;
  wire baud_en_i_2_n_0;
  wire baud_en_i_3_n_0;
  wire baud_en_x16_i_1_n_0;
  wire baud_en_x16_i_2_n_0;
  wire baud_en_x16_reg_n_0;
  wire clk;
  wire \cnt[0]_i_2_n_0 ;
  wire [13:0]cnt_reg;
  wire \cnt_reg[0]_i_1_n_0 ;
  wire \cnt_reg[0]_i_1_n_1 ;
  wire \cnt_reg[0]_i_1_n_2 ;
  wire \cnt_reg[0]_i_1_n_3 ;
  wire \cnt_reg[0]_i_1_n_4 ;
  wire \cnt_reg[0]_i_1_n_5 ;
  wire \cnt_reg[0]_i_1_n_6 ;
  wire \cnt_reg[0]_i_1_n_7 ;
  wire \cnt_reg[12]_i_1_n_3 ;
  wire \cnt_reg[12]_i_1_n_6 ;
  wire \cnt_reg[12]_i_1_n_7 ;
  wire \cnt_reg[4]_i_1_n_0 ;
  wire \cnt_reg[4]_i_1_n_1 ;
  wire \cnt_reg[4]_i_1_n_2 ;
  wire \cnt_reg[4]_i_1_n_3 ;
  wire \cnt_reg[4]_i_1_n_4 ;
  wire \cnt_reg[4]_i_1_n_5 ;
  wire \cnt_reg[4]_i_1_n_6 ;
  wire \cnt_reg[4]_i_1_n_7 ;
  wire \cnt_reg[8]_i_1_n_0 ;
  wire \cnt_reg[8]_i_1_n_1 ;
  wire \cnt_reg[8]_i_1_n_2 ;
  wire \cnt_reg[8]_i_1_n_3 ;
  wire \cnt_reg[8]_i_1_n_4 ;
  wire \cnt_reg[8]_i_1_n_5 ;
  wire \cnt_reg[8]_i_1_n_6 ;
  wire \cnt_reg[8]_i_1_n_7 ;
  wire \cnt_x16[9]_i_2_n_0 ;
  wire [9:0]cnt_x16_reg;
  wire eqOp;
  wire [7:0]gpio_rx_data;
  wire gpio_rx_ready;
  wire [7:0]gpio_tx_data;
  wire gpio_tx_rdy;
  wire gpio_tx_start;
  wire [9:0]plusOp;
  wire rx_pin;
  wire tx_pin;
  wire [3:1]\NLW_cnt_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_cnt_reg[12]_i_1_O_UNCONNECTED ;

  LUT4 #(
    .INIT(16'h8000)) 
    baud_en_i_1
       (.I0(baud_en_i_2_n_0),
        .I1(cnt_reg[0]),
        .I2(cnt_reg[1]),
        .I3(baud_en_i_3_n_0),
        .O(eqOp));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    baud_en_i_2
       (.I0(cnt_reg[11]),
        .I1(cnt_reg[10]),
        .I2(cnt_reg[8]),
        .I3(cnt_reg[9]),
        .I4(cnt_reg[12]),
        .I5(cnt_reg[13]),
        .O(baud_en_i_2_n_0));
  LUT6 #(
    .INIT(64'h0000200000000000)) 
    baud_en_i_3
       (.I0(cnt_reg[5]),
        .I1(cnt_reg[4]),
        .I2(cnt_reg[2]),
        .I3(cnt_reg[3]),
        .I4(cnt_reg[6]),
        .I5(cnt_reg[7]),
        .O(baud_en_i_3_n_0));
  FDRE baud_en_reg
       (.C(clk),
        .CE(1'b1),
        .D(eqOp),
        .Q(baud_en),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00200000)) 
    baud_en_x16_i_1
       (.I0(cnt_x16_reg[3]),
        .I1(cnt_x16_reg[2]),
        .I2(cnt_x16_reg[1]),
        .I3(cnt_x16_reg[0]),
        .I4(baud_en_x16_i_2_n_0),
        .O(baud_en_x16_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    baud_en_x16_i_2
       (.I0(cnt_x16_reg[7]),
        .I1(cnt_x16_reg[6]),
        .I2(cnt_x16_reg[4]),
        .I3(cnt_x16_reg[5]),
        .I4(cnt_x16_reg[8]),
        .I5(cnt_x16_reg[9]),
        .O(baud_en_x16_i_2_n_0));
  FDRE baud_en_x16_reg
       (.C(clk),
        .CE(1'b1),
        .D(baud_en_x16_i_1_n_0),
        .Q(baud_en_x16_reg_n_0),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \cnt[0]_i_2 
       (.I0(cnt_reg[0]),
        .O(\cnt[0]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[0]_i_1_n_7 ),
        .Q(cnt_reg[0]),
        .R(eqOp));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \cnt_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\cnt_reg[0]_i_1_n_0 ,\cnt_reg[0]_i_1_n_1 ,\cnt_reg[0]_i_1_n_2 ,\cnt_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\cnt_reg[0]_i_1_n_4 ,\cnt_reg[0]_i_1_n_5 ,\cnt_reg[0]_i_1_n_6 ,\cnt_reg[0]_i_1_n_7 }),
        .S({cnt_reg[3:1],\cnt[0]_i_2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[8]_i_1_n_5 ),
        .Q(cnt_reg[10]),
        .R(eqOp));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[8]_i_1_n_4 ),
        .Q(cnt_reg[11]),
        .R(eqOp));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[12]_i_1_n_7 ),
        .Q(cnt_reg[12]),
        .R(eqOp));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \cnt_reg[12]_i_1 
       (.CI(\cnt_reg[8]_i_1_n_0 ),
        .CO({\NLW_cnt_reg[12]_i_1_CO_UNCONNECTED [3:1],\cnt_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_cnt_reg[12]_i_1_O_UNCONNECTED [3:2],\cnt_reg[12]_i_1_n_6 ,\cnt_reg[12]_i_1_n_7 }),
        .S({1'b0,1'b0,cnt_reg[13:12]}));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[12]_i_1_n_6 ),
        .Q(cnt_reg[13]),
        .R(eqOp));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[0]_i_1_n_6 ),
        .Q(cnt_reg[1]),
        .R(eqOp));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[0]_i_1_n_5 ),
        .Q(cnt_reg[2]),
        .R(eqOp));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[0]_i_1_n_4 ),
        .Q(cnt_reg[3]),
        .R(eqOp));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[4]_i_1_n_7 ),
        .Q(cnt_reg[4]),
        .R(eqOp));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \cnt_reg[4]_i_1 
       (.CI(\cnt_reg[0]_i_1_n_0 ),
        .CO({\cnt_reg[4]_i_1_n_0 ,\cnt_reg[4]_i_1_n_1 ,\cnt_reg[4]_i_1_n_2 ,\cnt_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cnt_reg[4]_i_1_n_4 ,\cnt_reg[4]_i_1_n_5 ,\cnt_reg[4]_i_1_n_6 ,\cnt_reg[4]_i_1_n_7 }),
        .S(cnt_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[4]_i_1_n_6 ),
        .Q(cnt_reg[5]),
        .R(eqOp));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[4]_i_1_n_5 ),
        .Q(cnt_reg[6]),
        .R(eqOp));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[4]_i_1_n_4 ),
        .Q(cnt_reg[7]),
        .R(eqOp));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[8]_i_1_n_7 ),
        .Q(cnt_reg[8]),
        .R(eqOp));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \cnt_reg[8]_i_1 
       (.CI(\cnt_reg[4]_i_1_n_0 ),
        .CO({\cnt_reg[8]_i_1_n_0 ,\cnt_reg[8]_i_1_n_1 ,\cnt_reg[8]_i_1_n_2 ,\cnt_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\cnt_reg[8]_i_1_n_4 ,\cnt_reg[8]_i_1_n_5 ,\cnt_reg[8]_i_1_n_6 ,\cnt_reg[8]_i_1_n_7 }),
        .S(cnt_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(\cnt_reg[8]_i_1_n_6 ),
        .Q(cnt_reg[9]),
        .R(eqOp));
  LUT1 #(
    .INIT(2'h1)) 
    \cnt_x16[0]_i_1 
       (.I0(cnt_x16_reg[0]),
        .O(plusOp[0]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \cnt_x16[1]_i_1 
       (.I0(cnt_x16_reg[0]),
        .I1(cnt_x16_reg[1]),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \cnt_x16[2]_i_1 
       (.I0(cnt_x16_reg[1]),
        .I1(cnt_x16_reg[0]),
        .I2(cnt_x16_reg[2]),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \cnt_x16[3]_i_1 
       (.I0(cnt_x16_reg[2]),
        .I1(cnt_x16_reg[0]),
        .I2(cnt_x16_reg[1]),
        .I3(cnt_x16_reg[3]),
        .O(plusOp[3]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \cnt_x16[4]_i_1 
       (.I0(cnt_x16_reg[3]),
        .I1(cnt_x16_reg[1]),
        .I2(cnt_x16_reg[0]),
        .I3(cnt_x16_reg[2]),
        .I4(cnt_x16_reg[4]),
        .O(plusOp[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \cnt_x16[5]_i_1 
       (.I0(cnt_x16_reg[4]),
        .I1(cnt_x16_reg[2]),
        .I2(cnt_x16_reg[0]),
        .I3(cnt_x16_reg[1]),
        .I4(cnt_x16_reg[3]),
        .I5(cnt_x16_reg[5]),
        .O(plusOp[5]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \cnt_x16[6]_i_1 
       (.I0(\cnt_x16[9]_i_2_n_0 ),
        .I1(cnt_x16_reg[6]),
        .O(plusOp[6]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \cnt_x16[7]_i_1 
       (.I0(cnt_x16_reg[6]),
        .I1(\cnt_x16[9]_i_2_n_0 ),
        .I2(cnt_x16_reg[7]),
        .O(plusOp[7]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hDF20)) 
    \cnt_x16[8]_i_1 
       (.I0(cnt_x16_reg[7]),
        .I1(\cnt_x16[9]_i_2_n_0 ),
        .I2(cnt_x16_reg[6]),
        .I3(cnt_x16_reg[8]),
        .O(plusOp[8]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'hF7FF0800)) 
    \cnt_x16[9]_i_1 
       (.I0(cnt_x16_reg[8]),
        .I1(cnt_x16_reg[6]),
        .I2(\cnt_x16[9]_i_2_n_0 ),
        .I3(cnt_x16_reg[7]),
        .I4(cnt_x16_reg[9]),
        .O(plusOp[9]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \cnt_x16[9]_i_2 
       (.I0(cnt_x16_reg[4]),
        .I1(cnt_x16_reg[2]),
        .I2(cnt_x16_reg[0]),
        .I3(cnt_x16_reg[1]),
        .I4(cnt_x16_reg[3]),
        .I5(cnt_x16_reg[5]),
        .O(\cnt_x16[9]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_x16_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(plusOp[0]),
        .Q(cnt_x16_reg[0]),
        .R(baud_en_x16_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_x16_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(plusOp[1]),
        .Q(cnt_x16_reg[1]),
        .R(baud_en_x16_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_x16_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(plusOp[2]),
        .Q(cnt_x16_reg[2]),
        .R(baud_en_x16_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_x16_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(plusOp[3]),
        .Q(cnt_x16_reg[3]),
        .R(baud_en_x16_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_x16_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(plusOp[4]),
        .Q(cnt_x16_reg[4]),
        .R(baud_en_x16_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_x16_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(plusOp[5]),
        .Q(cnt_x16_reg[5]),
        .R(baud_en_x16_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_x16_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(plusOp[6]),
        .Q(cnt_x16_reg[6]),
        .R(baud_en_x16_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_x16_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(plusOp[7]),
        .Q(cnt_x16_reg[7]),
        .R(baud_en_x16_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_x16_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(plusOp[8]),
        .Q(cnt_x16_reg[8]),
        .R(baud_en_x16_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_x16_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(plusOp[9]),
        .Q(cnt_x16_reg[9]),
        .R(baud_en_x16_i_1_n_0));
  design_1_uart_axi_interface_0_0_receivefsm inst_RFSM
       (.\bit_cnt_reg[0]_0 (baud_en_x16_reg_n_0),
        .clk(clk),
        .gpio_rx_data(gpio_rx_data),
        .gpio_rx_ready(gpio_rx_ready),
        .rx_pin(rx_pin));
  design_1_uart_axi_interface_0_0_transmitfsm inst_TFSM
       (.baud_en(baud_en),
        .clk(clk),
        .gpio_tx_data(gpio_tx_data),
        .gpio_tx_rdy(gpio_tx_rdy),
        .gpio_tx_start(gpio_tx_start),
        .tx_pin(tx_pin));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
