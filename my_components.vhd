library ieee;
use ieee.std_logic_1164.all;

package my_components is
---------------------------------------------------------------------
component mux_2to1_ports is
	generic( n : positive);
	port(a0, a1: in std_logic_vector(n-1 downto 0);
		  sel: in std_logic;
		  y : out std_logic_vector(n-1 downto 0) );
end component;
---------------------------------------------------------------------
component adder_1_ports is
	generic( n : positive);
	port( en : in std_logic;
		  a, b: in std_logic_vector(n-1 downto 0);
		  cin : in std_logic;
		  s   : out std_logic_vector(n-1 downto 0);
		  cout: out std_logic );
end component;
---------------------------------------------------------------------
component adder_2_ports is
	generic( n : positive);
	port( en : in std_logic;
		  a, b: in std_logic_vector(n-1 downto 0);
		  cin : in std_logic;
		  s   : out std_logic_vector(n-1 downto 0);
		  cout: out std_logic );
end component;
---------------------------------------------------------------------
component adder_3_ports is
	generic( n : positive);
	port( en : in std_logic;
		  a, b: in std_logic_vector(n-1 downto 0);
		  cin : in std_logic;
		  s   : out std_logic_vector(n-1 downto 0);
		  cout: out std_logic );
end component;
---------------------------------------------------------------------
component mult_1_ports is
	generic( n : positive);
	port( en : in std_logic;
		  a, b: in std_logic_vector(n-1 downto 0);
		  m   : out std_logic_vector(2*n-1 downto 0) );
end component;
---------------------------------------------------------------------
component mult_2_ports is
	generic( n : positive);
	port( en : in std_logic;
		  a, b: in std_logic_vector(n-1 downto 0);
		  m   : out std_logic_vector(2*n-1 downto 0) );
end component;
---------------------------------------------------------------------
component controller_ports is
	generic( n : positive);
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
end component;
---------------------------------------------------------------------
component computing_ports is
	generic( n : positive);
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
end component;
---------------------------------------------------------------------
component fault_ports is
	generic(n : positive);
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
end component;
---------------------------------------------------------------------
component selector_ports is
	generic( n : positive);
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
end component;
---------------------------------------------------------------------
-----mult2
component FA_And is
	generic( n : positive);
	port(en : in std_logic;
		b : in std_logic;
		cin : in std_logic_vector(n-2 downto 0);
		pre_s : in std_logic_vector(n-2 downto 0);
		a : in std_logic_vector(n-1 downto 0);
		s : out std_logic_vector(n-1 downto 0);
		cout : out std_logic_vector(n-2 downto 0));
end component;
     
component and_par_mult is
	generic( n : positive);
	port(	en : in std_logic;
			a : in std_logic_vector(n-1 downto 0);
			b : in std_logic;
			s : out std_logic_vector(n-1 downto 0));
end component;

component Full_Adder is
     port ( en ,X, Y, Cin: in std_logic;
            Sum,Cout:out  std_logic);
end component;




end my_components;
