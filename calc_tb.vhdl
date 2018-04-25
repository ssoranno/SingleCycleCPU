-- Steven Soranno and Evan Deangelis
-- Problem 2 part b

library ieee;
use ieee.std_logic_1164.all;
use STD.Textio.all;
--use ieee.std_logic_textio.all;

--  A testbench has no ports.
entity calc_tb is
end calc_tb;

architecture behav of calc_tb is
--  Declaration of the component that will be instantiated.
component calc
	port (
		I: in std_logic_vector(7 downto 0);
		clk: in std_logic;
		poop: out std_logic_vector(7 downto 0);
		poopO1: out std_logic_vector(7 downto 0);
		poopO2: out std_logic_vector(7 downto 0);
		poopR1: out std_logic_vector(1 downto 0);
		poopR2: out std_logic_vector(1 downto 0);
		prd: out std_logic_vector(1 downto 0);
		pwb: out std_logic_vector(7 downto 0);
		pre: out std_logic;
		pout: out std_logic;
		pp:out std_logic_vector(7 downto 0);
		plb:out std_logic_vector(7 downto 0);
		prt: out std_logic
	);
end component;

signal i,poop, poopO1, poopO2, pwb, plb, pp: std_logic_vector(7 downto 0);
signal poopR1, poopR2, prd: std_logic_vector(1 downto 0);
signal clk, pre,pout,prt: std_logic;

--file infile : text;

constant clk_period : time := 10 ns;

begin
--  Component instantiation.
c1: calc port map (i => I, clk => clk, poop=>poop, poopO1=>poopO1, poopO2=>poopO2, poopR1=>poopR1, poopR2=>poopR2, prd=>prd, pwb=>pwb, pre=>pre, pout=>pout, plb=>plb, pp=>pp, prt=>prt);

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
--file   infile    : text is in  "input.txt";
--variable l : line;
--variable data : std_logic_vector(7 downto 0);
begin
	--file_open(infile, "input.txt",  read_mode);
	
	--while not(endfile(infile)) loop
		--if rising_edge(clk) then
		--readline(infile, l);
		--read(l,data);
		--i<= data;
		--end if;
	--end loop;
	wait until rising_edge(clk);
	i<= "10000001";
	wait until rising_edge(clk);
	i<= "10010010";
	wait until rising_edge(clk);
	i<= "00100001";
	wait until rising_edge(clk);
	i<= "11000010";
	wait until rising_edge(clk);
	i<= "10000001";
	wait until rising_edge(clk);
	
	wait;
end process;
end behav;