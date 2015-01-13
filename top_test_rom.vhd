--
--    This file is part of top_test_rom
--    Copyright (C) 2011  Julien Thevenon ( julien_thevenon at yahoo.fr )
--
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_test_rom is
    Port ( clk : in  STD_LOGIC;
           w1a : inout  STD_LOGIC_VECTOR (15 downto 0);
           w1b : inout  STD_LOGIC_VECTOR (15 downto 0);
           w2c : inout  STD_LOGIC_VECTOR (15 downto 0);
           rx : in  STD_LOGIC;
           tx : inout  STD_LOGIC);
end top_test_rom;

architecture Behavioral of top_test_rom is
	component rom
		port (
			clka: IN std_logic;
			addra: IN std_logic_VECTOR(4 downto 0);
			douta: OUT std_logic_VECTOR(3 downto 0));
		end component;
		signal reset : std_logic;
		signal address : std_logic_vector(4 downto 0) := (others => '0');
		signal data_out : std_logic_vector(3 downto 0);
begin

my_rom : rom
		port map (
			clka => clk,
			addra => address,
			douta => data_out);
			
		process(clk)
		begin
			if reset = '1' then
				address <= (others => '0');
			elsif rising_edge(clk) then
				address <= std_logic_vector((unsigned(address)) + 1);
			end if;
		end process;

	w1a(0) <= address(0);
	w1a(1) <= address(1);
	w1a(2) <= address(2);
	w1a(3) <= address(3);
	w1a(4) <= address(4);

	w1b(0) <= data_out(0);
	w1b(1) <= data_out(1);
	w1b(2) <= data_out(2);
	w1b(3) <= data_out(3);

	reset <= '0';
end Behavioral;

