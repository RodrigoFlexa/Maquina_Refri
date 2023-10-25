library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity concatenador is
    port 
    (
        A           : in  std_logic;
        B           : in  std_logic;
        out_concat  : out  std_logic_vector(1 downto 0)
    );
end entity concatenador;

architecture rtl of concatenador is
begin
    out_concat <= A & B; -- Concatenação de A e B para out_concat
end rtl;
