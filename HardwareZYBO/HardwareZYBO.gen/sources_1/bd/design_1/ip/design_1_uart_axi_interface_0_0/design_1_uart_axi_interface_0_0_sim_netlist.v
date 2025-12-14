// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Sun Dec 14 17:26:47 2025
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
    gpio_rx_en,
    gpio_rx_data,
    gpio_rx_ready,
    gpio_tx_rdy);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_mode = "slave clk" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk;
  input rx_pin;
  output tx_pin;
  input [7:0]gpio_tx_data;
  input gpio_tx_start;
  input gpio_rx_en;
  output [7:0]gpio_rx_data;
  output gpio_rx_ready;
  output gpio_tx_rdy;

  wire clk;
  wire [7:0]gpio_rx_data;
  wire gpio_rx_en;
  wire gpio_rx_ready;
  wire [7:0]gpio_tx_data;
  wire gpio_tx_rdy;
  wire gpio_tx_start;
  wire rx_pin;
  wire tx_pin;

  design_1_uart_axi_interface_0_0_uart_axi_interface U0
       (.clk(clk),
        .gpio_rx_data(gpio_rx_data),
        .gpio_rx_en(gpio_rx_en),
        .gpio_rx_ready(gpio_rx_ready),
        .gpio_tx_data(gpio_tx_data),
        .gpio_tx_rdy(gpio_tx_rdy),
        .gpio_tx_start(gpio_tx_start),
        .rx_pin(rx_pin),
        .tx_pin(tx_pin));
endmodule

(* ORIG_REF_NAME = "receivefsm" *) 
module design_1_uart_axi_interface_0_0_receivefsm
   (fifo_wr_ptr,
    E,
    rx_ready_q_reg,
    rx_ready,
    D,
    rx_data,
    Q,
    rx_ready_q,
    rx_pin,
    \bit_cnt_reg[0]_0 ,
    \fifo_count_reg[0] ,
    \fifo_count_reg[0]_0 ,
    DI,
    S,
    \fifo_count_reg[6] ,
    clk);
  output fifo_wr_ptr;
  output [0:0]E;
  output [0:0]rx_ready_q_reg;
  output rx_ready;
  output [5:0]D;
  output [7:0]rx_data;
  input [5:0]Q;
  input rx_ready_q;
  input rx_pin;
  input \bit_cnt_reg[0]_0 ;
  input \fifo_count_reg[0] ;
  input \fifo_count_reg[0]_0 ;
  input [0:0]DI;
  input [2:0]S;
  input [1:0]\fifo_count_reg[6] ;
  input clk;

  wire [5:0]D;
  wire [0:0]DI;
  wire [0:0]E;
  wire [5:0]Q;
  wire [2:0]S;
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
  wire \fifo_count[4]_i_6_n_0 ;
  wire \fifo_count_reg[0] ;
  wire \fifo_count_reg[0]_0 ;
  wire \fifo_count_reg[4]_i_1_n_0 ;
  wire \fifo_count_reg[4]_i_1_n_1 ;
  wire \fifo_count_reg[4]_i_1_n_2 ;
  wire \fifo_count_reg[4]_i_1_n_3 ;
  wire [1:0]\fifo_count_reg[6] ;
  wire \fifo_count_reg[6]_i_2_n_3 ;
  wire fifo_wr_ptr;
  wire [7:0]rx_data;
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
  wire rx_ready;
  wire rx_ready_q;
  wire [0:0]rx_ready_q_reg;
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
  wire [3:1]\NLW_fifo_count_reg[6]_i_2_CO_UNCONNECTED ;
  wire [3:2]\NLW_fifo_count_reg[6]_i_2_O_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair1" *) 
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
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
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
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
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
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h2F80)) 
    \bit_cnt[1]_i_1 
       (.I0(\state_reg_n_0_[1] ),
        .I1(bit_cnt[0]),
        .I2(bit_cnt0),
        .I3(bit_cnt[1]),
        .O(\bit_cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h2AFF8000)) 
    \bit_cnt[2]_i_1 
       (.I0(\state_reg_n_0_[1] ),
        .I1(bit_cnt[0]),
        .I2(bit_cnt[1]),
        .I3(bit_cnt0),
        .I4(bit_cnt[2]),
        .O(\bit_cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
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
  LUT5 #(
    .INIT(32'h55556555)) 
    \fifo_count[4]_i_6 
       (.I0(Q[1]),
        .I1(Q[5]),
        .I2(\state_reg_n_0_[1] ),
        .I3(\state_reg_n_0_[0] ),
        .I4(rx_ready_q),
        .O(\fifo_count[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h00400040FFBFFF40)) 
    \fifo_count[6]_i_1 
       (.I0(rx_ready_q),
        .I1(\state_reg_n_0_[0] ),
        .I2(\state_reg_n_0_[1] ),
        .I3(Q[5]),
        .I4(\fifo_count_reg[0] ),
        .I5(\fifo_count_reg[0]_0 ),
        .O(E));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \fifo_count_reg[4]_i_1 
       (.CI(1'b0),
        .CO({\fifo_count_reg[4]_i_1_n_0 ,\fifo_count_reg[4]_i_1_n_1 ,\fifo_count_reg[4]_i_1_n_2 ,\fifo_count_reg[4]_i_1_n_3 }),
        .CYINIT(Q[0]),
        .DI({Q[3:1],DI}),
        .O(D[3:0]),
        .S({S,\fifo_count[4]_i_6_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \fifo_count_reg[6]_i_2 
       (.CI(\fifo_count_reg[4]_i_1_n_0 ),
        .CO({\NLW_fifo_count_reg[6]_i_2_CO_UNCONNECTED [3:1],\fifo_count_reg[6]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,Q[4]}),
        .O({\NLW_fifo_count_reg[6]_i_2_O_UNCONNECTED [3:2],D[5:4]}),
        .S({1'b0,1'b0,\fifo_count_reg[6] }));
  LUT4 #(
    .INIT(16'h0040)) 
    fifo_mem_reg_0_63_0_2_i_1
       (.I0(rx_ready_q),
        .I1(\state_reg_n_0_[0] ),
        .I2(\state_reg_n_0_[1] ),
        .I3(Q[5]),
        .O(fifo_wr_ptr));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h0040)) 
    \fifo_wr_ptr[5]_i_1 
       (.I0(rx_ready_q),
        .I1(\state_reg_n_0_[0] ),
        .I2(\state_reg_n_0_[1] ),
        .I3(Q[5]),
        .O(rx_ready_q_reg));
  LUT6 #(
    .INIT(64'hFFFEFFFF00020000)) 
    \rx_data[0]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[2]),
        .I2(bit_cnt[1]),
        .I3(bit_cnt[0]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(rx_data[0]),
        .O(\rx_data[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFF00080000)) 
    \rx_data[1]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[0]),
        .I2(bit_cnt[1]),
        .I3(bit_cnt[2]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(rx_data[1]),
        .O(\rx_data[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \rx_data[2]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[2]),
        .I2(bit_cnt[1]),
        .I3(bit_cnt[0]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(rx_data[2]),
        .O(\rx_data[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEFFFFFFF20000000)) 
    \rx_data[3]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[2]),
        .I2(bit_cnt[0]),
        .I3(bit_cnt[1]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(rx_data[3]),
        .O(\rx_data[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFEFFFFF00200000)) 
    \rx_data[4]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[1]),
        .I2(bit_cnt[2]),
        .I3(bit_cnt[0]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(rx_data[4]),
        .O(\rx_data[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFBFFFFF00800000)) 
    \rx_data[5]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[0]),
        .I2(bit_cnt[2]),
        .I3(bit_cnt[1]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(rx_data[5]),
        .O(\rx_data[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFBFFFFF00800000)) 
    \rx_data[6]_i_1 
       (.I0(rx_pin),
        .I1(bit_cnt[2]),
        .I2(bit_cnt[1]),
        .I3(bit_cnt[0]),
        .I4(\rx_data[7]_i_2_n_0 ),
        .I5(rx_data[6]),
        .O(\rx_data[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBFFFFFFF80000000)) 
    \rx_data[7]_i_1 
       (.I0(rx_pin),
        .I1(\rx_data[7]_i_2_n_0 ),
        .I2(bit_cnt[2]),
        .I3(bit_cnt[0]),
        .I4(bit_cnt[1]),
        .I5(rx_data[7]),
        .O(\rx_data[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
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
        .Q(rx_data[0]),
        .R(1'b0));
  FDRE \rx_data_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[1]_i_1_n_0 ),
        .Q(rx_data[1]),
        .R(1'b0));
  FDRE \rx_data_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[2]_i_1_n_0 ),
        .Q(rx_data[2]),
        .R(1'b0));
  FDRE \rx_data_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[3]_i_1_n_0 ),
        .Q(rx_data[3]),
        .R(1'b0));
  FDRE \rx_data_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[4]_i_1_n_0 ),
        .Q(rx_data[4]),
        .R(1'b0));
  FDRE \rx_data_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[5]_i_1_n_0 ),
        .Q(rx_data[5]),
        .R(1'b0));
  FDRE \rx_data_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[6]_i_1_n_0 ),
        .Q(rx_data[6]),
        .R(1'b0));
  FDRE \rx_data_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(\rx_data[7]_i_1_n_0 ),
        .Q(rx_data[7]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h8)) 
    rx_ready_q_i_1
       (.I0(\state_reg_n_0_[1] ),
        .I1(\state_reg_n_0_[0] ),
        .O(rx_ready));
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
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
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
    gpio_rx_en,
    clk,
    rx_pin,
    gpio_tx_start,
    gpio_tx_data);
  output [7:0]gpio_rx_data;
  output gpio_tx_rdy;
  output tx_pin;
  output gpio_rx_ready;
  input gpio_rx_en;
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
  wire fifo_count;
  wire \fifo_count[0]_i_1_n_0 ;
  wire \fifo_count[4]_i_2_n_0 ;
  wire \fifo_count[4]_i_3_n_0 ;
  wire \fifo_count[4]_i_4_n_0 ;
  wire \fifo_count[4]_i_5_n_0 ;
  wire \fifo_count[6]_i_3_n_0 ;
  wire \fifo_count[6]_i_4_n_0 ;
  wire \fifo_count[6]_i_5_n_0 ;
  wire [6:0]fifo_count_reg;
  wire [5:0]fifo_rd_ptr;
  wire \fifo_rd_ptr_rep[5]_i_1_n_0 ;
  wire fifo_wr_ptr;
  wire [5:0]fifo_wr_ptr_reg;
  wire [7:0]gpio_rx_data;
  wire [7:0]gpio_rx_data0;
  wire \gpio_rx_data[7]_INST_0_i_1_n_0 ;
  wire gpio_rx_en;
  wire gpio_rx_ready;
  wire [7:0]gpio_tx_data;
  wire gpio_tx_rdy;
  wire gpio_tx_start;
  wire inst_RFSM_n_2;
  wire inst_RFSM_n_4;
  wire inst_RFSM_n_5;
  wire inst_RFSM_n_6;
  wire inst_RFSM_n_7;
  wire inst_RFSM_n_8;
  wire inst_RFSM_n_9;
  wire [5:0]p_1_out;
  wire [5:0]p_1_out__0;
  wire [9:0]plusOp;
  wire [7:0]rx_data;
  wire rx_en_q;
  wire rx_pin;
  wire rx_ready;
  wire rx_ready_q;
  wire tx_pin;
  wire [3:1]\NLW_cnt_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_cnt_reg[12]_i_1_O_UNCONNECTED ;
  wire NLW_fifo_mem_reg_0_63_0_2_DOD_UNCONNECTED;
  wire NLW_fifo_mem_reg_0_63_3_5_DOD_UNCONNECTED;
  wire NLW_fifo_mem_reg_0_63_6_7_DOC_UNCONNECTED;
  wire NLW_fifo_mem_reg_0_63_6_7_DOD_UNCONNECTED;

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
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \cnt_x16[1]_i_1 
       (.I0(cnt_x16_reg[0]),
        .I1(cnt_x16_reg[1]),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \cnt_x16[2]_i_1 
       (.I0(cnt_x16_reg[1]),
        .I1(cnt_x16_reg[0]),
        .I2(cnt_x16_reg[2]),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \cnt_x16[3]_i_1 
       (.I0(cnt_x16_reg[2]),
        .I1(cnt_x16_reg[0]),
        .I2(cnt_x16_reg[1]),
        .I3(cnt_x16_reg[3]),
        .O(plusOp[3]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
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
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \cnt_x16[6]_i_1 
       (.I0(\cnt_x16[9]_i_2_n_0 ),
        .I1(cnt_x16_reg[6]),
        .O(plusOp[6]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \cnt_x16[7]_i_1 
       (.I0(cnt_x16_reg[6]),
        .I1(\cnt_x16[9]_i_2_n_0 ),
        .I2(cnt_x16_reg[7]),
        .O(plusOp[7]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \cnt_x16[8]_i_1 
       (.I0(\cnt_x16[9]_i_2_n_0 ),
        .I1(cnt_x16_reg[6]),
        .I2(cnt_x16_reg[7]),
        .I3(cnt_x16_reg[8]),
        .O(plusOp[8]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \cnt_x16[9]_i_1 
       (.I0(\cnt_x16[9]_i_2_n_0 ),
        .I1(cnt_x16_reg[8]),
        .I2(cnt_x16_reg[7]),
        .I3(cnt_x16_reg[6]),
        .I4(cnt_x16_reg[9]),
        .O(plusOp[9]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
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
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_count[0]_i_1 
       (.I0(fifo_count_reg[0]),
        .O(\fifo_count[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_count[4]_i_2 
       (.I0(fifo_count_reg[1]),
        .O(\fifo_count[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \fifo_count[4]_i_3 
       (.I0(fifo_count_reg[3]),
        .I1(fifo_count_reg[4]),
        .O(\fifo_count[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \fifo_count[4]_i_4 
       (.I0(fifo_count_reg[2]),
        .I1(fifo_count_reg[3]),
        .O(\fifo_count[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \fifo_count[4]_i_5 
       (.I0(fifo_count_reg[1]),
        .I1(fifo_count_reg[2]),
        .O(\fifo_count[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \fifo_count[6]_i_3 
       (.I0(rx_en_q),
        .I1(gpio_rx_en),
        .O(\fifo_count[6]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \fifo_count[6]_i_4 
       (.I0(fifo_count_reg[5]),
        .I1(fifo_count_reg[6]),
        .O(\fifo_count[6]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \fifo_count[6]_i_5 
       (.I0(fifo_count_reg[4]),
        .I1(fifo_count_reg[5]),
        .O(\fifo_count[6]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_count_reg[0] 
       (.C(clk),
        .CE(fifo_count),
        .D(\fifo_count[0]_i_1_n_0 ),
        .Q(fifo_count_reg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_count_reg[1] 
       (.C(clk),
        .CE(fifo_count),
        .D(inst_RFSM_n_9),
        .Q(fifo_count_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_count_reg[2] 
       (.C(clk),
        .CE(fifo_count),
        .D(inst_RFSM_n_8),
        .Q(fifo_count_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_count_reg[3] 
       (.C(clk),
        .CE(fifo_count),
        .D(inst_RFSM_n_7),
        .Q(fifo_count_reg[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_count_reg[4] 
       (.C(clk),
        .CE(fifo_count),
        .D(inst_RFSM_n_6),
        .Q(fifo_count_reg[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_count_reg[5] 
       (.C(clk),
        .CE(fifo_count),
        .D(inst_RFSM_n_5),
        .Q(fifo_count_reg[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_count_reg[6] 
       (.C(clk),
        .CE(fifo_count),
        .D(inst_RFSM_n_4),
        .Q(fifo_count_reg[6]),
        .R(1'b0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "512" *) 
  (* RTL_RAM_NAME = "design_1_uart_axi_interface_0_0/U0/fifo_mem_reg" *) 
  (* RTL_RAM_STYLE = "auto" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "2" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    fifo_mem_reg_0_63_0_2
       (.ADDRA(fifo_rd_ptr),
        .ADDRB(fifo_rd_ptr),
        .ADDRC(fifo_rd_ptr),
        .ADDRD(fifo_wr_ptr_reg),
        .DIA(rx_data[0]),
        .DIB(rx_data[1]),
        .DIC(rx_data[2]),
        .DID(1'b0),
        .DOA(gpio_rx_data0[0]),
        .DOB(gpio_rx_data0[1]),
        .DOC(gpio_rx_data0[2]),
        .DOD(NLW_fifo_mem_reg_0_63_0_2_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(fifo_wr_ptr));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "512" *) 
  (* RTL_RAM_NAME = "design_1_uart_axi_interface_0_0/U0/fifo_mem_reg" *) 
  (* RTL_RAM_STYLE = "auto" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "5" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    fifo_mem_reg_0_63_3_5
       (.ADDRA(fifo_rd_ptr),
        .ADDRB(fifo_rd_ptr),
        .ADDRC(fifo_rd_ptr),
        .ADDRD(fifo_wr_ptr_reg),
        .DIA(rx_data[3]),
        .DIB(rx_data[4]),
        .DIC(rx_data[5]),
        .DID(1'b0),
        .DOA(gpio_rx_data0[3]),
        .DOB(gpio_rx_data0[4]),
        .DOC(gpio_rx_data0[5]),
        .DOD(NLW_fifo_mem_reg_0_63_3_5_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(fifo_wr_ptr));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "512" *) 
  (* RTL_RAM_NAME = "design_1_uart_axi_interface_0_0/U0/fifo_mem_reg" *) 
  (* RTL_RAM_STYLE = "auto" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "7" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    fifo_mem_reg_0_63_6_7
       (.ADDRA(fifo_rd_ptr),
        .ADDRB(fifo_rd_ptr),
        .ADDRC(fifo_rd_ptr),
        .ADDRD(fifo_wr_ptr_reg),
        .DIA(rx_data[6]),
        .DIB(rx_data[7]),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(gpio_rx_data0[6]),
        .DOB(gpio_rx_data0[7]),
        .DOC(NLW_fifo_mem_reg_0_63_6_7_DOC_UNCONNECTED),
        .DOD(NLW_fifo_mem_reg_0_63_6_7_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(fifo_wr_ptr));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_rd_ptr_reg_rep[0] 
       (.C(clk),
        .CE(\fifo_rd_ptr_rep[5]_i_1_n_0 ),
        .D(p_1_out__0[0]),
        .Q(fifo_rd_ptr[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_rd_ptr_reg_rep[1] 
       (.C(clk),
        .CE(\fifo_rd_ptr_rep[5]_i_1_n_0 ),
        .D(p_1_out__0[1]),
        .Q(fifo_rd_ptr[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_rd_ptr_reg_rep[2] 
       (.C(clk),
        .CE(\fifo_rd_ptr_rep[5]_i_1_n_0 ),
        .D(p_1_out__0[2]),
        .Q(fifo_rd_ptr[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_rd_ptr_reg_rep[3] 
       (.C(clk),
        .CE(\fifo_rd_ptr_rep[5]_i_1_n_0 ),
        .D(p_1_out__0[3]),
        .Q(fifo_rd_ptr[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_rd_ptr_reg_rep[4] 
       (.C(clk),
        .CE(\fifo_rd_ptr_rep[5]_i_1_n_0 ),
        .D(p_1_out__0[4]),
        .Q(fifo_rd_ptr[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_rd_ptr_reg_rep[5] 
       (.C(clk),
        .CE(\fifo_rd_ptr_rep[5]_i_1_n_0 ),
        .D(p_1_out__0[5]),
        .Q(fifo_rd_ptr[5]),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_rd_ptr_rep[0]_i_1 
       (.I0(fifo_rd_ptr[0]),
        .O(p_1_out__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \fifo_rd_ptr_rep[1]_i_1 
       (.I0(fifo_rd_ptr[0]),
        .I1(fifo_rd_ptr[1]),
        .O(p_1_out__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \fifo_rd_ptr_rep[2]_i_1 
       (.I0(fifo_rd_ptr[1]),
        .I1(fifo_rd_ptr[0]),
        .I2(fifo_rd_ptr[2]),
        .O(p_1_out__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \fifo_rd_ptr_rep[3]_i_1 
       (.I0(fifo_rd_ptr[2]),
        .I1(fifo_rd_ptr[0]),
        .I2(fifo_rd_ptr[1]),
        .I3(fifo_rd_ptr[3]),
        .O(p_1_out__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \fifo_rd_ptr_rep[4]_i_1 
       (.I0(fifo_rd_ptr[0]),
        .I1(fifo_rd_ptr[1]),
        .I2(fifo_rd_ptr[2]),
        .I3(fifo_rd_ptr[3]),
        .I4(fifo_rd_ptr[4]),
        .O(p_1_out__0[4]));
  LUT4 #(
    .INIT(16'h00E0)) 
    \fifo_rd_ptr_rep[5]_i_1 
       (.I0(\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .I1(fifo_count_reg[6]),
        .I2(gpio_rx_en),
        .I3(rx_en_q),
        .O(\fifo_rd_ptr_rep[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \fifo_rd_ptr_rep[5]_i_2 
       (.I0(fifo_rd_ptr[0]),
        .I1(fifo_rd_ptr[1]),
        .I2(fifo_rd_ptr[4]),
        .I3(fifo_rd_ptr[3]),
        .I4(fifo_rd_ptr[2]),
        .I5(fifo_rd_ptr[5]),
        .O(p_1_out__0[5]));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_wr_ptr[0]_i_1 
       (.I0(fifo_wr_ptr_reg[0]),
        .O(p_1_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \fifo_wr_ptr[1]_i_1 
       (.I0(fifo_wr_ptr_reg[0]),
        .I1(fifo_wr_ptr_reg[1]),
        .O(p_1_out[1]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \fifo_wr_ptr[2]_i_1 
       (.I0(fifo_wr_ptr_reg[1]),
        .I1(fifo_wr_ptr_reg[0]),
        .I2(fifo_wr_ptr_reg[2]),
        .O(p_1_out[2]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \fifo_wr_ptr[3]_i_1 
       (.I0(fifo_wr_ptr_reg[2]),
        .I1(fifo_wr_ptr_reg[0]),
        .I2(fifo_wr_ptr_reg[1]),
        .I3(fifo_wr_ptr_reg[3]),
        .O(p_1_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \fifo_wr_ptr[4]_i_1 
       (.I0(fifo_wr_ptr_reg[0]),
        .I1(fifo_wr_ptr_reg[1]),
        .I2(fifo_wr_ptr_reg[2]),
        .I3(fifo_wr_ptr_reg[3]),
        .I4(fifo_wr_ptr_reg[4]),
        .O(p_1_out[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \fifo_wr_ptr[5]_i_2 
       (.I0(fifo_wr_ptr_reg[0]),
        .I1(fifo_wr_ptr_reg[1]),
        .I2(fifo_wr_ptr_reg[4]),
        .I3(fifo_wr_ptr_reg[3]),
        .I4(fifo_wr_ptr_reg[2]),
        .I5(fifo_wr_ptr_reg[5]),
        .O(p_1_out[5]));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_wr_ptr_reg[0] 
       (.C(clk),
        .CE(inst_RFSM_n_2),
        .D(p_1_out[0]),
        .Q(fifo_wr_ptr_reg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_wr_ptr_reg[1] 
       (.C(clk),
        .CE(inst_RFSM_n_2),
        .D(p_1_out[1]),
        .Q(fifo_wr_ptr_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_wr_ptr_reg[2] 
       (.C(clk),
        .CE(inst_RFSM_n_2),
        .D(p_1_out[2]),
        .Q(fifo_wr_ptr_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_wr_ptr_reg[3] 
       (.C(clk),
        .CE(inst_RFSM_n_2),
        .D(p_1_out[3]),
        .Q(fifo_wr_ptr_reg[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_wr_ptr_reg[4] 
       (.C(clk),
        .CE(inst_RFSM_n_2),
        .D(p_1_out[4]),
        .Q(fifo_wr_ptr_reg[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \fifo_wr_ptr_reg[5] 
       (.C(clk),
        .CE(inst_RFSM_n_2),
        .D(p_1_out[5]),
        .Q(fifo_wr_ptr_reg[5]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hE0)) 
    \gpio_rx_data[0]_INST_0 
       (.I0(\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .I1(fifo_count_reg[6]),
        .I2(gpio_rx_data0[0]),
        .O(gpio_rx_data[0]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hE0)) 
    \gpio_rx_data[1]_INST_0 
       (.I0(\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .I1(fifo_count_reg[6]),
        .I2(gpio_rx_data0[1]),
        .O(gpio_rx_data[1]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hE0)) 
    \gpio_rx_data[2]_INST_0 
       (.I0(\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .I1(fifo_count_reg[6]),
        .I2(gpio_rx_data0[2]),
        .O(gpio_rx_data[2]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hE0)) 
    \gpio_rx_data[3]_INST_0 
       (.I0(\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .I1(fifo_count_reg[6]),
        .I2(gpio_rx_data0[3]),
        .O(gpio_rx_data[3]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hE0)) 
    \gpio_rx_data[4]_INST_0 
       (.I0(\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .I1(fifo_count_reg[6]),
        .I2(gpio_rx_data0[4]),
        .O(gpio_rx_data[4]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hE0)) 
    \gpio_rx_data[5]_INST_0 
       (.I0(\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .I1(fifo_count_reg[6]),
        .I2(gpio_rx_data0[5]),
        .O(gpio_rx_data[5]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hE0)) 
    \gpio_rx_data[6]_INST_0 
       (.I0(\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .I1(fifo_count_reg[6]),
        .I2(gpio_rx_data0[6]),
        .O(gpio_rx_data[6]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hE0)) 
    \gpio_rx_data[7]_INST_0 
       (.I0(\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .I1(fifo_count_reg[6]),
        .I2(gpio_rx_data0[7]),
        .O(gpio_rx_data[7]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \gpio_rx_data[7]_INST_0_i_1 
       (.I0(fifo_count_reg[4]),
        .I1(fifo_count_reg[5]),
        .I2(fifo_count_reg[2]),
        .I3(fifo_count_reg[3]),
        .I4(fifo_count_reg[1]),
        .I5(fifo_count_reg[0]),
        .O(\gpio_rx_data[7]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    gpio_rx_ready_INST_0
       (.I0(\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .I1(fifo_count_reg[6]),
        .O(gpio_rx_ready));
  design_1_uart_axi_interface_0_0_receivefsm inst_RFSM
       (.D({inst_RFSM_n_4,inst_RFSM_n_5,inst_RFSM_n_6,inst_RFSM_n_7,inst_RFSM_n_8,inst_RFSM_n_9}),
        .DI(\fifo_count[4]_i_2_n_0 ),
        .E(fifo_count),
        .Q({fifo_count_reg[6],fifo_count_reg[4:0]}),
        .S({\fifo_count[4]_i_3_n_0 ,\fifo_count[4]_i_4_n_0 ,\fifo_count[4]_i_5_n_0 }),
        .\bit_cnt_reg[0]_0 (baud_en_x16_reg_n_0),
        .clk(clk),
        .\fifo_count_reg[0] (\gpio_rx_data[7]_INST_0_i_1_n_0 ),
        .\fifo_count_reg[0]_0 (\fifo_count[6]_i_3_n_0 ),
        .\fifo_count_reg[6] ({\fifo_count[6]_i_4_n_0 ,\fifo_count[6]_i_5_n_0 }),
        .fifo_wr_ptr(fifo_wr_ptr),
        .rx_data(rx_data),
        .rx_pin(rx_pin),
        .rx_ready(rx_ready),
        .rx_ready_q(rx_ready_q),
        .rx_ready_q_reg(inst_RFSM_n_2));
  design_1_uart_axi_interface_0_0_transmitfsm inst_TFSM
       (.baud_en(baud_en),
        .clk(clk),
        .gpio_tx_data(gpio_tx_data),
        .gpio_tx_rdy(gpio_tx_rdy),
        .gpio_tx_start(gpio_tx_start),
        .tx_pin(tx_pin));
  FDRE rx_en_q_reg
       (.C(clk),
        .CE(1'b1),
        .D(gpio_rx_en),
        .Q(rx_en_q),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    rx_ready_q_reg
       (.C(clk),
        .CE(1'b1),
        .D(rx_ready),
        .Q(rx_ready_q),
        .R(1'b0));
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
