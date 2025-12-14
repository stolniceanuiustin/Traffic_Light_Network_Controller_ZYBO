-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
-- Date        : Sun Dec 14 17:26:47 2025
-- Host        : Iustin-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/ProiectSSC/HardwareZYBO/HardwareZYBO.gen/sources_1/bd/design_1/ip/design_1_uart_axi_interface_0_0/design_1_uart_axi_interface_0_0_sim_netlist.vhdl
-- Design      : design_1_uart_axi_interface_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_uart_axi_interface_0_0_receivefsm is
  port (
    fifo_wr_ptr : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    rx_ready_q_reg : out STD_LOGIC_VECTOR ( 0 to 0 );
    rx_ready : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 5 downto 0 );
    rx_data : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rx_ready_q : in STD_LOGIC;
    rx_pin : in STD_LOGIC;
    \bit_cnt_reg[0]_0\ : in STD_LOGIC;
    \fifo_count_reg[0]\ : in STD_LOGIC;
    \fifo_count_reg[0]_0\ : in STD_LOGIC;
    DI : in STD_LOGIC_VECTOR ( 0 to 0 );
    S : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \fifo_count_reg[6]\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_uart_axi_interface_0_0_receivefsm : entity is "receivefsm";
end design_1_uart_axi_interface_0_0_receivefsm;

architecture STRUCTURE of design_1_uart_axi_interface_0_0_receivefsm is
  signal baud_cnt0 : STD_LOGIC;
  signal \baud_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \baud_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \baud_cnt[1]_i_2_n_0\ : STD_LOGIC;
  signal \baud_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \baud_cnt[3]_i_2_n_0\ : STD_LOGIC;
  signal \baud_cnt[3]_i_3_n_0\ : STD_LOGIC;
  signal \baud_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \baud_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \baud_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal \baud_cnt_reg_n_0_[3]\ : STD_LOGIC;
  signal bit_cnt : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal bit_cnt0 : STD_LOGIC;
  signal \bit_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \bit_cnt[0]_i_2_n_0\ : STD_LOGIC;
  signal \bit_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \bit_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_count[4]_i_6_n_0\ : STD_LOGIC;
  signal \fifo_count_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_count_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \fifo_count_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \fifo_count_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \fifo_count_reg[6]_i_2_n_3\ : STD_LOGIC;
  signal \^rx_data\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \rx_data[0]_i_1_n_0\ : STD_LOGIC;
  signal \rx_data[1]_i_1_n_0\ : STD_LOGIC;
  signal \rx_data[2]_i_1_n_0\ : STD_LOGIC;
  signal \rx_data[3]_i_1_n_0\ : STD_LOGIC;
  signal \rx_data[4]_i_1_n_0\ : STD_LOGIC;
  signal \rx_data[5]_i_1_n_0\ : STD_LOGIC;
  signal \rx_data[6]_i_1_n_0\ : STD_LOGIC;
  signal \rx_data[7]_i_1_n_0\ : STD_LOGIC;
  signal \rx_data[7]_i_2_n_0\ : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \state[0]_i_1_n_0\ : STD_LOGIC;
  signal \state[1]_i_1_n_0\ : STD_LOGIC;
  signal \state[1]_i_2_n_0\ : STD_LOGIC;
  signal \state[1]_i_3_n_0\ : STD_LOGIC;
  signal \state[1]_i_4_n_0\ : STD_LOGIC;
  signal \state[2]_i_1_n_0\ : STD_LOGIC;
  signal \state[2]_i_2_n_0\ : STD_LOGIC;
  signal \state_reg_n_0_[0]\ : STD_LOGIC;
  signal \state_reg_n_0_[1]\ : STD_LOGIC;
  signal \state_reg_n_0_[2]\ : STD_LOGIC;
  signal \NLW_fifo_count_reg[6]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_fifo_count_reg[6]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \baud_cnt[0]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \baud_cnt[1]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \baud_cnt[3]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \bit_cnt[0]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \bit_cnt[1]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \bit_cnt[2]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \bit_cnt[2]_i_2\ : label is "soft_lutpair0";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \fifo_count_reg[4]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of \fifo_count_reg[4]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \fifo_count_reg[6]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \fifo_count_reg[6]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \fifo_wr_ptr[5]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \rx_data[7]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of rx_ready_q_i_1 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \state[1]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \state[1]_i_4\ : label is "soft_lutpair4";
begin
  rx_data(7 downto 0) <= \^rx_data\(7 downto 0);
\baud_cnt[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0F0F0F02"
    )
        port map (
      I0 => \state_reg_n_0_[0]\,
      I1 => \baud_cnt_reg_n_0_[3]\,
      I2 => \baud_cnt_reg_n_0_[0]\,
      I3 => \state_reg_n_0_[1]\,
      I4 => \state_reg_n_0_[2]\,
      O => \baud_cnt[0]_i_1_n_0\
    );
\baud_cnt[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000EEFEEEFE0000"
    )
        port map (
      I0 => \state_reg_n_0_[1]\,
      I1 => \state_reg_n_0_[2]\,
      I2 => \state_reg_n_0_[0]\,
      I3 => \baud_cnt[1]_i_2_n_0\,
      I4 => \baud_cnt_reg_n_0_[1]\,
      I5 => \baud_cnt_reg_n_0_[0]\,
      O => \baud_cnt[1]_i_1_n_0\
    );
\baud_cnt[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EAAA"
    )
        port map (
      I0 => \baud_cnt_reg_n_0_[3]\,
      I1 => \baud_cnt_reg_n_0_[2]\,
      I2 => \baud_cnt_reg_n_0_[0]\,
      I3 => \baud_cnt_reg_n_0_[1]\,
      O => \baud_cnt[1]_i_2_n_0\
    );
\baud_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00AEAE00AE00AE00"
    )
        port map (
      I0 => \baud_cnt[3]_i_3_n_0\,
      I1 => \state_reg_n_0_[0]\,
      I2 => \baud_cnt_reg_n_0_[3]\,
      I3 => \baud_cnt_reg_n_0_[2]\,
      I4 => \baud_cnt_reg_n_0_[0]\,
      I5 => \baud_cnt_reg_n_0_[1]\,
      O => \baud_cnt[2]_i_1_n_0\
    );
\baud_cnt[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"1100DF00"
    )
        port map (
      I0 => \state_reg_n_0_[0]\,
      I1 => \state_reg_n_0_[1]\,
      I2 => rx_pin,
      I3 => \bit_cnt_reg[0]_0\,
      I4 => \state_reg_n_0_[2]\,
      O => baud_cnt0
    );
\baud_cnt[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"28888888"
    )
        port map (
      I0 => \baud_cnt[3]_i_3_n_0\,
      I1 => \baud_cnt_reg_n_0_[3]\,
      I2 => \baud_cnt_reg_n_0_[1]\,
      I3 => \baud_cnt_reg_n_0_[0]\,
      I4 => \baud_cnt_reg_n_0_[2]\,
      O => \baud_cnt[3]_i_2_n_0\
    );
\baud_cnt[3]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \state_reg_n_0_[1]\,
      I1 => \state_reg_n_0_[2]\,
      O => \baud_cnt[3]_i_3_n_0\
    );
\baud_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => baud_cnt0,
      D => \baud_cnt[0]_i_1_n_0\,
      Q => \baud_cnt_reg_n_0_[0]\,
      R => '0'
    );
\baud_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => baud_cnt0,
      D => \baud_cnt[1]_i_1_n_0\,
      Q => \baud_cnt_reg_n_0_[1]\,
      R => '0'
    );
\baud_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => baud_cnt0,
      D => \baud_cnt[2]_i_1_n_0\,
      Q => \baud_cnt_reg_n_0_[2]\,
      R => '0'
    );
\baud_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => baud_cnt0,
      D => \baud_cnt[3]_i_2_n_0\,
      Q => \baud_cnt_reg_n_0_[3]\,
      R => '0'
    );
\bit_cnt[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFDFDFD00000200"
    )
        port map (
      I0 => \bit_cnt_reg[0]_0\,
      I1 => \state_reg_n_0_[0]\,
      I2 => \state_reg_n_0_[2]\,
      I3 => \state_reg_n_0_[1]\,
      I4 => \bit_cnt[0]_i_2_n_0\,
      I5 => bit_cnt(0),
      O => \bit_cnt[0]_i_1_n_0\
    );
\bit_cnt[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \baud_cnt_reg_n_0_[2]\,
      I1 => \baud_cnt_reg_n_0_[0]\,
      I2 => \baud_cnt_reg_n_0_[1]\,
      I3 => \baud_cnt_reg_n_0_[3]\,
      O => \bit_cnt[0]_i_2_n_0\
    );
\bit_cnt[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F80"
    )
        port map (
      I0 => \state_reg_n_0_[1]\,
      I1 => bit_cnt(0),
      I2 => bit_cnt0,
      I3 => bit_cnt(1),
      O => \bit_cnt[1]_i_1_n_0\
    );
\bit_cnt[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2AFF8000"
    )
        port map (
      I0 => \state_reg_n_0_[1]\,
      I1 => bit_cnt(0),
      I2 => bit_cnt(1),
      I3 => bit_cnt0,
      I4 => bit_cnt(2),
      O => \bit_cnt[2]_i_1_n_0\
    );
\bit_cnt[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00020202"
    )
        port map (
      I0 => \bit_cnt_reg[0]_0\,
      I1 => \state_reg_n_0_[0]\,
      I2 => \state_reg_n_0_[2]\,
      I3 => \state_reg_n_0_[1]\,
      I4 => \bit_cnt[0]_i_2_n_0\,
      O => bit_cnt0
    );
\bit_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \bit_cnt[0]_i_1_n_0\,
      Q => bit_cnt(0),
      R => '0'
    );
\bit_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \bit_cnt[1]_i_1_n_0\,
      Q => bit_cnt(1),
      R => '0'
    );
\bit_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \bit_cnt[2]_i_1_n_0\,
      Q => bit_cnt(2),
      R => '0'
    );
\fifo_count[4]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55556555"
    )
        port map (
      I0 => Q(1),
      I1 => Q(5),
      I2 => \state_reg_n_0_[1]\,
      I3 => \state_reg_n_0_[0]\,
      I4 => rx_ready_q,
      O => \fifo_count[4]_i_6_n_0\
    );
\fifo_count[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00400040FFBFFF40"
    )
        port map (
      I0 => rx_ready_q,
      I1 => \state_reg_n_0_[0]\,
      I2 => \state_reg_n_0_[1]\,
      I3 => Q(5),
      I4 => \fifo_count_reg[0]\,
      I5 => \fifo_count_reg[0]_0\,
      O => E(0)
    );
\fifo_count_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \fifo_count_reg[4]_i_1_n_0\,
      CO(2) => \fifo_count_reg[4]_i_1_n_1\,
      CO(1) => \fifo_count_reg[4]_i_1_n_2\,
      CO(0) => \fifo_count_reg[4]_i_1_n_3\,
      CYINIT => Q(0),
      DI(3 downto 1) => Q(3 downto 1),
      DI(0) => DI(0),
      O(3 downto 0) => D(3 downto 0),
      S(3 downto 1) => S(2 downto 0),
      S(0) => \fifo_count[4]_i_6_n_0\
    );
\fifo_count_reg[6]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \fifo_count_reg[4]_i_1_n_0\,
      CO(3 downto 1) => \NLW_fifo_count_reg[6]_i_2_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \fifo_count_reg[6]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => Q(4),
      O(3 downto 2) => \NLW_fifo_count_reg[6]_i_2_O_UNCONNECTED\(3 downto 2),
      O(1 downto 0) => D(5 downto 4),
      S(3 downto 2) => B"00",
      S(1 downto 0) => \fifo_count_reg[6]\(1 downto 0)
    );
fifo_mem_reg_0_63_0_2_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => rx_ready_q,
      I1 => \state_reg_n_0_[0]\,
      I2 => \state_reg_n_0_[1]\,
      I3 => Q(5),
      O => fifo_wr_ptr
    );
\fifo_wr_ptr[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => rx_ready_q,
      I1 => \state_reg_n_0_[0]\,
      I2 => \state_reg_n_0_[1]\,
      I3 => Q(5),
      O => rx_ready_q_reg(0)
    );
\rx_data[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEFFFF00020000"
    )
        port map (
      I0 => rx_pin,
      I1 => bit_cnt(2),
      I2 => bit_cnt(1),
      I3 => bit_cnt(0),
      I4 => \rx_data[7]_i_2_n_0\,
      I5 => \^rx_data\(0),
      O => \rx_data[0]_i_1_n_0\
    );
\rx_data[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFBFFFF00080000"
    )
        port map (
      I0 => rx_pin,
      I1 => bit_cnt(0),
      I2 => bit_cnt(1),
      I3 => bit_cnt(2),
      I4 => \rx_data[7]_i_2_n_0\,
      I5 => \^rx_data\(1),
      O => \rx_data[1]_i_1_n_0\
    );
\rx_data[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFEFFFFF00200000"
    )
        port map (
      I0 => rx_pin,
      I1 => bit_cnt(2),
      I2 => bit_cnt(1),
      I3 => bit_cnt(0),
      I4 => \rx_data[7]_i_2_n_0\,
      I5 => \^rx_data\(2),
      O => \rx_data[2]_i_1_n_0\
    );
\rx_data[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFFFFF20000000"
    )
        port map (
      I0 => rx_pin,
      I1 => bit_cnt(2),
      I2 => bit_cnt(0),
      I3 => bit_cnt(1),
      I4 => \rx_data[7]_i_2_n_0\,
      I5 => \^rx_data\(3),
      O => \rx_data[3]_i_1_n_0\
    );
\rx_data[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFEFFFFF00200000"
    )
        port map (
      I0 => rx_pin,
      I1 => bit_cnt(1),
      I2 => bit_cnt(2),
      I3 => bit_cnt(0),
      I4 => \rx_data[7]_i_2_n_0\,
      I5 => \^rx_data\(4),
      O => \rx_data[4]_i_1_n_0\
    );
\rx_data[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFBFFFFF00800000"
    )
        port map (
      I0 => rx_pin,
      I1 => bit_cnt(0),
      I2 => bit_cnt(2),
      I3 => bit_cnt(1),
      I4 => \rx_data[7]_i_2_n_0\,
      I5 => \^rx_data\(5),
      O => \rx_data[5]_i_1_n_0\
    );
\rx_data[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFBFFFFF00800000"
    )
        port map (
      I0 => rx_pin,
      I1 => bit_cnt(2),
      I2 => bit_cnt(1),
      I3 => bit_cnt(0),
      I4 => \rx_data[7]_i_2_n_0\,
      I5 => \^rx_data\(6),
      O => \rx_data[6]_i_1_n_0\
    );
\rx_data[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFFFFF80000000"
    )
        port map (
      I0 => rx_pin,
      I1 => \rx_data[7]_i_2_n_0\,
      I2 => bit_cnt(2),
      I3 => bit_cnt(0),
      I4 => bit_cnt(1),
      I5 => \^rx_data\(7),
      O => \rx_data[7]_i_1_n_0\
    );
\rx_data[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01000000"
    )
        port map (
      I0 => \bit_cnt[0]_i_2_n_0\,
      I1 => \state_reg_n_0_[2]\,
      I2 => \state_reg_n_0_[0]\,
      I3 => \state_reg_n_0_[1]\,
      I4 => \bit_cnt_reg[0]_0\,
      O => \rx_data[7]_i_2_n_0\
    );
\rx_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rx_data[0]_i_1_n_0\,
      Q => \^rx_data\(0),
      R => '0'
    );
\rx_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rx_data[1]_i_1_n_0\,
      Q => \^rx_data\(1),
      R => '0'
    );
\rx_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rx_data[2]_i_1_n_0\,
      Q => \^rx_data\(2),
      R => '0'
    );
\rx_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rx_data[3]_i_1_n_0\,
      Q => \^rx_data\(3),
      R => '0'
    );
\rx_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rx_data[4]_i_1_n_0\,
      Q => \^rx_data\(4),
      R => '0'
    );
\rx_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rx_data[5]_i_1_n_0\,
      Q => \^rx_data\(5),
      R => '0'
    );
\rx_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rx_data[6]_i_1_n_0\,
      Q => \^rx_data\(6),
      R => '0'
    );
\rx_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \rx_data[7]_i_1_n_0\,
      Q => \^rx_data\(7),
      R => '0'
    );
rx_ready_q_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \state_reg_n_0_[1]\,
      I1 => \state_reg_n_0_[0]\,
      O => rx_ready
    );
\state[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => state(0),
      I1 => \bit_cnt_reg[0]_0\,
      I2 => \state_reg_n_0_[0]\,
      O => \state[0]_i_1_n_0\
    );
\state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000300C040055"
    )
        port map (
      I0 => rx_pin,
      I1 => \state[1]_i_4_n_0\,
      I2 => \baud_cnt_reg_n_0_[3]\,
      I3 => \state_reg_n_0_[1]\,
      I4 => \state_reg_n_0_[0]\,
      I5 => \state_reg_n_0_[2]\,
      O => state(0)
    );
\state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFC8FFFFFFC80000"
    )
        port map (
      I0 => \state[2]_i_2_n_0\,
      I1 => \state[1]_i_2_n_0\,
      I2 => \bit_cnt[0]_i_2_n_0\,
      I3 => \state[1]_i_3_n_0\,
      I4 => \bit_cnt_reg[0]_0\,
      I5 => \state_reg_n_0_[1]\,
      O => \state[1]_i_1_n_0\
    );
\state[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
        port map (
      I0 => \state_reg_n_0_[2]\,
      I1 => \state_reg_n_0_[0]\,
      I2 => \state_reg_n_0_[1]\,
      O => \state[1]_i_2_n_0\
    );
\state[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0010041422220010"
    )
        port map (
      I0 => \state_reg_n_0_[1]\,
      I1 => \state_reg_n_0_[2]\,
      I2 => \state_reg_n_0_[0]\,
      I3 => rx_pin,
      I4 => \state[1]_i_4_n_0\,
      I5 => \baud_cnt_reg_n_0_[3]\,
      O => \state[1]_i_3_n_0\
    );
\state[1]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => \baud_cnt_reg_n_0_[1]\,
      I1 => \baud_cnt_reg_n_0_[0]\,
      I2 => \baud_cnt_reg_n_0_[2]\,
      O => \state[1]_i_4_n_0\
    );
\state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0300FFFF00040000"
    )
        port map (
      I0 => \state[2]_i_2_n_0\,
      I1 => \state_reg_n_0_[1]\,
      I2 => \state_reg_n_0_[0]\,
      I3 => \bit_cnt[0]_i_2_n_0\,
      I4 => \bit_cnt_reg[0]_0\,
      I5 => \state_reg_n_0_[2]\,
      O => \state[2]_i_1_n_0\
    );
\state[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => bit_cnt(1),
      I1 => bit_cnt(0),
      I2 => bit_cnt(2),
      O => \state[2]_i_2_n_0\
    );
\state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \state[0]_i_1_n_0\,
      Q => \state_reg_n_0_[0]\,
      R => '0'
    );
\state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \state[1]_i_1_n_0\,
      Q => \state_reg_n_0_[1]\,
      R => '0'
    );
\state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \state[2]_i_1_n_0\,
      Q => \state_reg_n_0_[2]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_uart_axi_interface_0_0_transmitfsm is
  port (
    gpio_tx_rdy : out STD_LOGIC;
    tx_pin : out STD_LOGIC;
    baud_en : in STD_LOGIC;
    clk : in STD_LOGIC;
    gpio_tx_start : in STD_LOGIC;
    gpio_tx_data : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_uart_axi_interface_0_0_transmitfsm : entity is "transmitfsm";
end design_1_uart_axi_interface_0_0_transmitfsm;

architecture STRUCTURE of design_1_uart_axi_interface_0_0_transmitfsm is
  signal \FSM_sequential_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \bit_cnt[0]_i_1_n_0\ : STD_LOGIC;
  signal \bit_cnt[1]_i_1_n_0\ : STD_LOGIC;
  signal \bit_cnt[2]_i_1_n_0\ : STD_LOGIC;
  signal \bit_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \bit_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \bit_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \state__0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal tx_pin_INST_0_i_1_n_0 : STD_LOGIC;
  signal tx_pin_INST_0_i_2_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_state[0]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \FSM_sequential_state[1]_i_1\ : label is "soft_lutpair8";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[0]\ : label is "idle:00,start:01,stop:11,bits:10";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[1]\ : label is "idle:00,start:01,stop:11,bits:10";
  attribute SOFT_HLUTNM of \bit_cnt[0]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \bit_cnt[1]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of gpio_tx_rdy_INST_0 : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of tx_pin_INST_0 : label is "soft_lutpair7";
begin
\FSM_sequential_state[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \state__0\(0),
      I1 => baud_en,
      I2 => state(0),
      O => \FSM_sequential_state[0]_i_1_n_0\
    );
\FSM_sequential_state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000E2222222"
    )
        port map (
      I0 => gpio_tx_start,
      I1 => state(1),
      I2 => \bit_cnt_reg_n_0_[1]\,
      I3 => \bit_cnt_reg_n_0_[0]\,
      I4 => \bit_cnt_reg_n_0_[2]\,
      I5 => state(0),
      O => \state__0\(0)
    );
\FSM_sequential_state[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => state(0),
      I1 => baud_en,
      I2 => state(1),
      O => \FSM_sequential_state[1]_i_1_n_0\
    );
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \FSM_sequential_state[0]_i_1_n_0\,
      Q => state(0),
      R => '0'
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \FSM_sequential_state[1]_i_1_n_0\,
      Q => state(1),
      R => '0'
    );
\bit_cnt[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F308"
    )
        port map (
      I0 => state(1),
      I1 => baud_en,
      I2 => state(0),
      I3 => \bit_cnt_reg_n_0_[0]\,
      O => \bit_cnt[0]_i_1_n_0\
    );
\bit_cnt[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF2F0080"
    )
        port map (
      I0 => state(1),
      I1 => \bit_cnt_reg_n_0_[0]\,
      I2 => baud_en,
      I3 => state(0),
      I4 => \bit_cnt_reg_n_0_[1]\,
      O => \bit_cnt[1]_i_1_n_0\
    );
\bit_cnt[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF2AFF00008000"
    )
        port map (
      I0 => state(1),
      I1 => \bit_cnt_reg_n_0_[1]\,
      I2 => \bit_cnt_reg_n_0_[0]\,
      I3 => baud_en,
      I4 => state(0),
      I5 => \bit_cnt_reg_n_0_[2]\,
      O => \bit_cnt[2]_i_1_n_0\
    );
\bit_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \bit_cnt[0]_i_1_n_0\,
      Q => \bit_cnt_reg_n_0_[0]\,
      R => '0'
    );
\bit_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \bit_cnt[1]_i_1_n_0\,
      Q => \bit_cnt_reg_n_0_[1]\,
      R => '0'
    );
\bit_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \bit_cnt[2]_i_1_n_0\,
      Q => \bit_cnt_reg_n_0_[2]\,
      R => '0'
    );
gpio_tx_rdy_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      O => gpio_tx_rdy
    );
tx_pin_INST_0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF00B8FF"
    )
        port map (
      I0 => tx_pin_INST_0_i_1_n_0,
      I1 => \bit_cnt_reg_n_0_[2]\,
      I2 => tx_pin_INST_0_i_2_n_0,
      I3 => state(1),
      I4 => state(0),
      O => tx_pin
    );
tx_pin_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => gpio_tx_data(7),
      I1 => gpio_tx_data(6),
      I2 => \bit_cnt_reg_n_0_[1]\,
      I3 => gpio_tx_data(5),
      I4 => \bit_cnt_reg_n_0_[0]\,
      I5 => gpio_tx_data(4),
      O => tx_pin_INST_0_i_1_n_0
    );
tx_pin_INST_0_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => gpio_tx_data(3),
      I1 => gpio_tx_data(2),
      I2 => \bit_cnt_reg_n_0_[1]\,
      I3 => gpio_tx_data(1),
      I4 => \bit_cnt_reg_n_0_[0]\,
      I5 => gpio_tx_data(0),
      O => tx_pin_INST_0_i_2_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_uart_axi_interface_0_0_uart_axi_interface is
  port (
    gpio_rx_data : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gpio_tx_rdy : out STD_LOGIC;
    tx_pin : out STD_LOGIC;
    gpio_rx_ready : out STD_LOGIC;
    gpio_rx_en : in STD_LOGIC;
    clk : in STD_LOGIC;
    rx_pin : in STD_LOGIC;
    gpio_tx_start : in STD_LOGIC;
    gpio_tx_data : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_uart_axi_interface_0_0_uart_axi_interface : entity is "uart_axi_interface";
end design_1_uart_axi_interface_0_0_uart_axi_interface;

architecture STRUCTURE of design_1_uart_axi_interface_0_0_uart_axi_interface is
  signal baud_en : STD_LOGIC;
  signal baud_en_i_2_n_0 : STD_LOGIC;
  signal baud_en_i_3_n_0 : STD_LOGIC;
  signal baud_en_x16_i_1_n_0 : STD_LOGIC;
  signal baud_en_x16_i_2_n_0 : STD_LOGIC;
  signal baud_en_x16_reg_n_0 : STD_LOGIC;
  signal \cnt[0]_i_2_n_0\ : STD_LOGIC;
  signal cnt_reg : STD_LOGIC_VECTOR ( 13 downto 0 );
  signal \cnt_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \cnt_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \cnt_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \cnt_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \cnt_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \cnt_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \cnt_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \cnt_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \cnt_x16[9]_i_2_n_0\ : STD_LOGIC;
  signal cnt_x16_reg : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal eqOp : STD_LOGIC;
  signal fifo_count : STD_LOGIC;
  signal \fifo_count[0]_i_1_n_0\ : STD_LOGIC;
  signal \fifo_count[4]_i_2_n_0\ : STD_LOGIC;
  signal \fifo_count[4]_i_3_n_0\ : STD_LOGIC;
  signal \fifo_count[4]_i_4_n_0\ : STD_LOGIC;
  signal \fifo_count[4]_i_5_n_0\ : STD_LOGIC;
  signal \fifo_count[6]_i_3_n_0\ : STD_LOGIC;
  signal \fifo_count[6]_i_4_n_0\ : STD_LOGIC;
  signal \fifo_count[6]_i_5_n_0\ : STD_LOGIC;
  signal fifo_count_reg : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal fifo_rd_ptr : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \fifo_rd_ptr_rep[5]_i_1_n_0\ : STD_LOGIC;
  signal fifo_wr_ptr : STD_LOGIC;
  signal fifo_wr_ptr_reg : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal gpio_rx_data0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \gpio_rx_data[7]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal inst_RFSM_n_2 : STD_LOGIC;
  signal inst_RFSM_n_4 : STD_LOGIC;
  signal inst_RFSM_n_5 : STD_LOGIC;
  signal inst_RFSM_n_6 : STD_LOGIC;
  signal inst_RFSM_n_7 : STD_LOGIC;
  signal inst_RFSM_n_8 : STD_LOGIC;
  signal inst_RFSM_n_9 : STD_LOGIC;
  signal p_1_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \p_1_out__0\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal plusOp : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal rx_data : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rx_en_q : STD_LOGIC;
  signal rx_ready : STD_LOGIC;
  signal rx_ready_q : STD_LOGIC;
  signal \NLW_cnt_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_cnt_reg[12]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_fifo_mem_reg_0_63_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_fifo_mem_reg_0_63_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_fifo_mem_reg_0_63_6_7_DOC_UNCONNECTED : STD_LOGIC;
  signal NLW_fifo_mem_reg_0_63_6_7_DOD_UNCONNECTED : STD_LOGIC;
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \cnt_reg[0]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \cnt_reg[12]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \cnt_reg[4]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \cnt_reg[8]_i_1\ : label is 11;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \cnt_x16[1]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \cnt_x16[2]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \cnt_x16[3]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \cnt_x16[4]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \cnt_x16[6]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \cnt_x16[7]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \cnt_x16[8]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \cnt_x16[9]_i_1\ : label is "soft_lutpair9";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of fifo_mem_reg_0_63_0_2 : label is "";
  attribute RTL_RAM_BITS : integer;
  attribute RTL_RAM_BITS of fifo_mem_reg_0_63_0_2 : label is 512;
  attribute RTL_RAM_NAME : string;
  attribute RTL_RAM_NAME of fifo_mem_reg_0_63_0_2 : label is "design_1_uart_axi_interface_0_0/U0/fifo_mem_reg";
  attribute RTL_RAM_STYLE : string;
  attribute RTL_RAM_STYLE of fifo_mem_reg_0_63_0_2 : label is "auto";
  attribute RTL_RAM_TYPE : string;
  attribute RTL_RAM_TYPE of fifo_mem_reg_0_63_0_2 : label is "RAM_SDP";
  attribute ram_addr_begin : integer;
  attribute ram_addr_begin of fifo_mem_reg_0_63_0_2 : label is 0;
  attribute ram_addr_end : integer;
  attribute ram_addr_end of fifo_mem_reg_0_63_0_2 : label is 63;
  attribute ram_offset : integer;
  attribute ram_offset of fifo_mem_reg_0_63_0_2 : label is 0;
  attribute ram_slice_begin : integer;
  attribute ram_slice_begin of fifo_mem_reg_0_63_0_2 : label is 0;
  attribute ram_slice_end : integer;
  attribute ram_slice_end of fifo_mem_reg_0_63_0_2 : label is 2;
  attribute METHODOLOGY_DRC_VIOS of fifo_mem_reg_0_63_3_5 : label is "";
  attribute RTL_RAM_BITS of fifo_mem_reg_0_63_3_5 : label is 512;
  attribute RTL_RAM_NAME of fifo_mem_reg_0_63_3_5 : label is "design_1_uart_axi_interface_0_0/U0/fifo_mem_reg";
  attribute RTL_RAM_STYLE of fifo_mem_reg_0_63_3_5 : label is "auto";
  attribute RTL_RAM_TYPE of fifo_mem_reg_0_63_3_5 : label is "RAM_SDP";
  attribute ram_addr_begin of fifo_mem_reg_0_63_3_5 : label is 0;
  attribute ram_addr_end of fifo_mem_reg_0_63_3_5 : label is 63;
  attribute ram_offset of fifo_mem_reg_0_63_3_5 : label is 0;
  attribute ram_slice_begin of fifo_mem_reg_0_63_3_5 : label is 3;
  attribute ram_slice_end of fifo_mem_reg_0_63_3_5 : label is 5;
  attribute METHODOLOGY_DRC_VIOS of fifo_mem_reg_0_63_6_7 : label is "";
  attribute RTL_RAM_BITS of fifo_mem_reg_0_63_6_7 : label is 512;
  attribute RTL_RAM_NAME of fifo_mem_reg_0_63_6_7 : label is "design_1_uart_axi_interface_0_0/U0/fifo_mem_reg";
  attribute RTL_RAM_STYLE of fifo_mem_reg_0_63_6_7 : label is "auto";
  attribute RTL_RAM_TYPE of fifo_mem_reg_0_63_6_7 : label is "RAM_SDP";
  attribute ram_addr_begin of fifo_mem_reg_0_63_6_7 : label is 0;
  attribute ram_addr_end of fifo_mem_reg_0_63_6_7 : label is 63;
  attribute ram_offset of fifo_mem_reg_0_63_6_7 : label is 0;
  attribute ram_slice_begin of fifo_mem_reg_0_63_6_7 : label is 6;
  attribute ram_slice_end of fifo_mem_reg_0_63_6_7 : label is 7;
  attribute SOFT_HLUTNM of \fifo_rd_ptr_rep[1]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \fifo_rd_ptr_rep[2]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \fifo_rd_ptr_rep[3]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \fifo_rd_ptr_rep[4]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \fifo_wr_ptr[1]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \fifo_wr_ptr[2]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \fifo_wr_ptr[3]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \fifo_wr_ptr[4]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \gpio_rx_data[0]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gpio_rx_data[1]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \gpio_rx_data[2]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gpio_rx_data[3]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \gpio_rx_data[4]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gpio_rx_data[5]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \gpio_rx_data[6]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \gpio_rx_data[7]_INST_0\ : label is "soft_lutpair16";
begin
baud_en_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => baud_en_i_2_n_0,
      I1 => cnt_reg(0),
      I2 => cnt_reg(1),
      I3 => baud_en_i_3_n_0,
      O => eqOp
    );
baud_en_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
        port map (
      I0 => cnt_reg(11),
      I1 => cnt_reg(10),
      I2 => cnt_reg(8),
      I3 => cnt_reg(9),
      I4 => cnt_reg(12),
      I5 => cnt_reg(13),
      O => baud_en_i_2_n_0
    );
baud_en_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000200000000000"
    )
        port map (
      I0 => cnt_reg(5),
      I1 => cnt_reg(4),
      I2 => cnt_reg(2),
      I3 => cnt_reg(3),
      I4 => cnt_reg(6),
      I5 => cnt_reg(7),
      O => baud_en_i_3_n_0
    );
baud_en_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => eqOp,
      Q => baud_en,
      R => '0'
    );
baud_en_x16_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00200000"
    )
        port map (
      I0 => cnt_x16_reg(3),
      I1 => cnt_x16_reg(2),
      I2 => cnt_x16_reg(1),
      I3 => cnt_x16_reg(0),
      I4 => baud_en_x16_i_2_n_0,
      O => baud_en_x16_i_1_n_0
    );
baud_en_x16_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
        port map (
      I0 => cnt_x16_reg(7),
      I1 => cnt_x16_reg(6),
      I2 => cnt_x16_reg(4),
      I3 => cnt_x16_reg(5),
      I4 => cnt_x16_reg(8),
      I5 => cnt_x16_reg(9),
      O => baud_en_x16_i_2_n_0
    );
baud_en_x16_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => baud_en_x16_i_1_n_0,
      Q => baud_en_x16_reg_n_0,
      R => '0'
    );
\cnt[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => cnt_reg(0),
      O => \cnt[0]_i_2_n_0\
    );
\cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[0]_i_1_n_7\,
      Q => cnt_reg(0),
      R => eqOp
    );
\cnt_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \cnt_reg[0]_i_1_n_0\,
      CO(2) => \cnt_reg[0]_i_1_n_1\,
      CO(1) => \cnt_reg[0]_i_1_n_2\,
      CO(0) => \cnt_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \cnt_reg[0]_i_1_n_4\,
      O(2) => \cnt_reg[0]_i_1_n_5\,
      O(1) => \cnt_reg[0]_i_1_n_6\,
      O(0) => \cnt_reg[0]_i_1_n_7\,
      S(3 downto 1) => cnt_reg(3 downto 1),
      S(0) => \cnt[0]_i_2_n_0\
    );
\cnt_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[8]_i_1_n_5\,
      Q => cnt_reg(10),
      R => eqOp
    );
\cnt_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[8]_i_1_n_4\,
      Q => cnt_reg(11),
      R => eqOp
    );
\cnt_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[12]_i_1_n_7\,
      Q => cnt_reg(12),
      R => eqOp
    );
\cnt_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cnt_reg[8]_i_1_n_0\,
      CO(3 downto 1) => \NLW_cnt_reg[12]_i_1_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \cnt_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 2) => \NLW_cnt_reg[12]_i_1_O_UNCONNECTED\(3 downto 2),
      O(1) => \cnt_reg[12]_i_1_n_6\,
      O(0) => \cnt_reg[12]_i_1_n_7\,
      S(3 downto 2) => B"00",
      S(1 downto 0) => cnt_reg(13 downto 12)
    );
\cnt_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[12]_i_1_n_6\,
      Q => cnt_reg(13),
      R => eqOp
    );
\cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[0]_i_1_n_6\,
      Q => cnt_reg(1),
      R => eqOp
    );
\cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[0]_i_1_n_5\,
      Q => cnt_reg(2),
      R => eqOp
    );
\cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[0]_i_1_n_4\,
      Q => cnt_reg(3),
      R => eqOp
    );
\cnt_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[4]_i_1_n_7\,
      Q => cnt_reg(4),
      R => eqOp
    );
\cnt_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cnt_reg[0]_i_1_n_0\,
      CO(3) => \cnt_reg[4]_i_1_n_0\,
      CO(2) => \cnt_reg[4]_i_1_n_1\,
      CO(1) => \cnt_reg[4]_i_1_n_2\,
      CO(0) => \cnt_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cnt_reg[4]_i_1_n_4\,
      O(2) => \cnt_reg[4]_i_1_n_5\,
      O(1) => \cnt_reg[4]_i_1_n_6\,
      O(0) => \cnt_reg[4]_i_1_n_7\,
      S(3 downto 0) => cnt_reg(7 downto 4)
    );
\cnt_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[4]_i_1_n_6\,
      Q => cnt_reg(5),
      R => eqOp
    );
\cnt_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[4]_i_1_n_5\,
      Q => cnt_reg(6),
      R => eqOp
    );
\cnt_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[4]_i_1_n_4\,
      Q => cnt_reg(7),
      R => eqOp
    );
\cnt_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[8]_i_1_n_7\,
      Q => cnt_reg(8),
      R => eqOp
    );
\cnt_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cnt_reg[4]_i_1_n_0\,
      CO(3) => \cnt_reg[8]_i_1_n_0\,
      CO(2) => \cnt_reg[8]_i_1_n_1\,
      CO(1) => \cnt_reg[8]_i_1_n_2\,
      CO(0) => \cnt_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cnt_reg[8]_i_1_n_4\,
      O(2) => \cnt_reg[8]_i_1_n_5\,
      O(1) => \cnt_reg[8]_i_1_n_6\,
      O(0) => \cnt_reg[8]_i_1_n_7\,
      S(3 downto 0) => cnt_reg(11 downto 8)
    );
\cnt_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \cnt_reg[8]_i_1_n_6\,
      Q => cnt_reg(9),
      R => eqOp
    );
\cnt_x16[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => cnt_x16_reg(0),
      O => plusOp(0)
    );
\cnt_x16[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => cnt_x16_reg(0),
      I1 => cnt_x16_reg(1),
      O => plusOp(1)
    );
\cnt_x16[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => cnt_x16_reg(1),
      I1 => cnt_x16_reg(0),
      I2 => cnt_x16_reg(2),
      O => plusOp(2)
    );
\cnt_x16[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => cnt_x16_reg(2),
      I1 => cnt_x16_reg(0),
      I2 => cnt_x16_reg(1),
      I3 => cnt_x16_reg(3),
      O => plusOp(3)
    );
\cnt_x16[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => cnt_x16_reg(3),
      I1 => cnt_x16_reg(1),
      I2 => cnt_x16_reg(0),
      I3 => cnt_x16_reg(2),
      I4 => cnt_x16_reg(4),
      O => plusOp(4)
    );
\cnt_x16[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => cnt_x16_reg(4),
      I1 => cnt_x16_reg(2),
      I2 => cnt_x16_reg(0),
      I3 => cnt_x16_reg(1),
      I4 => cnt_x16_reg(3),
      I5 => cnt_x16_reg(5),
      O => plusOp(5)
    );
\cnt_x16[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \cnt_x16[9]_i_2_n_0\,
      I1 => cnt_x16_reg(6),
      O => plusOp(6)
    );
\cnt_x16[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => cnt_x16_reg(6),
      I1 => \cnt_x16[9]_i_2_n_0\,
      I2 => cnt_x16_reg(7),
      O => plusOp(7)
    );
\cnt_x16[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \cnt_x16[9]_i_2_n_0\,
      I1 => cnt_x16_reg(6),
      I2 => cnt_x16_reg(7),
      I3 => cnt_x16_reg(8),
      O => plusOp(8)
    );
\cnt_x16[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => \cnt_x16[9]_i_2_n_0\,
      I1 => cnt_x16_reg(8),
      I2 => cnt_x16_reg(7),
      I3 => cnt_x16_reg(6),
      I4 => cnt_x16_reg(9),
      O => plusOp(9)
    );
\cnt_x16[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => cnt_x16_reg(4),
      I1 => cnt_x16_reg(2),
      I2 => cnt_x16_reg(0),
      I3 => cnt_x16_reg(1),
      I4 => cnt_x16_reg(3),
      I5 => cnt_x16_reg(5),
      O => \cnt_x16[9]_i_2_n_0\
    );
\cnt_x16_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => plusOp(0),
      Q => cnt_x16_reg(0),
      R => baud_en_x16_i_1_n_0
    );
\cnt_x16_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => plusOp(1),
      Q => cnt_x16_reg(1),
      R => baud_en_x16_i_1_n_0
    );
\cnt_x16_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => plusOp(2),
      Q => cnt_x16_reg(2),
      R => baud_en_x16_i_1_n_0
    );
\cnt_x16_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => plusOp(3),
      Q => cnt_x16_reg(3),
      R => baud_en_x16_i_1_n_0
    );
\cnt_x16_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => plusOp(4),
      Q => cnt_x16_reg(4),
      R => baud_en_x16_i_1_n_0
    );
\cnt_x16_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => plusOp(5),
      Q => cnt_x16_reg(5),
      R => baud_en_x16_i_1_n_0
    );
\cnt_x16_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => plusOp(6),
      Q => cnt_x16_reg(6),
      R => baud_en_x16_i_1_n_0
    );
\cnt_x16_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => plusOp(7),
      Q => cnt_x16_reg(7),
      R => baud_en_x16_i_1_n_0
    );
\cnt_x16_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => plusOp(8),
      Q => cnt_x16_reg(8),
      R => baud_en_x16_i_1_n_0
    );
\cnt_x16_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => plusOp(9),
      Q => cnt_x16_reg(9),
      R => baud_en_x16_i_1_n_0
    );
\fifo_count[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => fifo_count_reg(0),
      O => \fifo_count[0]_i_1_n_0\
    );
\fifo_count[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => fifo_count_reg(1),
      O => \fifo_count[4]_i_2_n_0\
    );
\fifo_count[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => fifo_count_reg(3),
      I1 => fifo_count_reg(4),
      O => \fifo_count[4]_i_3_n_0\
    );
\fifo_count[4]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => fifo_count_reg(2),
      I1 => fifo_count_reg(3),
      O => \fifo_count[4]_i_4_n_0\
    );
\fifo_count[4]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => fifo_count_reg(1),
      I1 => fifo_count_reg(2),
      O => \fifo_count[4]_i_5_n_0\
    );
\fifo_count[6]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => rx_en_q,
      I1 => gpio_rx_en,
      O => \fifo_count[6]_i_3_n_0\
    );
\fifo_count[6]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => fifo_count_reg(5),
      I1 => fifo_count_reg(6),
      O => \fifo_count[6]_i_4_n_0\
    );
\fifo_count[6]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => fifo_count_reg(4),
      I1 => fifo_count_reg(5),
      O => \fifo_count[6]_i_5_n_0\
    );
\fifo_count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => fifo_count,
      D => \fifo_count[0]_i_1_n_0\,
      Q => fifo_count_reg(0),
      R => '0'
    );
\fifo_count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => fifo_count,
      D => inst_RFSM_n_9,
      Q => fifo_count_reg(1),
      R => '0'
    );
\fifo_count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => fifo_count,
      D => inst_RFSM_n_8,
      Q => fifo_count_reg(2),
      R => '0'
    );
\fifo_count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => fifo_count,
      D => inst_RFSM_n_7,
      Q => fifo_count_reg(3),
      R => '0'
    );
\fifo_count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => fifo_count,
      D => inst_RFSM_n_6,
      Q => fifo_count_reg(4),
      R => '0'
    );
\fifo_count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => fifo_count,
      D => inst_RFSM_n_5,
      Q => fifo_count_reg(5),
      R => '0'
    );
\fifo_count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => fifo_count,
      D => inst_RFSM_n_4,
      Q => fifo_count_reg(6),
      R => '0'
    );
fifo_mem_reg_0_63_0_2: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => fifo_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => fifo_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => fifo_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => fifo_wr_ptr_reg(5 downto 0),
      DIA => rx_data(0),
      DIB => rx_data(1),
      DIC => rx_data(2),
      DID => '0',
      DOA => gpio_rx_data0(0),
      DOB => gpio_rx_data0(1),
      DOC => gpio_rx_data0(2),
      DOD => NLW_fifo_mem_reg_0_63_0_2_DOD_UNCONNECTED,
      WCLK => clk,
      WE => fifo_wr_ptr
    );
fifo_mem_reg_0_63_3_5: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => fifo_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => fifo_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => fifo_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => fifo_wr_ptr_reg(5 downto 0),
      DIA => rx_data(3),
      DIB => rx_data(4),
      DIC => rx_data(5),
      DID => '0',
      DOA => gpio_rx_data0(3),
      DOB => gpio_rx_data0(4),
      DOC => gpio_rx_data0(5),
      DOD => NLW_fifo_mem_reg_0_63_3_5_DOD_UNCONNECTED,
      WCLK => clk,
      WE => fifo_wr_ptr
    );
fifo_mem_reg_0_63_6_7: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => fifo_rd_ptr(5 downto 0),
      ADDRB(5 downto 0) => fifo_rd_ptr(5 downto 0),
      ADDRC(5 downto 0) => fifo_rd_ptr(5 downto 0),
      ADDRD(5 downto 0) => fifo_wr_ptr_reg(5 downto 0),
      DIA => rx_data(6),
      DIB => rx_data(7),
      DIC => '0',
      DID => '0',
      DOA => gpio_rx_data0(6),
      DOB => gpio_rx_data0(7),
      DOC => NLW_fifo_mem_reg_0_63_6_7_DOC_UNCONNECTED,
      DOD => NLW_fifo_mem_reg_0_63_6_7_DOD_UNCONNECTED,
      WCLK => clk,
      WE => fifo_wr_ptr
    );
\fifo_rd_ptr_reg_rep[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \fifo_rd_ptr_rep[5]_i_1_n_0\,
      D => \p_1_out__0\(0),
      Q => fifo_rd_ptr(0),
      R => '0'
    );
\fifo_rd_ptr_reg_rep[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \fifo_rd_ptr_rep[5]_i_1_n_0\,
      D => \p_1_out__0\(1),
      Q => fifo_rd_ptr(1),
      R => '0'
    );
\fifo_rd_ptr_reg_rep[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \fifo_rd_ptr_rep[5]_i_1_n_0\,
      D => \p_1_out__0\(2),
      Q => fifo_rd_ptr(2),
      R => '0'
    );
\fifo_rd_ptr_reg_rep[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \fifo_rd_ptr_rep[5]_i_1_n_0\,
      D => \p_1_out__0\(3),
      Q => fifo_rd_ptr(3),
      R => '0'
    );
\fifo_rd_ptr_reg_rep[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \fifo_rd_ptr_rep[5]_i_1_n_0\,
      D => \p_1_out__0\(4),
      Q => fifo_rd_ptr(4),
      R => '0'
    );
\fifo_rd_ptr_reg_rep[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => \fifo_rd_ptr_rep[5]_i_1_n_0\,
      D => \p_1_out__0\(5),
      Q => fifo_rd_ptr(5),
      R => '0'
    );
\fifo_rd_ptr_rep[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => fifo_rd_ptr(0),
      O => \p_1_out__0\(0)
    );
\fifo_rd_ptr_rep[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => fifo_rd_ptr(0),
      I1 => fifo_rd_ptr(1),
      O => \p_1_out__0\(1)
    );
\fifo_rd_ptr_rep[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => fifo_rd_ptr(1),
      I1 => fifo_rd_ptr(0),
      I2 => fifo_rd_ptr(2),
      O => \p_1_out__0\(2)
    );
\fifo_rd_ptr_rep[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => fifo_rd_ptr(2),
      I1 => fifo_rd_ptr(0),
      I2 => fifo_rd_ptr(1),
      I3 => fifo_rd_ptr(3),
      O => \p_1_out__0\(3)
    );
\fifo_rd_ptr_rep[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => fifo_rd_ptr(0),
      I1 => fifo_rd_ptr(1),
      I2 => fifo_rd_ptr(2),
      I3 => fifo_rd_ptr(3),
      I4 => fifo_rd_ptr(4),
      O => \p_1_out__0\(4)
    );
\fifo_rd_ptr_rep[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E0"
    )
        port map (
      I0 => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      I1 => fifo_count_reg(6),
      I2 => gpio_rx_en,
      I3 => rx_en_q,
      O => \fifo_rd_ptr_rep[5]_i_1_n_0\
    );
\fifo_rd_ptr_rep[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => fifo_rd_ptr(0),
      I1 => fifo_rd_ptr(1),
      I2 => fifo_rd_ptr(4),
      I3 => fifo_rd_ptr(3),
      I4 => fifo_rd_ptr(2),
      I5 => fifo_rd_ptr(5),
      O => \p_1_out__0\(5)
    );
\fifo_wr_ptr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => fifo_wr_ptr_reg(0),
      O => p_1_out(0)
    );
\fifo_wr_ptr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => fifo_wr_ptr_reg(0),
      I1 => fifo_wr_ptr_reg(1),
      O => p_1_out(1)
    );
\fifo_wr_ptr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => fifo_wr_ptr_reg(1),
      I1 => fifo_wr_ptr_reg(0),
      I2 => fifo_wr_ptr_reg(2),
      O => p_1_out(2)
    );
\fifo_wr_ptr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => fifo_wr_ptr_reg(2),
      I1 => fifo_wr_ptr_reg(0),
      I2 => fifo_wr_ptr_reg(1),
      I3 => fifo_wr_ptr_reg(3),
      O => p_1_out(3)
    );
\fifo_wr_ptr[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => fifo_wr_ptr_reg(0),
      I1 => fifo_wr_ptr_reg(1),
      I2 => fifo_wr_ptr_reg(2),
      I3 => fifo_wr_ptr_reg(3),
      I4 => fifo_wr_ptr_reg(4),
      O => p_1_out(4)
    );
\fifo_wr_ptr[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => fifo_wr_ptr_reg(0),
      I1 => fifo_wr_ptr_reg(1),
      I2 => fifo_wr_ptr_reg(4),
      I3 => fifo_wr_ptr_reg(3),
      I4 => fifo_wr_ptr_reg(2),
      I5 => fifo_wr_ptr_reg(5),
      O => p_1_out(5)
    );
\fifo_wr_ptr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => inst_RFSM_n_2,
      D => p_1_out(0),
      Q => fifo_wr_ptr_reg(0),
      R => '0'
    );
\fifo_wr_ptr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => inst_RFSM_n_2,
      D => p_1_out(1),
      Q => fifo_wr_ptr_reg(1),
      R => '0'
    );
\fifo_wr_ptr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => inst_RFSM_n_2,
      D => p_1_out(2),
      Q => fifo_wr_ptr_reg(2),
      R => '0'
    );
\fifo_wr_ptr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => inst_RFSM_n_2,
      D => p_1_out(3),
      Q => fifo_wr_ptr_reg(3),
      R => '0'
    );
\fifo_wr_ptr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => inst_RFSM_n_2,
      D => p_1_out(4),
      Q => fifo_wr_ptr_reg(4),
      R => '0'
    );
\fifo_wr_ptr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => inst_RFSM_n_2,
      D => p_1_out(5),
      Q => fifo_wr_ptr_reg(5),
      R => '0'
    );
\gpio_rx_data[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
        port map (
      I0 => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      I1 => fifo_count_reg(6),
      I2 => gpio_rx_data0(0),
      O => gpio_rx_data(0)
    );
\gpio_rx_data[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
        port map (
      I0 => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      I1 => fifo_count_reg(6),
      I2 => gpio_rx_data0(1),
      O => gpio_rx_data(1)
    );
\gpio_rx_data[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
        port map (
      I0 => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      I1 => fifo_count_reg(6),
      I2 => gpio_rx_data0(2),
      O => gpio_rx_data(2)
    );
\gpio_rx_data[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
        port map (
      I0 => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      I1 => fifo_count_reg(6),
      I2 => gpio_rx_data0(3),
      O => gpio_rx_data(3)
    );
\gpio_rx_data[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
        port map (
      I0 => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      I1 => fifo_count_reg(6),
      I2 => gpio_rx_data0(4),
      O => gpio_rx_data(4)
    );
\gpio_rx_data[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
        port map (
      I0 => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      I1 => fifo_count_reg(6),
      I2 => gpio_rx_data0(5),
      O => gpio_rx_data(5)
    );
\gpio_rx_data[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
        port map (
      I0 => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      I1 => fifo_count_reg(6),
      I2 => gpio_rx_data0(6),
      O => gpio_rx_data(6)
    );
\gpio_rx_data[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"E0"
    )
        port map (
      I0 => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      I1 => fifo_count_reg(6),
      I2 => gpio_rx_data0(7),
      O => gpio_rx_data(7)
    );
\gpio_rx_data[7]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => fifo_count_reg(4),
      I1 => fifo_count_reg(5),
      I2 => fifo_count_reg(2),
      I3 => fifo_count_reg(3),
      I4 => fifo_count_reg(1),
      I5 => fifo_count_reg(0),
      O => \gpio_rx_data[7]_INST_0_i_1_n_0\
    );
gpio_rx_ready_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      I1 => fifo_count_reg(6),
      O => gpio_rx_ready
    );
inst_RFSM: entity work.design_1_uart_axi_interface_0_0_receivefsm
     port map (
      D(5) => inst_RFSM_n_4,
      D(4) => inst_RFSM_n_5,
      D(3) => inst_RFSM_n_6,
      D(2) => inst_RFSM_n_7,
      D(1) => inst_RFSM_n_8,
      D(0) => inst_RFSM_n_9,
      DI(0) => \fifo_count[4]_i_2_n_0\,
      E(0) => fifo_count,
      Q(5) => fifo_count_reg(6),
      Q(4 downto 0) => fifo_count_reg(4 downto 0),
      S(2) => \fifo_count[4]_i_3_n_0\,
      S(1) => \fifo_count[4]_i_4_n_0\,
      S(0) => \fifo_count[4]_i_5_n_0\,
      \bit_cnt_reg[0]_0\ => baud_en_x16_reg_n_0,
      clk => clk,
      \fifo_count_reg[0]\ => \gpio_rx_data[7]_INST_0_i_1_n_0\,
      \fifo_count_reg[0]_0\ => \fifo_count[6]_i_3_n_0\,
      \fifo_count_reg[6]\(1) => \fifo_count[6]_i_4_n_0\,
      \fifo_count_reg[6]\(0) => \fifo_count[6]_i_5_n_0\,
      fifo_wr_ptr => fifo_wr_ptr,
      rx_data(7 downto 0) => rx_data(7 downto 0),
      rx_pin => rx_pin,
      rx_ready => rx_ready,
      rx_ready_q => rx_ready_q,
      rx_ready_q_reg(0) => inst_RFSM_n_2
    );
inst_TFSM: entity work.design_1_uart_axi_interface_0_0_transmitfsm
     port map (
      baud_en => baud_en,
      clk => clk,
      gpio_tx_data(7 downto 0) => gpio_tx_data(7 downto 0),
      gpio_tx_rdy => gpio_tx_rdy,
      gpio_tx_start => gpio_tx_start,
      tx_pin => tx_pin
    );
rx_en_q_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => gpio_rx_en,
      Q => rx_en_q,
      R => '0'
    );
rx_ready_q_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => rx_ready,
      Q => rx_ready_q,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_uart_axi_interface_0_0 is
  port (
    clk : in STD_LOGIC;
    rx_pin : in STD_LOGIC;
    tx_pin : out STD_LOGIC;
    gpio_tx_data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gpio_tx_start : in STD_LOGIC;
    gpio_rx_en : in STD_LOGIC;
    gpio_rx_data : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gpio_rx_ready : out STD_LOGIC;
    gpio_tx_rdy : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_uart_axi_interface_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_uart_axi_interface_0_0 : entity is "design_1_uart_axi_interface_0_0,uart_axi_interface,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_uart_axi_interface_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_uart_axi_interface_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_uart_axi_interface_0_0 : entity is "uart_axi_interface,Vivado 2024.2";
end design_1_uart_axi_interface_0_0;

architecture STRUCTURE of design_1_uart_axi_interface_0_0 is
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_mode : string;
  attribute x_interface_mode of clk : signal is "slave clk";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
begin
U0: entity work.design_1_uart_axi_interface_0_0_uart_axi_interface
     port map (
      clk => clk,
      gpio_rx_data(7 downto 0) => gpio_rx_data(7 downto 0),
      gpio_rx_en => gpio_rx_en,
      gpio_rx_ready => gpio_rx_ready,
      gpio_tx_data(7 downto 0) => gpio_tx_data(7 downto 0),
      gpio_tx_rdy => gpio_tx_rdy,
      gpio_tx_start => gpio_tx_start,
      rx_pin => rx_pin,
      tx_pin => tx_pin
    );
end STRUCTURE;
