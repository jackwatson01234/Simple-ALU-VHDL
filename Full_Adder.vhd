library ieee;
use ieee.std_logic_1164.all;

entity Full_Adder is
     port (en, X, Y, Cin: in std_logic;
            Sum,Cout:out  std_logic);
end Full_Adder;
architecture Full_Adder of Full_Adder is
    begin
      Sum  <= X xor Y xor Cin when en = '1' else
					'0' when en = '0';
      Cout <= (X and Y) or (X and Cin) or (Y and Cin) when en = '1' else
					'0' when en = '0';
end Full_Adder; 
