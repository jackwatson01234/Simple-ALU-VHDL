library ieee;
use ieee.std_logic_1164.all;

entity mux_2to1_ports is
	generic( n : integer := 4);
	port(a0, a1: in std_logic_vector(n-1 downto 0);
		  sel: in std_logic;
		  y : out std_logic_vector(n-1 downto 0) );
end mux_2to1_ports;

architecture mux_2to1 of mux_2to1_ports is
begin
	y <= a0 when sel='0' else
		  a1 when sel='1';
end mux_2to1;
