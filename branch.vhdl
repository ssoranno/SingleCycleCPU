-- Steven Soranno and Evan Deangelis
-- regFile

library ieee;
use ieee.std_logic_1164.all;

entity branch is
	port(
		I : in std_logic_vector(3 downto 0);
		clk : in  std_logic;
		O : out std_logic
	);
end branch;

architecture behav of branch is

component shift_reg is
port(	I:	in std_logic_vector (3 downto 0); -- Input vector
		I_SHIFT_IN: in std_logic; -- Value to shift in
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0)
);
end component;


signal temp1 : std_logic_vector(3 downto 0);
signal temp2 : std_logic_vector(3 downto 0);
signal temp3 : std_logic := '0';
signal temp4 : std_logic_vector(1 downto 0);

begin

temp1<= I when temp3 = '0' else
	temp2 when temp3 = '1';

temp4<= "00" when temp3 = '0' else
	"10" when temp3 = '1';

SR : shift_reg port map(I => temp1, I_SHIFT_IN=> '0', sel => "10", clock=>clk, enable => '1', O=>temp2);

O<=temp2(0) or temp2(1) or temp2(2) or temp2(3);
--temp3<= temp2(0) or temp2(1) or temp2(2) or temp2(3);

--O<=temp2(0) or temp2(1) or temp2(2) or temp2(3);

--O<= temp3;
--O<= temp3;

end behav;