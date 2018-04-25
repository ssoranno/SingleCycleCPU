library ieee;
use ieee.std_logic_1164.all;

entity Controller_tb is	
end entity Controller_tb;

architecture test of Controller_tb is

component Controller is
port(	i : in std_logic_vector(7 downto 0);
 		aluSkip: out STD_LOGIC;
 		print: out STD_LOGIC;
 		dispBEQ: out STD_LOGIC;
 		regwrite: out STD_LOGIC;
 		addsub: out STD_LOGIC;
 		load: out STD_LOGIC
	);
end component;

signal a: std_logic_vector(7 downto 0);
signal alu, p, d, r, add, l: STD_LOGIC;

begin
	control:Controller
	port map (
		i=>a,
		aluSkip=>alu,
		print=>p,
		dispBEQ=>d,
		regwrite=>r,
		addsub=>add,
		load=>l
	);

	process begin
		wait for 10 ns;
		--testing addition of two positives
		a<="00110011";

		wait for 10 ns;
		--testing addition of two positives
		a<="01110011";

		wait for 10 ns;
		--testing addition of two positives
		a<="10110011";

		wait for 10 ns;
		--testing addition of two positives
		a<="11110011";

		wait for 10 ns;
		--testing addition of two positives
		a<="11000011";

		wait for 10 ns;
	wait;
	end process;
end test;
