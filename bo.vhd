library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;


entity bo is

    port (
			clk     : in std_logic;
			r1,r2   : in std_logic_vector(7 downto 0);
			v       : in std_logic_vector(7 downto 0);
			
			b1,b2 : in std_logic;
			
			B_selected : out std_logic_vector(1 downto 0);
			P_selected : out std_logic_vector(7 downto 0);
			total_acumulado: out std_logic_vector(7 downto 0);
			vt: out std_logic_vector(7 downto 0);
			
			d : in std_logic;
			
			f1,f2 : out std_logic;
			tot_maior_p, tot_igual_p, tot_menor_p : out std_logic;
			
			tot_ld  :  in std_logic;
			tot_clr :  in std_logic;
			
			b_load   : in std_logic;
			b_clear  : in std_logic;
			
			troco_ld: in std_logic;
         troco_clr: in std_logic
			);
end bo;

    architecture union of bo is
       
        component comp8bit is
				port(  
					a,b   : in std_logic_vector(7 downto 0);
					eq,gtr,les: out std_logic
          );  
		  end component;
	  
		   component Mux is
				  port (
				  r1      : in  STD_LOGIC_VECTOR (7 downto 0); --PRECO DO REFRI 1
				  r2      : in  STD_LOGIC_VECTOR (7 downto 0); -- PRECO DO REFRI 2
				  r1_r2   : in  STD_LOGIC_VECTOR (7 downto 0); -- PRECO DO REFRI 1 + REFRI 2
				  sel     : in  STD_LOGIC_VECTOR (1 downto 0);
				  out_mux : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
			end component;
			
		  component demultiplexador is
				Port ( 
				  entrada : in  std_logic_vector(1 downto 0);  --registrador do botao
				  seletor : in  std_logic; --d=0 ou d =1
				  f1, f2  : out  std_logic
);
			end component;

      component registrador_8_bits is
			  port (
					clk		:	in	std_logic;							
					rst		:	in	std_logic;
					ld	    :	in	std_logic;	
					
					D	    :	in	   std_logic_vector(7 downto 0);	
					Q		:	out	std_logic_vector(7 downto 0) 	
        ) ;
      end component;
		
		component registrador_2_bits is
			  port (
					clk		:	in	std_logic;							
					rst		:	in	std_logic;
					ld	    :	in	std_logic;	
					D	    :	in	   std_logic_vector(1 downto 0);	
					Q		:	out	std_logic_vector(1 downto 0) 	
        ) ;
      end component;

      component concatenador is
			 port (
				  A           : in  std_logic;
				  B           : in  std_logic;
				  out_concat  : out  std_logic_vector(1 downto 0)
			 );
      end component;

      component Somador is
        port (
            A	   : in  std_logic_vector(7 downto 0);
            B	   : in  std_logic_vector(7 downto 0);
            Sum   : out  std_logic_vector(7 downto 0) 
        ) ;
      end component;

      component Subtrator is
        port (
					A	   : in  std_logic_vector(7 downto 0);
					B	   : in  std_logic_vector(7 downto 0);
					Sub   : out  std_logic_vector(7 downto 0)
        ) ;
      end component;

       signal  concat_out  : std_logic_vector(1 downto 0);
		 signal  b_out	  	  : std_logic_vector(1 downto 0);
		 signal  Mux_out     : std_logic_vector(7 downto 0);
       signal  r1_r2       : std_logic_vector(7 downto 0);
		
		 --sinal da saída do total em 8 bits
		 SIGNAL tot, troco : STD_LOGIC_VECTOR(7 DOWNTO 0);
		 --sinal da soma em 8 bits
		 SIGNAL soma_tot_v : STD_LOGIC_VECTOR(7 DOWNTO 0);
		 
		 SIGNAL sub_tot_v : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
       begin
		  concatenador_b1_b2 : concatenador port map (b1, b2, concat_out);
		  
		  registrador_botao  : registrador_2_bits port map (clk, b_clear , b_load, concat_out, b_out);
		
		  soma_acumulacao    : Somador port map (V,tot,soma_tot_v);
		  
        soma_r1_r2       : Somador port map (r1,r2,r1_r2);
                                                    
		  preco_refrigerante   : Mux port map (r1,r2, r1_r2, b_out, Mux_out);
		  
		  demux   : demultiplexador port map (b_out ,d, f1, f2);
		  
		  registrador_tot    : registrador_8_bits port map (clk, tot_clr, tot_ld, soma_tot_v, tot);
	
		  comp_8             : comp8bit port map (tot,Mux_out,tot_igual_p, tot_maior_p, tot_menor_p);
		  
		  subtrator_troco      : Subtrator port map (tot,  Mux_out, sub_tot_v);	
		  
		  registrador_troco   : registrador_8_bits port map (clk, troco_clr, troco_ld, sub_tot_v, troco);
		  
		  B_selected <= b_out;
		  P_selected <= Mux_out;
		  total_acumulado <= tot;
		  vt <= troco;
    end union; 