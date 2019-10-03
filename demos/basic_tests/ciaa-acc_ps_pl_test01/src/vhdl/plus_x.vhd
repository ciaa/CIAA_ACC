-- CIAA ACC + X block to show how things are connected at top level
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity plus_x is
	generic (
		-- User data for testing 
		USER_X	: unsigned(31 downto 0) := X"00000001"
	);
	port (
		-- 32-bit Input and Output numbers
		user_number_i : in  std_logic_vector(31 downto 0);
		user_plus_x_o : out std_logic_vector(31 downto 0)
	);
end plus_x;

architecture rtl of plus_x is

begin
    -- Use std_logic_vector at interfaces but numeric_std unsigned for internal 
    -- operations. This involves some casting :-(
    user_plus_x_o <= std_logic_vector(unsigned(user_number_i) + USER_X);
    
end rtl;
