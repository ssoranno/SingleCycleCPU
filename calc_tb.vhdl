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
		prt: out std_logic;
		pInTemp:out std_logic;
		pSV: out std_logic_vector(3 downto 0);
		pSC: out std_logic;
		pPostS: out std_logic_vector(3 downto 0);
		ptemp2:out std_logic;
		pDB:out std_logic
	);
end component;

signal i,poop, poopO1, poopO2, pwb, plb, pp: std_logic_vector(7 downto 0);
signal poopR1, poopR2, prd: std_logic_vector(1 downto 0);
signal clk, pre,pout,prt,pInTemp, pSC, pDB, ptemp2: std_logic;
signal pSVal, pPostS: std_logic_vector(3 downto 0);

--file infile : text;

constant clk_period : time := 10 ns;

begin
--  Component instantiation.
c1: calc port map (i => I, clk => clk, poop=>poop, poopO1=>poopO1, poopO2=>poopO2, poopR1=>poopR1, poopR2=>poopR2, prd=>prd, pwb=>pwb, pre=>pre, pout=>pout, plb=>plb, pp=>pp, prt=>prt,pInTemp=>pInTemp, pSV=>pSVal, pSC=>pSC, pPostS=>pPostS, pDB=>pDB, ptemp2=>ptemp2);

-- Clock process
clk_process : process
begin
	for i in 1 to 50 loop
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
	-- Display 0 in all registers
	wait until rising_edge(clk);
	i<= "11000000";
	wait until rising_edge(clk);
	i<= "11000001";
	wait until rising_edge(clk);
	i<= "11000010";
	wait until rising_edge(clk);
	i<= "11000011";
	-- Load positive int 5
	wait until rising_edge(clk);
	i<= "10000101";
	wait until rising_edge(clk);
	i<= "11000000";
	-- Load negative int -3
	wait until rising_edge(clk);
	i<= "10011101";
	wait until rising_edge(clk);
	i<= "11000001";
	-- load 0
	wait until rising_edge(clk);
	i<= "10100000";
	wait until rising_edge(clk);
	i<= "11000010";
	-- load max positive 7
	wait until rising_edge(clk);
	i<= "10110111";
	wait until rising_edge(clk);
	i<= "11000011";
	-- load min negative -8
	wait until rising_edge(clk);
	i<= "10001000";
	wait until rising_edge(clk);
	i<= "11000000";
	-- add negative and 0 (-3=-3+0)(t1=t2+t1)
	wait until rising_edge(clk); -- add neg
	i<= "00011001";
	wait until rising_edge(clk);
	i<= "11000001";
	-- add positive and negative (4=7+(-3))(t2=t3+t1)
	wait until rising_edge(clk);
	i<= "00101101";
	wait until rising_edge(clk);
	i<= "11000010";
	-- add positive and positive(11=7+4)(t3=t3+t2)
	wait until rising_edge(clk);
	i<= "00111110";
	wait until rising_edge(clk);
	i<= "11000011";
	-- add two negatives(-11=-3+(-8))(t0=t1+t0)
	wait until rising_edge(clk); -- add 2 negs
	i<= "00000100";
	wait until rising_edge(clk);
	i<= "11000000";
	-- Displayadd results of all registers
	wait until rising_edge(clk);
	i<= "11000000";
	wait until rising_edge(clk);
	i<= "11000001";
	wait until rising_edge(clk);
	i<= "11000010";
	wait until rising_edge(clk);
	i<= "11000011";
	-- subtract positive numbers (7=11-4) (t3=t3-t2)
	wait until rising_edge(clk);
	i<= "01111110";
	wait until rising_edge(clk);
	i<= "11000011";
	-- subtract positive and negative number (-10=-3-7) (t1=t1-t3)
	wait until rising_edge(clk);
	i<= "01010111";
	wait until rising_edge(clk);
	i<= "11000001";
	-- subtract 2 negative numbers (-1=-11-(-10)) (t0=t0-t1)
	wait until rising_edge(clk);
	i<= "01000001";
	wait until rising_edge(clk);
	i<= "11000000";
	-- Load 0 into t0
	wait until rising_edge(clk);
	i<= "10000000";
	-- subtract negative number and 0 (10=0-(-10)) (t1=t0-t1)
	wait until rising_edge(clk);
	i<= "01010001";
	wait until rising_edge(clk);
	i<= "11000001";
	-- Displayadd results of all registers
	wait until rising_edge(clk);
	i<= "11000000";
	wait until rising_edge(clk);
	i<= "11000001";
	wait until rising_edge(clk);
	i<= "11000010";
	wait until rising_edge(clk);
	i<= "11000011";
	-- beq t0 and t1 testing false should move on to the next instruction
	wait until rising_edge(clk);
	i<= "11000101";
	wait until rising_edge(clk);
	i<= "11000000";
	-- load 7 into t2
	wait until rising_edge(clk);
	i<= "10100111";
	-- beq two equal positives and skip 1 instruction (t2 t3)
	wait until rising_edge(clk);
	i<= "11101101";
	wait until rising_edge(clk);
	i<= "11000000";
	wait until rising_edge(clk);
	i<= "11000011";
	-- beq 0 and other register continues to next instruction (t0 t1)
	wait until rising_edge(clk);
	i<= "11000101";
	wait until rising_edge(clk);
	i<= "11000000";
	-- load -8 into t2
	wait until rising_edge(clk);
	i<= "10101000";
	-- beq positive and negative (t2, t3) continue to next instructions
	wait until rising_edge(clk);
	i<= "11101110";
	wait until rising_edge(clk);
	i<= "11000011";
	wait until rising_edge(clk);
	
	-- i<= "10000001";
	-- wait until rising_edge(clk);
	-- i<= "10110010";
	-- wait until rising_edge(clk);
	-- i<= "10010001";
	-- wait until rising_edge(clk);
	-- i<= "10100111";
	-- wait until rising_edge(clk);
	-- i<= "11000110";
	-- wait until rising_edge(clk);
	-- i<= "11000001";
	-- wait until rising_edge(clk);
	-- i<= "11000010";
	-- wait until rising_edge(clk);
	-- i<= "11000011";
	-- wait until rising_edge(clk);
	
	
	
	wait;
end process;
end behav;