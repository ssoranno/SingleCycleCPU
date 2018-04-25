library ieee;
use ieee.std_logic_1164.all;

entity sign_extend_tb is	
end entity sign_extend_tb;

architecture test of sign_extend_tb is

 component sign_extend is
 port(	i : in std_logic_vector(3 downto 0);
 		o: out std_logic_vector(7 downto 0)
	);
end component;

signal a: std_logic_vector(3 downto 0);
signal o: std_logic_vector(7 downto 0);

begin
	sign:sign_extend
	port map (
		i=>a,
		o=>o
	);

	process begin
		wait for 10 ns;
		--testing addition of two positives
		a<="0011";

		wait for 10 ns;
		--testing addition of two positives
		a<="1011";

		wait for 10 ns;
	wait;
	end process;
end test;

