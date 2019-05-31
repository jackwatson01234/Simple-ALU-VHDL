library ieee;
use ieee.std_logic_1164.all;

entity selector_ports is
	generic( n : integer := 4);
	port(
		  en_selector : std_logic_vector(1 downto 0);
		  num1 , num2 : in integer range 1 to 5;

		  computing_out0 : in std_logic_vector(n-1 downto 0);
		  computing_out1 : in std_logic_vector(n-1 downto 0);
		  computing_out2 : in std_logic_vector(n-1 downto 0);
		  computing_out3 : in std_logic_vector(2*n-1 downto 0);
		  computing_out4 : in std_logic_vector(2*n-1 downto 0); 

		  ft2_out1 , ft2_out2 , ft3_out1 , ft3_out2 : in boolean;
		  output_1 , output_2 : out std_logic_vector(2*n-1 downto 0);
		  ft21 , ft22 , ft31 , ft32 : out boolean	
);
end selector_ports;

architecture selector of selector_ports is
begin
	process(en_selector, computing_out1, computing_out2, computing_out3, computing_out4 , num1 , num2 ,
				ft2_out1 , ft2_out2 , ft3_out1 , ft3_out2)
		type array1 is array(1 to 5) of std_logic_vector(2*n-1 downto 0);
		variable a : array1;

		--variable out1_var , out2_var : std_logic_vector(2*n-1 downto 0);

		variable zero : std_logic_vector(n-1 downto 0) := (others => '0');
		variable output_1_var , output_2_var : std_logic_vector(2*n-1 downto 0);
		variable ft21_var , ft22_var , ft31_var , ft32_var : boolean;

	begin
		a(1) := zero & computing_out0;
		a(2) := zero & computing_out1;
		a(3) := zero & computing_out2;
		a(4) := computing_out3;
		a(5) := computing_out4;

		if(en_selector(1) = '1') then
			if(en_selector(0) = '1') then
				output_1_var := a(num1);
				output_2_var := a(num2);

				ft21_var := ft2_out1; 
	 			ft22_var := ft2_out2;
				ft31_var := ft3_out1;
				ft32_var := ft3_out2;
			elsif(en_selector(0) = '0') then	
				output_1_var := a(num1);
				output_2_var := (others => '0');

				ft21_var := ft2_out1; 
	 			ft22_var := ft2_out2;
				ft31_var := false;
				ft32_var := false;
			end if;
		elsif(en_selector(1) = '0') then 
			output_1_var := (others => '0');
			output_2_var := (others => '0');	
		
			ft21_var := false; 
	 		ft22_var := false;
			ft31_var := false;
			ft32_var := false;
		end if;

		output_1 <= output_1_var;
		output_2 <= output_2_var;

		ft21 <= ft21_var;
		ft22 <= ft22_var;
		ft31 <= ft31_var;
		ft32 <= ft32_var;
	end process;



end selector;
