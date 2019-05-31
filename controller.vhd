library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.my_components.all;

entity controller_ports is
	generic( n : integer := 26);
	port(inst : in std_logic_vector(n-1 downto 0);
		-- en(1) | 2*(1) | er2(1) | er3(1) | num1(3) | num2(3) | 2*D1(2*n) | 2*D2(2*n)
		-- number 0f bits for each signal
	  
		  en_computing : out std_logic_vector(4 downto 0);
		  arr1 : out std_logic_vector( (n-10)/2-1 downto 0); -- to adder_1
		  arr2 : out std_logic_vector( (n-10)/2-1 downto 0); -- to adder_2
		  arr3 : out std_logic_vector( (n-10)/2-1 downto 0); -- to adder_3
		  arr4 : out std_logic_vector( (n-10)/2-1 downto 0); -- to mult_1
		  arr5 : out std_logic_vector( (n-10)/2-1 downto 0); ---- to mult_1
			
		  ft2 , ft3 : out std_logic;
		  en_fault1, en_fault2 : out std_logic_vector(4 downto 0);
		  num1_out , num2_out : out integer range 1 to 5;
		  data_fault1, data_fault2 : out std_logic_vector( (n-10)/2-1 downto 0)
);
end controller_ports;


architecture controller of controller_ports is
		--signal ar1 : std_logic_vector( (n-10)/2-1 downto 0);
		--signal br1 : std_logic_vector( (n-10)/4-1 downto 0);
		--signal w1 : std_logic;
		--signal en : std_logic_vector(4 downto 0);
begin
	process(inst)
		variable num1 : integer range 1 to 5;
		variable num2 : integer range 1 to 5;
		variable enable_main : std_logic_vector(4 downto 0) := "00000";
		variable enable_chain : std_logic_vector(4 downto 0) := "00000";
	
		type array1 is array(1 to 5) of std_logic_vector( (n-10)/2-1 downto 0);
		variable a : array1; 

		variable en_fault1_var, en_fault2_var : std_logic_vector(4 downto 0) := "00000";
		variable data_fault1_var, data_fault2_var : std_logic_vector( (n-10)/2-1 downto 0);

	begin
		num1 := to_integer( unsigned( inst(n-5 downto n-7) ) );
		num2 := to_integer( unsigned( inst(n-8 downto n-10) ) );
			
		for i in 1 to 5 loop
			if(i=num1) then 
				enable_main(i-1) := '1';
			else
				enable_main(i-1) := '0';
			end if;

			if(i=num2) then 
				enable_chain(i-1) := '1';
			else
				enable_chain(i-1) := '0';
			end if;
		end loop;
		
		------ enable alu ------
		if(inst(n-1)='1') then

			if(inst(n-2)='1') then
				a(num1) := inst( n-11 downto (n-10)/2);
				a(num2) := inst( (n-10)/2-1 downto 0);
				enable_main := enable_main or enable_chain;
			elsif(inst(n-2)='0') then
				a(num1) := inst( n-11 downto (n-10)/2);
				
			end if;

		elsif(inst(n-1)='0')then
			enable_main := (others => '0');
		end if;
		------------------------
		if(inst(n-3)='1' or inst(n-4)='1') then
			en_fault1_var := "00000";
			en_fault2_var := "00000";

			if(inst(n-2)='1') then
				case num1 is
					when 1 => en_fault1_var := "01100";
					when 2 => en_fault1_var := "10100";
					when 3 => en_fault1_var := "11000";
					when 4 => en_fault1_var := "00001";
					when 5 => en_fault1_var := "00010";
				end case;
				data_fault1_var := inst( n-11 downto (n-10)/2 );
	
				case num2 is
					when 1 => en_fault2_var := "01100";
					when 2 => en_fault2_var := "10100";
					when 3 => en_fault2_var := "11000";
					when 4 => en_fault2_var := "00001";
					when 5 => en_fault2_var := "00010";
				end case;			
				data_fault2_var := inst( (n-10)/2-1 downto 0 );
		------------------------------------------------
			elsif(inst(n-2)='0') then
				case num1 is
					when 1 => en_fault1_var := "01100";
					when 2 => en_fault1_var := "10100";
					when 3 => en_fault1_var := "11000";
					when 4 => en_fault1_var := "00001";
					when 5 => en_fault1_var := "00010";
				end case;
				data_fault1_var := inst( n-11 downto (n-10)/2 );
				
			end if;
		end if;

		------------------------
		arr1 <= a(1);
		--ar1 <= a(1);
		arr2 <= a(2);
		arr3 <= a(3);
		arr4 <= a(4);
		arr5 <= a(5);	
		en_computing(4) <= enable_main(0);
		en_computing(3) <= enable_main(1);
		en_computing(2) <= enable_main(2);
		en_computing(1) <= enable_main(3);
		en_computing(0) <= enable_main(4);

		------------------------
		---- fault
		ft2 <= inst(n-3);
		ft3 <= inst(n-4);
		num1_out <= num1;
	   num2_out	<= num2;
		en_fault1 <= en_fault1_var;
		en_fault2 <= en_fault2_var;
		data_fault1 <= data_fault1_var;
		data_fault2 <= data_fault2_var;
		
	end process;




	--U1:adder_1_ports generic map( (n-10)/4 ) port map( en(4), ar1(  (n-10)/2-1 downto  (n-10)/4 ), ar1( (n-10)/4-1 downto 0), '0', br1( (n-10)/4-1 downto 0), w1);
end controller;






		--variable a1 : std_logic_vector(2*n-1 downto 0); 
		--variable a2 : std_logic_vector(2*n-1 downto 0);
		--variable a3 : std_logic_vector(2*n-1 downto 0);
		--variable a4 : std_logic_vector(2*n-1 downto 0); 
		--variable a5 : std_logic_vector(2*n-1 downto 0); 
