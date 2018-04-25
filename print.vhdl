-- Steven Soranno and Evan Deangelis
-- printFunction

library ieee;
use ieee.std_logic_1164.all;
--use IEEE.std_logic_signed.all;
--use IEEE.std_logic_textio.all;

entity print is
	port(
		I : in std_logic_vector(7 downto 0);
		EN : in std_logic;
		clk : in std_logic
	);
end print;

architecture behav of print is
begin

process(clk)

variable f: std_logic_vector(7 downto 0);
--variable p1: string(1 to 8);
variable output: string(1 to 8);
begin
	if falling_edge(clk) then
	if EN = '1' then
		f(0):= I(7);
		f(1):= I(6);
		f(2):= I(5);
		f(3):= I(4);
		f(4):= I(3);
		f(5):= I(2);
		f(6):= I(1);
		f(7):= I(0);
		for i in f'range loop
		case f(i) is
		when '0' => output(i+1):= character'('0');
		when '1' => output(i+1):= character'('1');
		when others =>report "hello";--output(i+1):= character'('0');
		end case;
		end loop;
		report output;
	end if;
	end if;
end process;

end behav;