-- Arquivo registrador_8.vhd
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registrador_8 IS
    PORT (
        clk : IN  STD_LOGIC;
        rst : IN  STD_LOGIC;
        clr : IN  STD_LOGIC;
        ld  : IN  STD_LOGIC;
        q   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); 
        d   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
    );
END ENTITY registrador_8;

ARCHITECTURE behavior OF registrador_8 IS
    SIGNAL internal_reg : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); -- registrador interno
	 
BEGIN
    PROCESS (clk, rst)
    BEGIN
        -- SE O RESET FOR 1, ELE VAI ZERAR O REGISTRADOR INTERNO
        IF rst = '1' THEN
            internal_reg <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            -- SE CLR FOR 1, ELE VAI ZERAR O REGISTRADOR INTERNO
            IF clr = '1' THEN
                internal_reg <= (OTHERS => '0');
            -- SE LD FOR 1, ELE VAI CARREGAR O VALOR DE Q NO REGISTRADOR INTERNO
            ELSIF ld = '1' THEN
                internal_reg <= q;
            END IF;
        END IF;
    END PROCESS;

    -- ATRIBUIR O VALOR DO REGISTRADOR INTERNO À SAÍDA D
    d <= internal_reg;

END ARCHITECTURE behavior;
