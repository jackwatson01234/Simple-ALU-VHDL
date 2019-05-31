library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity mult_1_ports is
	generic( n : integer := 4);
	port( en : in std_logic;
		  a, b: in std_logic_vector(n-1 downto 0);
		  m   : out std_logic_vector(2*n-1 downto 0) );
end mult_1_ports;

architecture mult_1 of mult_1_ports is 
begin
	process(a, b, en)
		constant max : integer := a'length + b'length - 1;
		variable prod : unsigned(max downto 0) := (others => '0');
		variable aa : unsigned(max downto 0) := (others => '0');
		variable an : unsigned(n-1 downto 0) :=  (others => '0');
		variable mn : std_logic_vector(2*n-1 downto 0);
	begin
		if(en = '1') then 
			prod := (others => '0');
			aa :=  (others => '0');
			an := unsigned(a);
			aa := aa + an;
			for i in 0 to a'length-1 loop
				if(b(i) = '1') then
					prod := prod + aa;
				end if;
				aa := aa(max-1 downto 0) & '0';
			end loop;
			mn := std_logic_vector(prod);
		elsif(en = '0') then
			mn := (others => '0');
		end if;
		m <= mn;
	end process;
	

end mult_1;


