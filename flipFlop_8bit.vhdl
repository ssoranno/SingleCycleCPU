-- Steven Soranno and Evan Deangelis
-- regFile

library ieee;
use ieee.std_logic_1164.all;

entity flipFlop_8bit is
	port(
	d : in std_logic_vector(7 downto 0);
	clk : in std_logic;
	enable : in std_logic;
	q : out std_logic_vector(7 downto 0));
end flipFlop_8bit;

architecture ff of flipFlop_8bit is
begin

process(clk)
begin
	if rising_edge(clk) then
		if(enable = '1') then
			q<= d;
		end if;
	end if;
end process;

end ff;
