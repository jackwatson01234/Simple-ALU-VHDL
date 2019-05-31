library ieee;
use ieee.std_logic_1164.all;
use work.my_components.all;

entity alu_ports is
	generic(n : integer := 26);
	port(
		inst : in std_logic_vector(n-1 downto 0);
		
		output_1 , output_2 : out std_logic_vector((n-10)/2-1 downto 0);
		ft21 , ft22 , ft31 , ft32 : out boolean
);

end alu_ports;


architecture alu of alu_ports is
	signal en_computing : std_logic_vector(4 downto 0);
	signal arr1 , arr2 , arr3 , arr4 , arr5 : std_logic_vector( (n-10)/2-1 downto 0);

	signal ft2 , ft3 : std_logic;
	signal en_fault1, en_fault2 : std_logic_vector(4 downto 0);
	signal num1_out , num2_out : integer range 1 to 5;
	signal data_fault1, data_fault2 : std_logic_vector( (n-10)/2-1 downto 0);

	signal out1 , out2 , out3 : std_logic_vector( (n-10)/4-1 downto 0);
	signal out4 , out5 : std_logic_vector( (n-10)/2-1 downto 0);

	signal ft2_out1 , ft2_out2 , ft3_out1 , ft3_out2 : boolean;
begin

	U1:controller_ports generic map(n) port map(
---inputs		
		inst ,
---outputs
		en_computing ,
		arr1 , arr2 , arr3 , arr4 , arr5 ,
		
		ft2 , ft3 ,
		en_fault1 , en_fault2 ,
		num1_out , num2_out ,
		data_fault1 , data_fault2 
);


	U2:computing_ports generic map( (n-10)/4 ) port map(
---inputs
	en_computing , 
	arr1 , arr2 , arr3 , arr4 , arr5 ,
---outputs
	out1 , out2 , out3 , out4 , out5 
);


	U3:fault_ports generic map( (n-10)/4 ) port map(
---inputs
		ft2 , ft3 ,
		en_fault1 , en_fault2 ,
		num1_out , num2_out ,
		data_fault1 , data_fault2 ,
		
		out1 , out2 , out3 , out4 , out5 ,
---outputs
		ft2_out1 , ft2_out2 , ft3_out1 , ft3_out2	
);


	U4:selector_ports generic map( (n-10)/4 ) port map(
---inputs
		inst(n-1 downto n-2) ,
		num1_out , num2_out ,
		out1 , out2 , out3 , out4 , out5 , 
		ft2_out1 , ft2_out2 , ft3_out1 , ft3_out2	,
---output
		output_1 , output_2 ,
		ft21 , ft22 , ft31 , ft32
);


end alu;
