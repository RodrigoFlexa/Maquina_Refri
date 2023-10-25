library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity maquina_de_refrigerante is
    port (
        -- clock
        clk: in std_logic;
        
        -- reset
        rst: in std_logic;
        
        -- sinal de entrada de moeda, de aperto de b1 e de aperto do b2
        m, b1, b2: in std_logic;
        
        -- preço do refrigerante
        r1, r2: in std_logic_vector(7 downto 0);
        
        -- valor da moeda
        v: in std_logic_vector(7 downto 0);
        
		  
		  B_selected :  out std_logic_vector(1 downto 0);
		  P_selected : out std_logic_vector(7 downto 0);
        
		  -- saídas
        f1,f2: out std_logic
	 );
end entity maquina_de_refrigerante;

architecture soda_machine of maquina_de_refrigerante is
    
    component bc is
        port (
            clk: in std_logic;
            rst: in std_logic;
            
            b1, b2, m: in std_logic;
            
            tot_maior_p, tot_igual_p, tot_menor_p: in std_logic;
				
				d     : out std_logic;
            tot_ld: out std_logic;
            tot_clr: out std_logic;
            b_load: out std_logic;
            b_clear: out std_logic
        );
    end component bc;

    component bo is
        port (
            clk: in std_logic;
            r1, r2: in std_logic_vector(7 downto 0);
            v: in std_logic_vector(7 downto 0);
            b1, b2: in std_logic;
				B_selected : out std_logic_vector(1 downto 0);
				P_selected : out std_logic_vector(7 downto 0);
            
				d     : in std_logic;
				f1,f2 : out std_logic;
            
				tot_maior_p, tot_igual_p, tot_menor_p: out std_logic;
            
            tot_ld: in std_logic;
            tot_clr: in std_logic;
            b_load: in std_logic;
            b_clear: in std_logic
        );
    end component bo;

    signal tot_ld: std_logic;
    signal tot_clr: std_logic;
    signal b_load: std_logic;
    signal b_clear: std_logic;
    signal tot_maior_p: std_logic;
    signal tot_igual_p: std_logic;
    signal tot_menor_p: std_logic;
	 signal d :std_logic;

begin
    machine_control: bc port map(
        clk => clk,
        rst => rst,
        b1 => b1,
        b2 => b2,
        m => m,
        tot_maior_p => tot_maior_p,
        tot_igual_p => tot_igual_p,
        tot_menor_p => tot_menor_p,
		  d => d,
        tot_ld => tot_ld,
        tot_clr => tot_clr,
        b_load => b_load,
        b_clear => b_clear
    );
	 
    machine_datapath: bo port map(
        clk => clk,
        r1 => r1,
        r2 => r2,
        v => v,
        b1 => b1,
        b2 => b2,

		  B_selected => B_selected,
		  P_selected => P_selected,
		  
		  d => d,
		  f1 => f1,
		  f2 => f2,
		  
        tot_maior_p => tot_maior_p,
        tot_igual_p => tot_igual_p,
        tot_menor_p => tot_menor_p,
        tot_ld => tot_ld,
        tot_clr => tot_clr,
        b_load => b_load,
        b_clear => b_clear
    );
    
end architecture soda_machine;
