library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx_tb is
end uart_tx_tb;

architecture behavior of uart_tx_tb is

    -- Component Declaration
    component uart_tx
        Port (
            clk       : in  std_logic;
            tx_start  : in  std_logic;
            data_in   : in  std_logic_vector(7 downto 0);
            tx_out    : out std_logic
        );
    end component;

    -- Signals
    signal clk      : std_logic := '0';
    signal tx_start : std_logic := '0';
    signal data_in  : std_logic_vector(7 downto 0) := (others => '0');
    signal tx_out   : std_logic;

    constant clk_period : time := 20 ns;

begin

    -- Instantiate UART TX
    uut: uart_tx port map (
        clk      => clk,
        tx_start => tx_start,
        data_in  => data_in,
        tx_out   => tx_out
    );

    -- Clock Process
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        wait for 100 ns;

        -- Send data 10101010
        data_in  <= "10101010";
        tx_start <= '1';
        wait for clk_period;

        tx_start <= '0';

        -- Wait long enough for transmission
        wait for 1000 ns;

        wait;
    end process;

end behavior;
