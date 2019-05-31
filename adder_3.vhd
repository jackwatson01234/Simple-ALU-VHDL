-- n-bit Carry Save Adder
library ieee;
use ieee.std_logic_1164.all;
use work.my_components.all;

entity adder_3_ports is
	generic( n : integer := 4);
	port( en : in std_logic;
		  a, b: in std_logic_vector(n-1 downto 0);
		  cin : in std_logic;
		  s   : out std_logic_vector(n-1 downto 0);
		  cout: out std_logic );

end adder_3_ports;

architecture adder_3 of adder_3_ports is
	signal z : std_logic_vector(n-1 downto 0) := (others => '0');
	signal c : std_logic_vector(n-1 downto 0);
	signal sn : std_logic_vector(n-1 downto 0);
	signal w : std_logic_vector(n-1 downto 0);
	
	signal se : std_logic_vector(n downto 0);
	signal coute : std_logic;
begin
	z <= z(n-1 downto 1) & cin;

	--can use Rippel Adder in this part 
	G1:for i in 0 to n-1 generate
			sn(i) <= a(i) xor b(i) xor z(i);
			c(i) <= (a(i) and b(i)) or (a(i) and z(i)) or (b(i) and z(i));
		end generate;
	
	se(0) <= sn(0);
	w <= '0' & sn(n-1 downto 1);

	U1 : adder_1_ports generic map(n) port map('1', c, w, '0', se(n downto 1), coute);

	
	cout <= se(n) when en='1' else
			  '0' when en='0';
	s <= se(n-1 downto 0) when en='1' else
		  (others => '0') when en='0';

end adder_3;