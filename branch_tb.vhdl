-- Steven Soranno and Evan Deangelis
-- Problem 2 part b

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity branch_tb is
end branch_tb;

architecture behav of branch_tb is
--  Declaration of the component that will be instantiated.
component branch 
	port (
		I: in std_logic_vector(3 downto 0);
		clk: in std_logic;
		O: out std_logic
	);
end component;

signal i : std_logic_vector(3 downto 0);
signal clk, o: std_logic;

constant clk_period : time := 10 ns;

begin
--  Component instantiation.
b1: branch port map (i => I, clk => clk, o=>O);

-- Clock process
clk_process : process
begin
	for i in 1 to 7 loop
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

	i<="0000";
	wait for 10 ns;
	
	i<="0001";
	wait for 10 ns;
	
	i<="0000";
	wait for 20 ns;
	
	i<="0010";
	wait for 10 ns;
	
	wait;
end process;
end behav;