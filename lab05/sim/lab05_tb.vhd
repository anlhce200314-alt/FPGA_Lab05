library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab05_tb is
end entity lab05_tb;

architecture sim of lab05_tb is
    constant CLK_PERIOD : time := 20 ns;
    
    signal clk        : STD_LOGIC := '0';
    signal i_Switch_1 : STD_LOGIC := '0';
    signal i_Switch_2 : STD_LOGIC := '0';
    
    signal o_LED_1    : STD_LOGIC;
    signal o_LED_2    : STD_LOGIC;
    signal o_LED_3    : STD_LOGIC;
    signal o_LED_4    : STD_LOGIC;

begin
    clk <= not clk after CLK_PERIOD / 2;

    DUT: entity work.lab05
        port map (
            i_Clk      => clk,
            i_Switch_1 => i_Switch_1,
            i_Switch_2 => i_Switch_2,
            o_LED_1    => o_LED_1,
            o_LED_2    => o_LED_2,
            o_LED_3    => o_LED_3,
            o_LED_4    => o_LED_4
        );

    stimulus: process
    begin
        wait for 1 * CLK_PERIOD;

        i_Switch_2 <= '0';
        i_Switch_1 <= '0';

        wait for 40 ms; 
        assert o_LED_1 = '1' report "T1 FAILED: LED 1 must be ON" severity error;
        assert o_LED_2 = '0' and o_LED_3 = '0' and o_LED_4 = '0' 
            report "T1 FAILED: Other LEDs must be OFF when SW=00" severity error;

        wait for 84 ms;
        assert o_LED_1 = '0' report "T1 FAILED: LED 1 must toggle to OFF" severity error;

        i_Switch_2 <= '0';
        i_Switch_1 <= '1';

        wait for 84 ms;
        assert o_LED_2 = '1' report "T2 FAILED: LED 2 must be ON" severity error;
        assert o_LED_1 = '0' and o_LED_3 = '0' and o_LED_4 = '0' 
            report "T2 FAILED: Other LEDs must be OFF when SW=01" severity error;

        wait for 84 ms;
        assert o_LED_2 = '0' report "T2 FAILED: LED 2 must toggle to OFF" severity error;

        i_Switch_2 <= '1';
        i_Switch_1 <= '0';
        
        wait for 84 ms;
        assert o_LED_3 = '1' report "T3 FAILED: LED 3 must be ON" severity error;
        assert o_LED_1 = '0' and o_LED_2 = '0' and o_LED_4 = '0' 
            report "T3 FAILED: Other LEDs must be OFF when SW=10" severity error;
            
        wait for 84 ms;
        assert o_LED_3 = '0' report "T3 FAILED: LED 3 must toggle to OFF" severity error;

        i_Switch_2 <= '1';
        i_Switch_1 <= '1';
        
        wait for 84 ms;
        assert o_LED_4 = '1' report "T4 FAILED: LED 4 must be ON" severity error;
        assert o_LED_1 = '0' and o_LED_2 = '0' and o_LED_3 = '0' 
            report "T4 FAILED: Other LEDs must be OFF when SW=11" severity error;
            
        wait for 84 ms;
        assert o_LED_4 = '0' report "T4 FAILED: LED 4 must toggle to OFF" severity error;

        report "LAB05: ALL SELF-CHECKING TESTS PASSED" severity note;
        wait;
        
    end process;

end architecture sim;