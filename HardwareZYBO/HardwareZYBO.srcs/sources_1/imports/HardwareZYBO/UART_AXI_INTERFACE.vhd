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
         gpio_rx_en   : in STD_LOGIC;
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
    
    --A circular buffer for recieving data - this fixes the garbage values we get
    constant FIFO_DEPTH : integer := 8;
    type fifo_mem_type is array (0 to FIFO_DEPTH-1) of std_logic_vector(7 downto 0); 
    signal fifo_mem : fifo_mem_type := (others => (others => '0'));
    
    signal fifo_wr_ptr : integer range 0 to FIFO_DEPTH-1 := 0;
    signal fifo_rd_ptr : integer range 0 to FIFO_DEPTH-1 := 0;
    signal fifo_count  : integer range 0 to FIFO_DEPTH := 0;
    
    signal rx_byte : std_logic_vector(7 downto 0);
    signal rx_ready : std_logic;
    
    
    signal rx_ready_q : std_logic := '0'; --stores the previous state of rx_ready, because rx_ready stays high for 8 clock cycles
    signal rx_write_en : std_logic;
begin

    rx_ready_update_logic: process(clk)
    begin 
        if rising_edge(clk) then 
            rx_ready_q <= rx_ready;
        end if;
    end process;
    
    rx_write_en <= rx_ready and not rx_ready_q;
    
    fifo_wr: process(clk)
    begin 
        if rising_edge(clk) then 
        --write byte into FIFO if recieveFSM has new data && FIFO not fuill 
            if rx_write_en = '1' and fifo_count < FIFO_DEPTH then 
                fifo_mem(fifo_wr_ptr) <= rx_byte; 
                fifo_wr_ptr <= (fifo_wr_ptr + 1) mod FIFO_DEPTH;
                fifo_count <= fifo_count + 1;
            end if;
        end if;
    end process;
    
    --So CPU puts gpio_rx_en on 1, then reads, then puts it back to 0 when it got all the data!
    fifo_rd: process(clk)
    begin 
        if rising_edge(clk) thne
        --we assume CPU will read while gpio_rx_ready is on so we autoadvance!
            if fifo_count > 0 and gpio_rx_en = '1' then 
                fifo_rd_ptr <= (fifo_rd_ptr + 1) mod FIFO_DEPTH;
                fifo_count <= fifo_count - 1;
            end if;
        end if;
    end process;
    
    gpio_rx_ready <= '1' when fifo_count > 0 else '0';
    gpio_rx_data <= fifo_mem(fifo_rd_ptr) when fifo_count > 0 else (others => '0');

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
        rx_data => rx_byte, 
        rx_rdy => rx_ready  
    );

end Behavioral;