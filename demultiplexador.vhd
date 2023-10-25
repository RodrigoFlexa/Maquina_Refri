library ieee;
use ieee.std_logic_1164.all;

entity demultiplexador is
    Port (
        entrada : in  std_logic_vector(1 downto 0);  --registrador do botao
        seletor : in  std_logic; --d=0 ou d =1
        f1, f2 : out  std_logic
    );
end demultiplexador;

architecture Behavioral of demultiplexador is
begin
    process(entrada, seletor)
    begin
        if seletor = '1' then
            case entrada is
                when "00" =>
                    f1 <= '0';
                    f2 <= '0';
                when "01" =>
                    f1 <= '0';
                    f2 <= '1';
					 when "10" =>
                    f1 <= '1';
                    f2 <= '0';
					 when "11" =>
                    f1 <= '1';
                    f2 <= '1';
                when others =>
                    -- ação padrão, se necessário
                    f1 <= '0';
                    f2 <= '0';
            end case;
        elsif seletor = '0' then
				  f1 <= '0';
				  f2 <= '0';
        end if;
    end process;
end Behavioral;
