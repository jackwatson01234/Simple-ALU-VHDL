library ieee;
use ieee.std_logic_1164.all;
use work.my_components.all;

entity computing_ports is
	generic( n : integer := 4);
	port(en_unit : in std_logic_vector(4 downto 0);
		  arr0 : in std_logic_vector(2*n-1 downto 0); 
		  arr1 : in std_logic_vector(2*n-1 downto 0);
		  arr2 : in std_logic_vector(2*n-1 downto 0);
		  arr3 : in std_logic_vector(2*n-1 downto 0); 
		  arr4 : in std_logic_vector(2*n-1 downto 0); 

		  out0 : out std_logic_vector(n-1 downto 0);
		  out1 : out std_logic_vector(n-1 downto 0);
		  out2 : out std_logic_vector(n-1 downto 0);
		  out3 : out std_logic_vector(2*n-1 downto 0);
		  out4 : out std_logic_vector(2*n-1 downto 0) );
end entity;

architecture computing of computing_ports is
	signal w0, w1, w2 : std_logic;
begin
	
	U0:adder_1_ports generic map(n) port map( en_unit(4),arr0(2*n-1 downto n) ,arr0(n-1 downto 0) ,'0' ,out0 ,w0 );
	U1:adder_2_ports generic map(n) port map( en_unit(3),arr1(2*n-1 downto n) ,arr1(n-1 downto 0) ,'0' ,out1 ,w1 );
	U2:adder_3_ports generic map(n) port map( en_unit(2),arr2(2*n-1 downto n) ,arr2(n-1 downto 0) ,'0' ,out2 ,w2 );

	U3:mult_1_ports generic map(n) port map( en_unit(1),arr3(2*n-1 downto n) ,arr3(n-1 downto 0) ,out3 );
	U4:mult_2_ports generic map(n) port map( en_unit(0),arr4(2*n-1 downto n) ,arr4(n-1 downto 0) ,out4 );

end computing;






--	type array1 is array(4 downto 0) of std_logic_vector(2*n-1 downto 0);
--	signal arr : array1;

--G1:for i in 0 to 4 generate
--		arr(i) <= numbers(2*n-1+2*n*i downto 2*n*i);
--	end generate;