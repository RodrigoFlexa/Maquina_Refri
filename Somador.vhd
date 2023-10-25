library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Somador is
	port 
	(
		A	   : in  std_logic_vector(7 downto 0);
		B	   : in  std_logic_vector(7 downto 0);
		Sum   : out  std_logic_vector(7 downto 0)
	);

end entity;

architecture rtl of Somador is
    
begin
    Sum <= std_logic_vector(unsigned(A) + unsigned(B));
end rtl;