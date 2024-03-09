library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDivider is
    Port (
        CLK_MASTER : in STD_LOGIC;  -- 50 MHz input clock
        CLK_SLOW   : out STD_LOGIC  -- 1 kHz output clock
    );
end entity ClockDivider;

architecture arch of ClockDivider is
    constant CLK_MASTER_FREQ : natural := 50000000;  -- 50 MHz
    constant CLK_SLOW_FREQ   : natural := 1000;      -- 1 kHz
    constant MAX_COUNT       : natural := CLK_MASTER_FREQ / CLK_SLOW_FREQ;
    shared variable counter   : natural := 0;
    signal LOCAL_CLK_SLOW    : STD_LOGIC := '0';
begin
    clock_proc: process (CLK_MASTER)
    begin
        if rising_edge(CLK_MASTER) then
            counter := counter + 1;
            if counter >= MAX_COUNT then
                counter := 0;
                LOCAL_CLK_SLOW <= not LOCAL_CLK_SLOW;
                CLK_SLOW <= LOCAL_CLK_SLOW;
            end if;
        end if;
    end process;
end arch;
