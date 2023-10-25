library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;
entity tb_maquina_de_refrigerante is
end entity tb_maquina_de_refrigerante;

architecture testbench of tb_maquina_de_refrigerante is
    -- Componentes do testbench
    component maquina_de_refrigerante is
        port (
            clk: in std_logic;
            rst: in std_logic;
            m, b1, b2: in std_logic;
            r1, r2: in std_logic_vector(7 downto 0);
            v: in std_logic_vector(7 downto 0);
            B_selected: out std_logic_vector(1 downto 0);
            P_selected: out std_logic_vector(7 downto 0);
				    total_acumulado: out std_logic_vector(7 downto 0);
            f1, f2, nt: out std_logic;
            vt: out std_logic_vector(7 downto 0)
        );
    end component;

    -- Sinais do testbench
    signal clk_tb: std_logic := '0';
    signal rst_tb: std_logic := '1';
    signal m_tb, b1_tb, b2_tb: std_logic := '0';
    signal r1_tb, r2_tb, v_tb: std_logic_vector(7 downto 0);
    signal B_selected_tb: std_logic_vector(1 downto 0);
    signal P_selected_tb: std_logic_vector(7 downto 0);
	 signal total_acumulado_tb: std_logic_vector(7 downto 0);
    signal f1_tb, f2_tb, nt_tb: std_logic;
    signal vt_tb: std_logic_vector(7 downto 0);

begin
    -- Instanciacao da entidade a ser testada
    DUT: maquina_de_refrigerante
        port map (
            clk => clk_tb,
            rst => rst_tb,
            m => m_tb,
            b1 => b1_tb,
            b2 => b2_tb,
            r1 => r1_tb,
            r2 => r2_tb,
            v => v_tb,
            B_selected => B_selected_tb,
            P_selected => P_selected_tb,
				total_acumulado => total_acumulado_tb,
            f1 => f1_tb,
            f2 => f2_tb,
            nt => nt_tb,
            vt => vt_tb
        );


stim_proc: process
begin
    -- Inicialização dos sinais de controle e entradas
    rst_tb <= '1'; -- Sinal de reset inicializado em '1'
    m_tb <= '0'; -- Sinal de moeda inicializado em '0'
    b1_tb <= '0'; -- Sinal do botão b1 inicializado em '0'
    b2_tb <= '0'; -- Sinal do botão b2 inicializado em '0'
    r1_tb <= std_logic_vector(to_unsigned(20, r1_tb'length)); -- Inicialização do registrador r1 com 20
    r2_tb <= std_logic_vector(to_unsigned(15, r2_tb'length)); -- Inicialização do registrador r2 com 15
    v_tb <= std_logic_vector(to_unsigned(0, v_tb'length)); -- Inicialização do valor inserido com 0

    wait until rising_edge(clk_tb); -- Espera pela borda de subida do clock
    rst_tb <= '0'; -- Reset é desativado após a borda de subida do clock

    wait until rising_edge(clk_tb);
    b1_tb <= '1'; -- Ativa o botão b1
    b2_tb <= '1'; -- Ativa o botão b2

    wait until rising_edge(clk_tb); -- b1 ligado dura um ciclo e desliga
    b1_tb <= '0'; -- Desativa o botão b1
    b2_tb <= '0'; -- Desativa o botão b2

    wait until rising_edge(clk_tb);
    m_tb <= '1'; -- Sinal de moeda é ativado

    wait until rising_edge(clk_tb);
    v_tb <= std_logic_vector(to_unsigned(25, v_tb'length)); -- Valor inserido é definido como 25
    m_tb <= '0'; -- Sinal de moeda é desativado

    wait until rising_edge(clk_tb);
    v_tb <= std_logic_vector(to_unsigned(0, v_tb'length)); -- Valor inserido é definido como 0

    wait until rising_edge(clk_tb);
    m_tb <= '1'; -- Sinal de moeda é ativado

    wait until rising_edge(clk_tb);

    v_tb <= std_logic_vector(to_unsigned(25, v_tb'length)); -- Valor inserido é definido como 25
    m_tb <= '0'; -- Sinal de moeda é desativado

    wait until rising_edge(clk_tb);
    v_tb <= std_logic_vector(to_unsigned(0, v_tb'length)); -- Valor inserido é definido como 0
    
    wait until rising_edge(clk_tb);
    wait until rising_edge(clk_tb);
    wait until rising_edge(clk_tb);
    wait until rising_edge(clk_tb);
    
    wait until rising_edge(clk_tb);
    b1_tb <= '1'; -- Ativa o botão b1

    wait until rising_edge(clk_tb); -- b1 ligado dura um ciclo e desliga
    b1_tb <= '0'; -- Desativa o botão b1

    wait until rising_edge(clk_tb);
    m_tb <= '1'; -- Sinal de moeda é ativado

    wait until rising_edge(clk_tb);
    v_tb <= std_logic_vector(to_unsigned(50, v_tb'length)); -- Valor inserido é definido como 25
    m_tb <= '0'; -- Sinal de moeda é desativado

    wait until rising_edge(clk_tb);
    v_tb <= std_logic_vector(to_unsigned(0, v_tb'length)); -- Valor inserido é definido como 0
    wait;
end process;


process(clk_tb)
    file F: TEXT open WRITE_MODE is "C:\Users\Demop\OneDrive\Documentos\Maquina_Refri\testbench\saidas\saida.txt";
    
    variable L: LINE;
begin
    if rising_edge(clk_tb) then
   
  WRITE (L, "Dinheiro Inserido: " & integer'image(to_integer(unsigned(v_tb))));
        WRITELINE (F, L);

        WRITE (L, "Registrador do Botao: " & std_logic'image(B_selected_tb(1)) & std_logic'image(B_selected_tb(0)));
        WRITELINE (F, L);
       
        WRITE (L, "Preco selecionado: " & integer'image(to_integer(unsigned(P_selected_tb))));
        WRITELINE (F, L);
        
		    WRITE (L, "Acumulado: " & integer'image(to_integer(unsigned(total_acumulado_tb))));
        WRITELINE (F, L);
		  
        WRITE (L, "R1: " & integer'image(to_integer(unsigned(r1_tb))));
        WRITELINE (F, L);
        WRITE (L, "R2: " & integer'image(to_integer(unsigned(r2_tb))));
        WRITELINE (F, L);
        
        WRITE (L, "F1: " & std_logic'image(f1_tb));
        WRITELINE (F, L);
         
        WRITE (L, "F2: " & std_logic'image(f2_tb));
        WRITELINE (F, L);

        WRITE (L, "NT: " & std_logic'image(nt_tb));
        WRITELINE (F, L);

        WRITE (L, "VT: " & integer'image(to_integer(unsigned(vt_tb))));
        WRITELINE (F, L);
       
        WRITE (L, ' ');
        WRITELINE (F, L);
            
    end if;
end process;

  stim_clock: process
begin
    while now < 1200 ns loop
        clk_tb <= '0';
        wait for 25 ns;
        clk_tb <= '1';
        wait for 25 ns;
    end loop;
    wait;
    
end process;

	 
end architecture testbench;
