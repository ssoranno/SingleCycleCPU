-- Steven Soranno and Evan Deangelis
-- Main Calculator Entity

library ieee;
use ieee.std_logic_1164.all;

entity calc is
	port (
		I: in std_logic_vector(7 downto 0);
		clk: in std_logic
	);
end calc;

architecture behav of calc is

component regFile is
	port (
	r1 : in std_logic_vector(1 downto 0);
	r2 : in std_logic_vector(1 downto 0);
	rd : in std_logic_vector(1 downto 0);
	wb : in std_logic_vector(7 downto 0);
	clk : in std_logic;
	enable : in std_logic;
	o1 : out std_logic_vector(7 downto 0);
	o2 : out std_logic_vector(7 downto 0));
end component;

component inDecode is
	port(
	I  : in std_logic_vector(7 downto 0);
	ConSig : in std_logic;
    r1 : out std_logic_vector(1 downto 0);
	r2 : out std_logic_vector(1 downto 0);
	rd : out std_logic_vector(1 downto 0);
	imm : out std_logic_vector(3 downto 0));
end component;

component sign_extend is
	port(
	i : in std_logic_vector(3 downto 0);
 	o: out std_logic_vector(7 downto 0));
end component;

component print is
	port(
	I : in std_logic_vector(7 downto 0);
	EN : in std_logic;
	clk: in std_logic
	);
end component;

component add_sub is
	port(
		A:	in std_logic_vector (7 downto 0);
		B:	in std_logic_vector (7 downto 0);
		mode: in std_logic;
		flow: out std_logic;        
		S:	out std_logic_vector(7 downto 0));
end component;

component controller is
	port(
	i : in std_logic_vector(7 downto 0);
 		aluSkip: out STD_LOGIC;
 		print: out STD_LOGIC;
 		dispBEQ: out STD_LOGIC;
 		regwrite: out STD_LOGIC;
 		addsub: out STD_LOGIC;
 		load: out STD_LOGIC
	);
end component;

component shift_reg is
	port(
		I:	in std_logic_vector (3 downto 0); -- Input vector
		I_SHIFT_IN: in std_logic; -- Value to shift in
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0) -- ouput vector
	);
end component;

signal R1, R2, RD  : std_logic_vector(1 downto 0);
signal IMM, skipVal, inSkip, postskip, newIMM : std_logic_vector(3 downto 0);
signal ALUSKIP, PT, DISPBEQ, REGWRITE, ADDSUB, LOAD: std_logic;
signal O1, O2, ext, WB, sum, ALUO, p, LB : std_logic_vector(7 downto 0);
signal f, skipControl, outskip, REnable, inTemp, printEnable, temp2, SRenable: std_logic;

begin

con: controller port map(i=>I, aluSkip=>ALUSKIP, print=>PT, dispBEQ=>DISPBEQ, regwrite=>REGWRITE, addsub=>ADDSUB, load=>LOAD);
ID: inDecode port map(I=> I, ConSig => DISPBEQ, r1=>R1, r2=>R2, rd=> RD, imm => IMM);
SE: sign_extend port map(i=>IMM, o=>ext);
reg: regFile port map(r1=> R1, r2=> R2, rd=>RD, wb=>WB, clk=>REnable, enable=>REGWRITE, o1=>O1, o2=>O2);
ALU: add_sub port map(A=>O1, B=>O2, mode=>ADDSUB, flow=>f, S=>sum);

ALUO<= sum when ALUSKIP='0' else
	O1 when ALUSKIP='1';

p<= ALUO when PT='1';
LB<= ALUO when PT='0';

printEnable<= PT and not inTemp;
	
P1: print port map(I=>p, EN=>printEnable, clk=>clk);

WB<= ext when LOAD='0' else
	LB when LOAD='1';

skipControl<= temp2 when DISPBEQ = '1' else
	'0' when DISPBEQ = '0';
	

temp2 <= not(LB(0) or LB(1) or LB(2) or LB(3) or LB(4) or LB(5) or LB(6) or LB(7));

newIMM<= "0010" when IMM = "0001" else
	"0100" when IMM = "0010";

skipVal<= newIMM when skipControl = '1' else
	"0000" when skipControl = '0';

inSkip<= skipVal when inTemp = '0' else
	postskip when inTemp = '1';
	
SRenable<= inTemp or DISPBEQ;

SR : shift_reg port map(I => inSkip, I_SHIFT_IN=> '0', sel => "10", clock=>clk, enable => SRenable, O=>postskip);

inTemp<= '0' when outskip = 'U' or outskip = '0' else
	'1' when outskip = '1';
outskip<=postskip(0) or postskip(1) or postskip(2) or postskip(3);


REnable<= clk when inTemp='0' else
	'0' when inTemp='1';

end behav;