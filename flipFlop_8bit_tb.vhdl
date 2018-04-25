-- Steven Soranno and Evan Deangelis
-- Problem 2 part b

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity flipFlop_8bit_tb is
end flipFlop_8bit_tb;

architecture behav of flipFlop_8bit_tb is
--  Declaration of the component that will be instantiated.
component flipFlop_8bit
port(
	d : in std_logic_vector(7 downto 0);
	clk : in std_logic;
	enable : in std_logic;
	q : out std_logic_vector(7 downto 0));
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg_8bit use entity work.shift_reg_8bit(rtl);
signal D, Q : std_logic_vector(7 downto 0);
signal clk, enable : std_logic;

constant clk_period : time := 10 ns;

begin
--  Component instantiation.
ff0: flipFlop_8bit port map (d => D, clk => clk, enable => enable, q => Q);

-- Clock process
clk_process : process
begin
	for i in 1 to 30 loop
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
	end loop;
	wait;
end process;

-- This process does the real job.
process
begin
	enable<='1';
	d<= "00000001";
	wait for 10 ns;
	d<= "00000010";
	wait for 10 ns;
	wait;
end process;
end behav;