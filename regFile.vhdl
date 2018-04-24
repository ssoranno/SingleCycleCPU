-- Steven Soranno and Evan Deangelis
-- regFile

library ieee;
use ieee.std_logic_1164.all;

entity regFile is
	port (
	r1 : in std_logic_vector(1 downto 0);
	r2 : in std_logic_vector(1 downto 0);
	rd : in std_logic_vector(1 downto 0);
	wb : in std_logic_vector(7 downto 0);
	clk : in std_logic;
	enable : in std_logic;
	o1 : out std_logic_vector(7 downto 0);
	o2 : out std_logic_vector(7 downto 0));
end regFile;

architecture reg of regFile is

component flipFlop_8bit is	
	port(
	d : in std_logic_vector(7 downto 0);
	clk : in std_logic;
	enable : in std_logic;
	q : out std_logic_vector(7 downto 0));
end component;

signal v0 : std_logic_vector(7 downto 0);
signal v1 : std_logic_vector(7 downto 0);
signal v2 : std_logic_vector(7 downto 0);
signal v3 : std_logic_vector(7 downto 0);

signal t0 : std_logic_vector(7 downto 0);
signal t1 : std_logic_vector(7 downto 0);
signal t2 : std_logic_vector(7 downto 0);
signal t3 : std_logic_vector(7 downto 0);



begin

v0<= wb when rd= "00";
v1<= wb when rd= "01";
v2<= wb when rd= "10";
v3<= wb when rd= "11";

FF0: flipFlop_8bit port map(d=>v0, clk=>clk, enable=>enable, q=>t0);
FF1: flipFlop_8bit port map(d=>v1, clk=>clk, enable=>enable, q=>t1);
FF2: flipFlop_8bit port map(d=>v2, clk=>clk, enable=>enable, q=>t2);
FF3: flipFlop_8bit port map(d=>v3, clk=>clk, enable=>enable, q=>t3);

o1<= t0 when r1="00" else
	t1 when r1="01" else
	t2 when r1="10" else
	t3 when r1="11";

o2<= t0 when r2="00" else
	t1 when r2="01" else
	t2 when r2="10" else
	t3 when r2="11";

end reg;