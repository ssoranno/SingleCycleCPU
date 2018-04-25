library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity add_sub_tb is
end add_sub_tb;

architecture test of add_sub_tb is
--  Declaration of the component that will be instantiated.
	component add_sub is
	port(	A:	in std_logic_vector (7 downto 0);
			B:	in std_logic_vector (7 downto 0);
			mode: in std_logic;
			flow: out std_logic;        
			S:	out std_logic_vector(7 downto 0)
	);
	end component;

	signal a, b, s: std_logic_vector(7 downto 0);
	signal mode, flow: std_logic;
begin
	adder: add_sub
	port map (
		A=> a,
		B=> b,
		mode=>mode,
		flow=>flow,
		S=>s
	);

	process begin
		wait for 10 ns;
		--testing addition of two positives
		a<="00000001";
		b<="00000001";
		mode<='0';

		wait for 10 ns;
		--addition of a negative number and a positive
		a<="11111001";
		b<="00000001";
		mode<='0';

		wait for 10 ns;
		--subtracting of two positives
		a<="00000001";
		b<="00000001";
		mode<='1';
		
		wait for 10 ns;
		--overflow of addition
		a<="00000111";
		b<="00000010";
		mode<='0';

		wait for 10 ns;
		--underflow of subtraction
		a<="11111001";
		b<="00000010";
		mode<='1';

		wait for 10 ns;
		--subtraction of two positive numbers with a negative result
		a<="00000001";
		b<="00000010";
		mode<='1';

		wait for 10 ns;
		--subtraction of a positive and a negative
		a<="00000001";
		b<="11111010";
		mode<='1';

		wait for 10 ns;
		-- addition of two negative
		a<="11111100";
		b<="11111110";
		mode<='0';

		wait for 10 ns;
		-- subtraction of two negative
		a<="11111100";
		b<="11111110";
		mode<='1';

		wait for 10 ns;
	wait;
	end process;
end test;