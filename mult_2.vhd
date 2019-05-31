library ieee;
use ieee.std_logic_1164.all;
use work.my_components.all;

entity mult_2_ports is
    generic(n:positive :=4);
    port(en : std_logic;
			a,b:in std_logic_vector(n-1 downto 0);
         m:out std_logic_vector(2*n-1 downto 0));
end mult_2_ports;

architecture mult_2 of mult_2_ports is

    TYPE matrix IS ARRAY (0 TO n-1) OF STD_LOGIC_VECTOR (n-2 DOWNTO 0); 
    signal c:matrix;
    TYPE matrix2 IS ARRAY (0 TO n-1) OF STD_LOGIC_VECTOR (n-1 DOWNTO 0); 
    signal s:matrix2;
    
    begin
        
        c(0)<=(others=>'0');
        
        L1:and_par_mult generic map(n) port map(en,a,b(0),s(0));
        
        G1:for i in 0 to n-2 generate
              L2:FA_And generic map(n) port map(en,b(i+1),c(i),s(i)(n-1 downto 1),a,s(i+1),c(i+1));
          end generate;
        L3:adder_1_ports generic map(n-1) port map(en,s(n-1)(n-1 downto 1),c(n-1),'0',m(2*n-2 downto n),m(2*n-1));
        G2:for i in 0 to n-1 generate 
              m(i)<=s(i)(0);
          end generate;

		 
          
    end mult_2;
    