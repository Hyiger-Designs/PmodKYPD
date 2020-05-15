
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

use work.utils.all;

entity keypad_top is
	Port(clk     : in     STD_LOGIC;
	     reset_n : in     STD_LOGIC;
	     rows    : IN     STD_LOGIC_VECTOR(1 TO 4); --row connections to keypad
	     columns : BUFFER STD_LOGIC_VECTOR(1 TO 4) := "1111"; --column connections to keypad
	     led     : out    STD_LOGIC_VECTOR(3 downto 0)
	    );
end keypad_top;

architecture Behavioral of keypad_top is
	signal keys : STD_LOGIC_VECTOR(0 TO 15);
begin
    
	PmodKYPD : entity work.pmod_keypad
		generic map(
			clk_freq => 100_000_000
		)
		port map(
			clk     => clk,
			reset_n => reset_n,
			rows    => rows,
			columns => columns,
			keys    => keys
		);

	process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset_n = '0') then
				led <= "0000";
			elsif (keys = x"0000") then
			    led <= "0000";
			else
			    led <= not to_slv(log2ceil(to_integer(unsigned(keys))), led'length);
--				case keys is
--					when "1000000000000000" => led <= x"0";
--					when "0100000000000000" => led <= x"1";
--					when "0010000000000000" => led <= x"2";
--					when "0001000000000000" => led <= x"3";
--					when "0000100000000000" => led <= x"4";
--					when "0000010000000000" => led <= x"5";
--					when "0000001000000000" => led <= x"6";
--					when "0000000100000000" => led <= x"7";
--					when "0000000010000000" => led <= x"8";
--					when "0000000001000000" => led <= x"9";
--					when "0000000000100000" => led <= x"A";
--					when "0000000000010000" => led <= x"B";
--					when "0000000000001000" => led <= x"C";
--					when "0000000000000100" => led <= x"D";
--					when "0000000000000010" => led <= x"E";																																																												
--					when "0000000000000001" => led <= x"F";
--					when others             => led <= x"0";
--				end case;
			end if;
		end if;
	end process;

end Behavioral;
