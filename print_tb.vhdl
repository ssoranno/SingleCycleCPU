-- Steven Soranno and Evan Deangelis
-- Problem 2 part b

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity print_tb is
end print_tb;

architecture behav of print_tb is
--  Declaration of the component that will be instantiated.
component print 
	port (
		I: in std_logic_vector(7 downto 0)
	);
end component;

signal i : std_logic_vector(7 downto 0);

begin

p: print port map(i=>I);

process
begin
	i<="00010001";
	wait for 10 ns;
	
	i<="10101010";
	wait for 10 ns;
	wait;
end process;
end behav;