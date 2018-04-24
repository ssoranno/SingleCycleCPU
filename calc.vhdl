-- Steven Soranno and Evan Deangelis
-- Problem 2 part b

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity calc is
	port (
		I: in std_logic_vector(7 downto 0);
		clk: in std_logic
	);
end calc;

architecture behav of calc is
begin

end behav;