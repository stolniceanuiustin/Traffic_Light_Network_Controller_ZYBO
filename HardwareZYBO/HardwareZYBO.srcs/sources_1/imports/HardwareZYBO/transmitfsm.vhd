library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity transmitfsm is
    Port ( clk: in STD_LOGIC;
           rst : in STD_LOGIC;
           baud_en : in STD_LOGIC;
           tx_en : in STD_LOGIC;
           tx_data : in STD_LOGIC_VECTOR (7 downto 0);
           tx : out STD_LOGIC;
           tx_rdy : out STD_LOGIC);
end transmitfsm;

architecture Behavioral of transmitfsm is

type state_type is (idle, start, bits, stop); 
signal state : state_type := idle;
signal bit_cnt : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- FSM state transition
    process (clk, rst)
    begin
        if rst='1' then
            state <= idle;
        elsif rising_edge(clk) then
            if baud_en='1' then
                case state is
                    when idle =>    if tx_en = '1' then
                                        state <= start;
                                    else
                                        state <= idle;
                                    end if;
                                    bit_cnt <= (others => '0');
                    when start =>   state <= bits;
                    when bits =>    if bit_cnt < 7 then
                                        state <= bits;
                                    else
                                        state <= stop;
                                    end if;
                                    bit_cnt <= bit_cnt + 1;
                    when stop =>    state <= idle;
                    when others =>  state <= idle;
                end case;
            end if;
        end if;
    end process;
    
    -- FSM outputs
    process(state, tx_data, bit_cnt)
    begin
        case state is
            when idle => tx <= '1'; tx_rdy <= '1'; 
            when start => tx <= '0'; tx_rdy <= '0';
            when bits => tx <= tx_data(conv_integer(bit_cnt));
                         tx_rdy <= '0';
            when stop => tx <= '1'; tx_rdy <= '0'; 
            when others => tx <= 'X'; tx_rdy <= 'X';
        end case;
    end process;

end Behavioral;