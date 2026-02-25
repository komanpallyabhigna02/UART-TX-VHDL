
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
    Port (
        clk       : in  std_logic;
        tx_start  : in  std_logic;
        data_in   : in  std_logic_vector(7 downto 0);
		          tx_out    : out std_logic
    );
end uart_tx;

architecture Behavioral of uart_tx is

    type state_type is (IDLE, START, DATA, STOP);
    signal state : state_type := IDLE;
    signal bit_index : integer range 0 to 7 := 0;
	 begin

process(clk)
begin
    if rising_edge(clk) then
        case state is

            when IDLE =>
                tx_out <= '1';
                if tx_start = '1' then
                    state <= START;
                end if;
					 when START =>
                tx_out <= '0';
                state <= DATA;

            when DATA =>
                tx_out <= data_in(bit_index);
                if bit_index = 7 then
                    bit_index <= 0;
                    state <= STOP;
                else
                    bit_index <= bit_index + 1;
                end if;

            when STOP =>
                tx_out <= '1';
                state <= IDLE;

        end case;
    end if;
end process;

end Behavioral;

