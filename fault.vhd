 library ieee;
use ieee.std_logic_1164.all;
use work.my_components.all;

entity fault_ports is
	generic(n : integer := 4);
	port( ft2 , ft3 : in std_logic;
			en_fault1, en_fault2     : in std_logic_vector(4 downto 0);
			num1, num2 : in integer range 1 to 5;
		   data_fault1, data_fault2 : in std_logic_vector( 2*n-1 downto 0);

			in0 : in std_logic_vector(n-1 downto 0);
		   in1 : in std_logic_vector(n-1 downto 0);
		   in2 : in std_logic_vector(n-1 downto 0);
		   in3 : in std_logic_vector(2*n-1 downto 0);
		   in4 : in std_logic_vector(2*n-1 downto 0);

			ft2_out1 , ft2_out2 , ft3_out1 , ft3_out2 : out boolean
);
end fault_ports;

architecture fault of fault_ports is
	signal out00 : std_logic_vector(n-1 downto 0);
	signal out01 : std_logic_vector(n-1 downto 0);
	signal out02 : std_logic_vector(n-1 downto 0);
	signal out03 : std_logic_vector(2*n-1 downto 0);
	signal out04 : std_logic_vector(2*n-1 downto 0); 

	signal out10 : std_logic_vector(n-1 downto 0);
	signal out11 : std_logic_vector(n-1 downto 0);
	signal out12 : std_logic_vector(n-1 downto 0);
	signal out13 : std_logic_vector(2*n-1 downto 0);
	signal out14 : std_logic_vector(2*n-1 downto 0);
begin
	


	U1: computing_ports generic map(n) port map(en_fault1,data_fault1,data_fault1,data_fault1,data_fault1,data_fault1,
																			out00,out01,out02,out03,out04);
	U2: computing_ports generic map(n) port map(en_fault2,data_fault2,data_fault2,data_fault2,data_fault2,data_fault2,
																			out10,out11,out12,out13,out14);


	process(ft2 , ft3 , en_fault1, en_fault2 , num1, num2 , data_fault1, data_fault2 , in0 , in1 , in2 , in3,
			  out00,out01,out02,out03,out04,out10,out11,out12,out13,out14)
		variable ft2_out_var1 , ft2_out_var2 , ft3_out_var1 , ft3_out_var2 : boolean := false;
	begin 
		ft2_out_var1 := false;
		ft2_out_var2 := false;
		ft3_out_var1 := false;
		ft3_out_var2 := false;
		if(ft2 = '1') then
			case num1 is
				when 1 =>
					if(in0 = out01 or in0 = out02) then
						ft2_out_var1 := true;
					else
						ft2_out_var1 := false;
					end if;
				when 2 =>
					if(in1 = out00 or in1 = out02) then
						ft2_out_var1 := true;
					else
						ft2_out_var1 := false;
					end if;
				when 3 =>
					if(in2 = out00 or in2 = out01) then
						ft2_out_var1 := true;
					else
						ft2_out_var1 := false;
					end if;
				when 4 =>
					if(in3 = out04) then
						ft2_out_var1 := true;
					else
						ft2_out_var1 := false;
					end if;
				when 5 =>
					if(in4 = out03) then
						ft2_out_var1 := true;
					else
						ft2_out_var1 := false;
					end if;
			end case;
--------------------------
			case num2 is 
				when 1 =>
					if(in0 = out11 or in0 = out12) then
						ft2_out_var2 := true;
					else
						ft2_out_var2 := false;
					end if;
				when 2 =>
					if(in1 = out10 or in1 = out12) then
						ft2_out_var2 := true;
					else
						ft2_out_var2 := false;
					end if;
				when 3 =>
					if(in2 = out10 or in2 = out11) then
						ft2_out_var2 := true;
					else
						ft2_out_var2 := false;
					end if;
				when 4 =>
					if(in3 = out14) then
						ft2_out_var2 := true;
					else
						ft2_out_var2 := false;
					end if;
				when 5 =>
					if(in4 = out13) then
						ft2_out_var2 := true;
					else
						ft2_out_var2 := false;
					end if;
				
			end case;
		end if;
		--------///// ft3
		if(ft3 = '1') then 
			case num1 is
				when 1 =>
					if(in0 = out01 and in0 = out02) then
						ft3_out_var1 := true;
					else
						ft3_out_var1 := false;
					end if;
				when 2 =>
					if(in1 = out00 and in1 = out02) then
						ft3_out_var1 := true;
					else
						ft3_out_var1 := false;
					end if;
				when 3 =>
					if(in2 = out00 and in2 = out01) then
						ft3_out_var1 := true;
					else
						ft3_out_var1 := false;
					end if;
				when 4 =>
					--if(in3 = out04) then
					--	ft3_out_var1 := true;
					--else
						ft3_out_var1 := false;
					--end if;
				when 5 =>
					--if(in4 = out03) then
					--	ft3_out_var1 := true;
					--else
						ft3_out_var1 := false;
					--end if;
			end case;
			--------------------------
			case num2 is 
				when 1 =>
					if(in0 = out11 and in0 = out12) then
						ft3_out_var2 := true;
					else
						ft3_out_var2 := false;
					end if;
				when 2 =>
					if(in1 = out10 and in1 = out12) then
						ft3_out_var2 := true;
					else
						ft3_out_var2 := false;
					end if;
				when 3 =>
					if(in2 = out10 and in2 = out11) then
						ft3_out_var2 := true;
					else
						ft3_out_var2 := false;
					end if;
				when 4 =>
					--if(in3 = out14) then
					--	ft3_out_var2 := true;
					--else
						ft3_out_var2 := false;
					--end if;
				when 5 =>
					--if(in4 = out13) then
					--	ft3_out_var2 := true;
					--else
						ft3_out_var2 := false;
					--end if;
				
			end case;
		end if;
-------------------------------------------------
		ft2_out1 <= ft2_out_var1;
		ft2_out2 <= ft2_out_var2;
-------------------------------------------------
		ft3_out1 <= ft3_out_var1;
		ft3_out2 <= ft3_out_var2;
	end process;

end fault;


