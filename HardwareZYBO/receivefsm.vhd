library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity receivefsm is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           baud_en : in STD_LOGIC;
           rx : in STD_LOGIC;
           rx_data : out STD_LOGIC_VECTOR (7 downto 0);
           rx_rdy : out STD_LOGIC);
end receivefsm;

architecture Behavioral of receivefsm is

type state_type is (idle, start, bits, waitt, stop);
signal state : state_type := idle; 
signal baud_cnt : STD_LOGIC_VECTOR (3 downto 0);
signal bit_cnt : STD_LOGIC_VECTOR (2 downto 0);

begin

    -- FSM state transition
    process(clk, rst)
    begin
        if rst = '1' then
            state <= idle;
        elsif rising_edge(clk) then
            if baud_en = '1' then
                
                case state is
                    when idle =>    if rx = '0' then
                                        state <= start;
                                    else
                                        state <= idle;
                                    end if;
                                    baud_cnt <= (others => '0');
                                    bit_cnt <= (others => '0');
                    when start =>   if rx = '1' then
                                        state <= idle;
                                    elsif baud_cnt < 7 then
                                        state <= start;
                                        baud_cnt <= baud_cnt + 1;
                                    else
                                        state <= bits;
                                        baud_cnt <= (others => '0');
                                    end if;
                    when bits =>    if baud_cnt = 15 and bit_cnt = 7 then
                                        state <= stop;
                                    else
                                        state <= bits;
                                    end if;
                                    if baud_cnt = 15 then
                                        rx_data(conv_integer(bit_cnt)) <= rx;
                                        bit_cnt <= bit_cnt + 1;
                                    end if;                                                           
                                    baud_cnt <= baud_cnt + 1;
                    when stop =>    if baud_cnt < 15 then
                                        state <= stop;
                                    else
                                        state <= waitt;
                                    end if;                              
                                    baud_cnt <= baud_cnt + 1;
                    when waitt =>   if baud_cnt < 7 then
                                        state <= waitt;
                                    else
                                        state <= idle;
                                    end if;
                                    baud_cnt <= baud_cnt + 1;
                    when others =>  state <= idle;    
                end case;       
            end if;
        end if;
    end process;

    -- FSM outputs
    process (state)
    begin
        case state is
            when idle => rx_rdy <= '0';
            when start => rx_rdy <='0';
            when bits => rx_rdy <='0'; 
            when stop => rx_rdy <='0';
            when waitt => rx_rdy <='1';
            when others => rx_rdy <='X';
        end case;
    end process;
    
end Behavioral;