-- n-bit Carry Ripple Adder 
library ieee;
use ieee.std_logic_1164.all;

entity adder_1_ports is 
	generic( n : integer := 4);
	port( en : in std_logic;
		  a, b: in std_logic_vector(n-1 downto 0);
		  cin : in std_logic;
		  s   : out std_logic_vector(n-1 downto 0);
		  cout: out std_logic 
);
end adder_1_ports;

architecture adder_1 of adder_1_ports is 
begin
	process(a, b, cin, en)
		variable carry : std_logic_vector(n downto 0);
		variable sn : std_logic_vector(n-1 downto 0);
	begin
		if(en = '1') then
			carry(0) := cin;
			for i in 0 to n-1 loop
				sn(i) := a(i) xor b(i) xor carry(i);
				carry(i+1) := (a(i) and b(i)) or (a(i) and carry(i)) 
									or (b(i) and carry(i) );
			end loop;
			cout <= carry(n);
			s <= sn;
		elsif(en = '0') then
			s <= (others => '0');
			cout <= '0';
		end if;
	end process;
end adder_1;


		