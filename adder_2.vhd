-- n-bit Carry Select Adder

library ieee;
use ieee.std_logic_1164.all;
use work.my_components.all;

entity adder_2_ports is
	generic( n : integer := 4);
	port( en : in std_logic;
		  a, b: in std_logic_vector(n-1 downto 0);
		  cin : in std_logic;
		  s   : out std_logic_vector(n-1 downto 0);
		  cout: out std_logic );

end adder_2_ports;

architecture adder_2 of adder_2_ports is 
	signal s0, s1: std_logic_vector(n-1 downto 0);
	signal c0, c1: std_logic;
	signal sn : std_logic_vector(n-1 downto 0);
	signal cn0, cn1, cnout:std_logic_vector(0 downto 0);
	
begin
	U1: adder_1_ports generic map(n) port map(en, a, b, '0', s0, c0);
	U2: adder_1_ports generic map(n) port map(en, a, b, '1', s1, c1);

	cn0(0) <= c0;
	cn1(0) <= c1;

	U3: mux_2to1_ports generic map(n) port map(s0, s1, cin, sn);
	U4: mux_2to1_ports generic map(1) port map(cn0, cn1, cin, cnout);

	cout <= cnout(0);
			  
	s <= sn ;

end adder_2;