Library ieee;
Use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

ENTITY AddSubIncDec IS
port(
	R1_Reg,R2_Reg,ROut_Alu,ROut_Mem: in std_logic_vector(2 downto 0);
	R1,R2: out std_logic_vector(15 downto 0);
	R1_Mux,R2_Mux : out std_logic;
	Alu_Output , Meomry_Output: in std_logic_vector(15 downto 0)
	--Alu_Output1 , Meomry_Output1: out std_logic_vector(15 downto 0);
	--WriteBackSignal : in std_logic
	);
END AddSubIncDec;

Architecture archi of AddSubIncDec is
begin
R1 <= 	Alu_Output when R1_Reg = ROut_Alu else
		Meomry_Output when R1_Reg = ROut_Mem;
	  

R2 <= 	Alu_Output when R2_Reg = ROut_Alu else
		Meomry_Output when R2_Reg = ROut_Mem;
		

R1_Mux <= 	'1' when R1_Reg = ROut_Alu or R1_Reg = ROut_Mem else
			'0';
			
R2_Mux <= 	'1' when R2_Reg = ROut_Alu or R2_Reg = ROut_Mem else
			'0';



end archi;