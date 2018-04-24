-- Steven Soranno and Evan Deangelis
-- printFunction

library ieee;
use ieee.std_logic_1164.all;
--use IEEE.std_logic_signed.all;
--use IEEE.std_logic_textio.all;

entity print is
	port(
		I : in std_logic_vector(7 downto 0)
	);
end print;

architecture behav of print is
begin

process(I)

variable f: std_logic_vector(7 downto 0);
variable output: string(1 to 8);
begin
	f:= I;
	for i in f'range loop
	case f(i) is
	when '0' => output(i+1):= character'('0');
	when '1' => output(i+1):= character'('1');
	when others =>
	end case;
	end loop;
	report output;
end process;

end behav;