-- Steven Soranno and Evan Deangelis
-- generic 2 to 1 mux

library ieee;
use ieee.std_logic_1164.all;

entity inDecode is
	port (
    I  : in std_logic_vector(7 downto 0);
	ConSig : in std_logic;
    r1 : out std_logic_vector(1 downto 0);
	r2 : out std_logic_vector(1 downto 0);
	rd : out std_logic_vector(1 downto 0);
	imm : out std_logic_vector(3 downto 0));
end inDecode;

architecture decode of inDecode is
signal s1 : std_logic_vector(1 downto 0);
signal s2 : std_logic_vector(3 downto 0);
begin
	
	s1<= I(5 downto 4) when ConSig='0' else
		I(1 downto 0) when ConSig='1';
	
	s2<= "0000" when I(1 downto 0) = "00" else
		"0001" when I(1 downto 0) = "01" else
		"0010" when I(1 downto 0) = "10" else
		"0011" when I(1 downto 0) = "11";
	
	r1<= I(3 downto 2) when I(7) = '0' else
		s1 when I(7)= '1';
	
	r2<= I(1 downto 0) when I(7) = '0' else
		I(3 downto 2) when I(7) = '1';
	
	rd<= I(5 downto 4);
	
	imm<= s2 when I(6)= '1' else
		I(3 downto 0) when I(6) = '0';
		
end decode;