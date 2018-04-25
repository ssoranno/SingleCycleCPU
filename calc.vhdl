-- Steven Soranno and Evan Deangelis
-- Problem 2 part b

library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
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
	I : in std_logic_vector(7 downto 0));
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
signal IMM  : std_logic_vector(3 downto 0);
signal ALUSKIP, PRINT, DISPBEQ, REGWRITE, ADDSUB, LOAD: std_logic;
signal O1, O2 : std_logic_vector(7 downto 0);
signal ext : std_logic_vector(7 downto 0);
signal WB : std_logic_vector(7 downto 0);
signal f : std_logic;
signal sum : std_logic_vector(7 downto 0);
signal ALUO : std_logic_vector(7 downto 0);
signal p : std_logic_vector(7 downto 0);
signal LB: std_logic_vector(7 downto 0);
signal skipVal : std_logic_vector(3 downto 0); 
signal skipControl: std_logic;
signal outskip: std_logic<= '0';
signal inSkip: std_logic_vector(3 downto 0);
signal postskip: std_logic_vector(3 downto 0);
signal REnable : std_logic;

begin

con: controller port map(i=>I, aluSkip=>ALUSKIP, print=>PRINT, dispBEQ=>DISPBEQ, regwrite=>REGWRITE, addsub=>ADDSUB, load=>LOAD);
ID: inDecode port map(I=> I, ConSig => dispBEQ, r1=>R1, r2=>R2, rd=> RD, imm => IMM);
SE: sign_extend port map(i=>IMM, o=>ext);
reg: regFile port map(r1=> R1, r2=> R2, rd=>RD, wb=>WB, clk=>___, enable=>REGWRITE, o1=>O1, o2=>O2);
ALU: add_sub port map(A=>O1, B=>O2, mode=>ADDSUB, flow=>f, S=>sum);

ALUO<= sum when ALUSKIP='0' else
	O1 when ALUSKIP='1';

p<= ALUO when PRINT='1';
LB<= ALUO when PRINT='0';
	
P: print port map(I=>p);

WB<= ext when LOAD='0' else
	LB when LOAD='1';

skipControl <= nor LB(0) nor LB(1) nor LB(2) nor LB(3) nor LB(4) nor LB(5) nor LB(6) nor LB(7);
	
skipVal<= IMM when skipControl = '1' else
	"0000" when skipControl = '0';

inSkip<= IMM when outskip = '0' else
	postskip when outskip = '1';
	


SR : shift_reg port map(I => inSkip, I_SHIFT_IN=> '0', sel => "10", clock=>clk, enable => '1', O=>postskip);

outskip<=postskip(0) or postskip(1) or postskip(2) or postskip(3);

REnable<= clk when outskip='0' else
	'0' when outskip='1';

end behav;