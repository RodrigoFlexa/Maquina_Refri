library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bc is
	port(
            clk      : in std_logic;
            rst      : in std_logic;
            
			     	b1,b2, m : in std_logic;
			   
			    	 tot_maior_p, tot_igual_p, tot_menor_p : in std_logic;
				
				    d,nt : out std_logic;
            tot_ld   : out std_logic;
            tot_clr  : out std_logic;	
		        b_load   : out std_logic;
            b_clear  : out std_logic;
			     	troco_ld: out std_logic;
            troco_clr: out std_logic
	);
end bc;

architecture comportamento of bc is
	type tipo_estado is (inicio, esperar_botao, esperar_moeda,add, disp,calcula_troco,libera_troco);
	signal prox_estado, estado : tipo_estado := inicio;
	
begin
	-- Circuito combinacional -> não depende de clock
	logica_proximo_estado : process(estado,b1 , b2 ,m, tot_maior_p , tot_igual_p, tot_menor_p)
	begin
		case estado is
	
			when inicio =>
					prox_estado <= esperar_botao;

			when esperar_botao => 
				if b1 = '1' or b2 = '1' then
					prox_estado <= esperar_moeda;
				else
					prox_estado <= esperar_botao;
				end if;
				
			when esperar_moeda =>
				if m = '1' then
					prox_estado <= add;
					
				elsif ((tot_maior_p = '1') or (tot_igual_p = '1')) then
					prox_estado <= disp;
				else 
					prox_estado <= esperar_moeda;
				end if;
				
			when  add =>
				prox_estado <= esperar_moeda;
				
			when  disp =>
				if (tot_maior_p = '1') then 
					prox_estado <= calcula_troco;
				else
					prox_estado <= inicio;
				end if;
			
			when  calcula_troco =>			
				prox_estado <= libera_troco;
				
			when  libera_troco =>			
				prox_estado <= inicio;
				
		end case;
	end process;
	
	registrador_estado : process(clk, rst)
	begin
		if rst = '1' then
			estado <= inicio;
		elsif rising_edge(clk) then
			estado <= prox_estado;
		end if;
	end process;
	
	
	-- Circuito combinacional -> não depende de clock
	logica_saida : process(estado)
	begin
		case estado is
			 when inicio =>
				  tot_ld  <= '0'  ;   
				  tot_clr <= '1'  ;
				  b_load  <= '0'  ;  
				  b_clear <= '1'  ; 
				  troco_ld <= '0';
				  troco_clr <= '1'  ;
				  d <= '0';
				  nt<='0';

				
			 when esperar_botao => 
				  tot_ld  <= '0'  ;   
				  tot_clr <= '0'  ;
				  b_load  <= '1'  ;  
				  b_clear <= '0'  ; 
				  troco_ld <= '0';
				  troco_clr<= '0';
				  d <= '0';
				  nt<='0';				  
				
			 when  esperar_moeda =>
				  tot_ld  <= '0'  ;   
				  tot_clr <= '0'  ;
				  b_load  <= '0'  ;  
				  b_clear <= '0'  ; 
				  troco_ld <= '0';
				  troco_clr<= '0';
				  d <= '0';
				  nt<='0';	

			 when  add =>
				  tot_ld  <= '1'  ;   
				  tot_clr <= '0'  ;
				  b_load  <= '0'  ;  
				  b_clear <= '0'  ; 
				  troco_ld <= '0';
				  troco_clr<= '0';
				  d <= '0';
				  nt<='0';				
			
			when disp =>
				  tot_ld  <= '0'  ;   
				  tot_clr <= '0'  ;
				  b_load  <= '0'  ;  
				  b_clear <= '0'  ; 
				  troco_ld <= '0';
				  troco_clr<= '0';
				  d <= '1';
				  nt<='0';		
				  
			when calcula_troco =>
				  tot_ld  <= '0'  ;   
				  tot_clr <= '0'  ;
				  b_load  <= '0'  ;  
				  b_clear <= '0'  ;
				  troco_ld <= '1';
				  troco_clr<= '0'; 
				  d <= '0';
				  nt<= '1';		
				  
			when libera_troco =>
				  tot_ld  <= '0'  ;   
				  tot_clr <= '0'  ;
				  b_load  <= '0'  ;  
				  b_clear <= '0'  ;
				  troco_ld <= '0';
				  troco_clr<= '0'; 
				  d <= '0';
				  nt<= '0';
				  
		end case;
	end process;
end architecture;