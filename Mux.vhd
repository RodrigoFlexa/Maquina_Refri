library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux is
    Port ( 
        r1      : in  STD_LOGIC_VECTOR (7 downto 0); --PRECO DO REFRI 1
        r2      : in  STD_LOGIC_VECTOR (7 downto 0); -- PRECO DO REFRI 2
        r1_r2   : in  STD_LOGIC_VECTOR (7 downto 0); -- PRECO DO REFRI 1 + REFRI 2
		  
		  sel     : in  STD_LOGIC_VECTOR (1 downto 0);
        out_mux : out  STD_LOGIC_VECTOR (7 downto 0)
    );
end Mux;

architecture Behavioral of Mux is
begin
    with sel select
        out_mux <= r1 when "10",
                   r2 when "01",
                   r1_r2 when "11",
                   (others => '0') when others; 
end Behavioral;
