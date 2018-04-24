library ieee;
use ieee.std_logic_1164.all;

entity Controller is
port(	i : in std_logic_vector(7 downto 0);
 		aluSkip: out STD_LOGIC;
 		print: out STD_LOGIC;
 		dispBEQ: out STD_LOGIC;
 		regwrite: out STD_LOGIC;
 		addsub: out STD_LOGIC;
 		load: out STD_LOGIC
	);
end Controller;

architecture behav of Controller is

	signal s : std_logic_vector(3 downto 0);

begin

	addsub<=i(7) nor i(6);
	load<= not i(7);
	regwrite<=i(6) nand i(7);
	s(3)<= (not i(6)) and i(7);
	s(2)<= not(i(5) or i(4) or i(3) or i(2));
	s(1)<= i(7) and i(6);
	s(0)<= s(1) and s(2);
	print<= s(0);
	aluSkip<= s(3) or s(0);
	dispBEQ<= s(1) and (not s(2));

	
end architecture behav;