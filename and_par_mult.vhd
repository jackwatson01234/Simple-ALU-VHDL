library ieee;
USE ieee.std_logic_1164.all;

entity and_par_mult is
    generic(n:positive :=4);
port(en : in std_logic;
	  a:in std_logic_vector(n-1 downto 0);
     b:in std_logic;
     s:out std_logic_vector(n-1 downto 0));
 end entity;
 
 architecture and_par_mult of and_par_mult is
     begin
         process(en,a,b)
             begin
						if(en = '1') then
                 		for i in 0 to n-1 loop
                 			   s(i) <= a(i) and b;
                		end loop;
						elsif(en = '0') then
									s <= (others => '0');
						end if;
             end process;
end architecture;