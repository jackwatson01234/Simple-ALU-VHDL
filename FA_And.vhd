library ieee;
use ieee.std_logic_1164.all;
use work.my_components.all;

entity FA_And is
    generic(n:positive :=4);
    port(en : in std_logic;
			b:in std_logic;
         cin:in std_logic_vector(n-2 downto 0);
         pre_s:in std_logic_vector(n-2 downto 0);
         a:in std_logic_vector(n-1 downto 0);
         s:out std_logic_vector(n-1 downto 0);
         cout:out std_logic_vector(n-2 downto 0));
end entity;
     
architecture FA_And of FA_And is

    signal mult:std_logic_vector(n-1 downto 0);
    signal sn:std_logic_vector(n-2 downto 0);
    begin
        
         L1:and_par_mult generic map(n) port map(en,a,b,mult);
 
           

                G1:for i in 0 to n-2 generate
                  L2:Full_Adder port map(en,mult(i),pre_s(i),cin(i),sn(i),cout(i));
                end generate;
                s<=mult(n-1) & sn;
end architecture;