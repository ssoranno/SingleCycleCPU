-- Steven Soranno and Evan Deangelis
-- Problem 2 part b

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity regFile_tb is
end regFile_tb;

architecture behav of regFile_tb is
--  Declaration of the component that will be instantiated.
component regFile 
	port (
		r1 : in std_logic_vector(1 downto 0);
		r2 : in std_logic_vector(1 downto 0);
		rd : in std_logic_vector(1 downto 0);
		wb : in std_logic_vector(7 downto 0);
		clk : in std_logic;
		enable : in std_logic;
		o1 : out std_logic_vector(7 downto 0);
		o2 : out std_logic_vector(7 downto 0)
	);
end component;

signal R1, R2, Rd : std_logic_vector(1 downto 0);
signal WB, O1,O2 : std_logic_vector(7 downto 0);
signal clk, enable : std_logic;

constant clk_period : time := 10 ns;

begin
--  Component instantiation.
regFile1: regFile port map (r1 => R1, r2 => R2, rd=>Rd, wb=>WB, clk => clk, enable => enable, o1=>O1, o2=>O2);

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
begin
	
	r1<="01";
	r2<="10";
	rd<="10";
	enable<='1';
	wb<="00000001";
	wait for 10 ns;
	
	r1<="00";
	r2<="01";
	rd<="01";
	wb<="00000001";
	wait for 10 ns;
	
	r1<="01";
	r2<="10";
	rd<="10";
	enable<='0';
	wb<="00000101";
	wait for 10 ns;
	
	r1<="01";
	r2<="10";
	rd<="10";
	enable<='1';
	wb<="00000101";
	wait for 10 ns;
	
	wait;
	end process;
end behav;

