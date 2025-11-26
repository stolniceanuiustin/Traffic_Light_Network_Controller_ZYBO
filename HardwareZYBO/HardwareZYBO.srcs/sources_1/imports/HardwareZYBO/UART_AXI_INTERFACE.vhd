library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_axi_interface is
  Port ( 
         clk : in STD_LOGIC;
         rx_pin : in STD_LOGIC;
         tx_pin : out STD_LOGIC;
         gpio_tx_data  : in STD_LOGIC_VECTOR(7 downto 0); 
         gpio_tx_start : in STD_LOGIC;                    
         gpio_rx_data  : out STD_LOGIC_VECTOR(7 downto 0); 
         gpio_rx_ready : out STD_LOGIC;
         gpio_tx_rdy   : out STD_LOGIC                    
         );
end uart_axi_interface;

architecture Behavioral of uart_axi_interface is

    component transmitfsm
    Port ( clk: STD_LOGIC;
           rst : in STD_LOGIC;
           baud_en : in STD_LOGIC;
           tx_en : in STD_LOGIC;
           tx_data : in STD_LOGIC_VECTOR (7 downto 0);
           tx : out STD_LOGIC;
           tx_rdy : out STD_LOGIC);
    end component;

    component receivefsm
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           baud_en : in STD_LOGIC;
           rx : in STD_LOGIC;
           rx_data : out STD_LOGIC_VECTOR (7 downto 0);
           rx_rdy : out STD_LOGIC);
    end component;


    signal baud_en, baud_en_x16 : STD_LOGIC;
    signal cnt : STD_LOGIC_VECTOR(13 downto 0) := (others => '0');
    signal cnt_x16 : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    
begin


    -- 10,000,000 / 9600 = 5208 - 1 = 5207
    process(clk)
    begin
        if rising_edge(clk) then
            if cnt = 10415 then 
                baud_en <= '1';
                cnt <= (others => '0');
            else
                baud_en <= '0';
                cnt <= cnt + 1;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if cnt_x16 = 650 then -- 5208 / 16
                baud_en_x16 <= '1';
                cnt_x16 <= (others => '0');
            else
                baud_en_x16 <= '0';
                cnt_x16 <= cnt_x16 + 1;
            end if;
        end if;
    end process;

    inst_TFSM: transmitfsm port map(
        clk => clk, 
        rst => '0', 
        baud_en => baud_en, 
        tx_en => gpio_tx_start,
        tx_data => gpio_tx_data, 
        tx => tx_pin, 
        tx_rdy => gpio_tx_rdy -- Not needed, as traffic light doesnt change that quickly
    );

    inst_RFSM: receivefsm port map(
        clk => clk, 
        rst => '0', 
        baud_en => baud_en_x16, 
        rx => rx_pin, 
        rx_data => gpio_rx_data, 
        rx_rdy => gpio_rx_ready  
    );

end Behavioral;