-- Steven Soranno and Evan Deangelis
-- Problem 2 part b

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity calc_tb is
end calc;

architecture behav of calc_tb is
--  Declaration of the component that will be instantiated.
component calc 
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
file infile : TEXT open read_mode is "input.txt";
variable data : std_logic_vector(7 downto 0);
begin
	while not(endfile(infile)) loop
	if risingEdge(clk) then
		read(infile,data);
		i<= data;
	end if;
	end loop;
	
	wait;
end process;
end behav;