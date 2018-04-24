-- Steven Soranno and Evan Deangelis
-- Problem 3

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity inDecode_tb is
end inDecode_tb;

architecture test of inDecode_tb is
--  Declaration of the component that will be instantiated.
	component inDecode is
	port (
    I  : in std_logic_vector(7 downto 0);
	ConSig : in std_logic;
    r1 : out std_logic_vector(1 downto 0);
	r2 : out std_logic_vector(1 downto 0);
	rd : out std_logic_vector(1 downto 0);
	imm : out std_logic_vector(3 downto 0)
	);
	end component;

	signal i : std_logic_vector(7 downto 0);
	signal cs : std_logic;
	signal R1 : std_logic_vector(1 downto 0);
	signal R2 : std_logic_vector(1 downto 0);
	signal Rd : std_logic_vector(1 downto 0);
	signal IMM : std_logic_vector(3 downto 0);
	
begin
	decode: inDecode
	port map (
		I=> i,
		ConSig=> cs,
		r1=>R1,
		r2=>R2,
		rd=>Rd,
		imm=>IMM
	);

	process begin
	
	cs<= '0';
	i<= "00000000";
	wait for 10 ns;
	
	i<= "10001010";
	wait for 10 ns;
	
	i<= "01011100";
	wait for 10 ns;
	
	cs<= '0';
	i<= "11100001";
	wait for 10 ns;
	
	wait;
	end process;
end test;