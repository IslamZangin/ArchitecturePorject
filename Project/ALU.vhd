library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
--Mux bet B and Nbits(shifting kam bit)
-- 
entity ALU is
  port (
	Clk,Rst,enable : in std_logic;
    OpCode : in  std_logic_vector(4 downto 0);
	R1: in  std_logic_vector(15 downto 0);
	R2: in  std_logic_vector(15 downto 0);
	Output: out std_logic_vector(15 downto 0);
	n : in std_logic_vector (3 downto 0);
	Z: out std_logic;
	NF: out std_logic;
	v: out std_logic;
	C: out std_logic
 	);
end  ALU;



Architecture archi of ALU is

Component AddSubIncDec is
port(
	R1,R2: in std_logic_vector(15 downto 0);
	OutPut : out std_logic_vector(15 downto 0); 
	OpCode :in std_logic_vector(4 downto 0);
	--Z: out std_logic;
	--V: out std_logic;
	C: out std_logic
	--N: out std_logic
	);
end component;

component Regis is
port( Clk,Rst,enable : in std_logic;
d : in std_logic;
q : out std_logic);
end component;








signal TempOut : std_logic_vector(15 downto 0);
signal TempZ,TempC,TempC_Add,TempV,TempN,TempZ2,TempC2,TempV2,TempN2 : std_logic;
signal Output_signal:  std_logic_vector(15 downto 0);


Begin

--F1: AddSubIncDec port map(R1,R2,TempOut,OpCode,TempZ,TempV,TempC,TempN);
F1: AddSubIncDec port map(R1,R2,TempOut,OpCode,TempC_Add);
F2: Regis port map(Clk,Rst,enable,TempZ,TempZ2);
F3: Regis port map(Clk,Rst,enable,TempC,TempC2);
F4: Regis port map(Clk,Rst,enable,TempV,TempV2);
F5: Regis port map(Clk,Rst,enable,TempN,TempN2);

-----------------------------------------------------------
TempC  <= '0' when OpCode = "01010" else
        '1' when OpCode = "01011" else 
	    --TempC2  when OpCode = "00010" or OpCode = "00011" or OpCode = "10010" or OpCode = "10011" else
	    R1(0)  when OpCode = "00111" else
	    TempC_Add when OpCode = "00010" or OpCode = "00011" or OpCode = "10010" or OpCode = "10011" else 
		R1(15)  when OpCode = "00110";
	  
	  
TempV  <= '1' when Output_signal(15) = '1' and R1(15) = '0' and R2(15) = '0' and OpCode = "00010" else
	  '1' when Output_signal(15) = '0' and R1(15) = '1' and R2(15) = '1' and OpCode = "00010" else
	  '1' when Output_signal(15) = '0' and R1(15) = '1' and R2(15) = '0' and OpCode = "00011" else 
	  '1' when Output_signal(15) = '1' and R1(15) = '0' and R2(15) = '1' and OpCode = "00011" else
	  '1' when Output_signal(15) = '1' and R1(15) = '0' and OpCode = "10010" else
      '1' when Output_signal(15) = '0' and R1(15) = '1' and OpCode = "10011" else	  
      '0'; 
TempZ  <= '1' when Output_signal(15 downto 0) = "0000000000000000" and OpCode = "00010" else
	  '1' when Output_signal(15 downto 0) = "0000000000000000" and OpCode = "00011" else
	  '1' when Output_signal(15 downto 0) = "0000000000000000" and OpCode = "00100" else
	  '1' when Output_signal(15 downto 0) = "0000000000000000" and OpCode = "00101" else
	  '1' when Output_signal(15 downto 0) = "0000000000000000" and OpCode = "10000" else
	  '1' when Output_signal(15 downto 0) = "0000000000000000" and OpCode = "10001" else
	  '1' when Output_signal(15 downto 0) = "0000000000000000" and OpCode = "10010" else
	  '1' when Output_signal(15 downto 0) = "0000000000000000" and OpCode = "10011" else
   	  '0';
TempN  <= '1' when Output_signal(15) = '1' and OpCode = "00010" else
	  '1' when Output_signal(15) = '1' and OpCode = "00011" else
	  '1' when Output_signal(15) = '1' and OpCode = "00100" else
	  '1' when Output_signal(15) = '1' and OpCode = "00101" else
	  '1' when Output_signal(15) = '1' and OpCode = "10000" else
	  '1' when Output_signal(15) = '1' and OpCode = "10001" else
	  '1' when Output_signal(15) = '1' and OpCode = "10010" else
	  '1' when Output_signal(15) = '1' and OpCode = "10011" else
   	  '0';







--------------------------------------

	  
Output_signal <=  R1(15 downto 0) when n = "0000" else
		  '0' & R1(15 downto 1) when n = "0001" and OpCode = "01001" else
		  "00" & R1(15 downto 2) when n = "0010" and OpCode = "01001"  else
		  "000" & R1(15 downto 3) when n = "0011" and OpCode = "01001"  else
		  "0000" & R1(15 downto 4) when n = "0100" and OpCode = "01001"  else
		  "00000" & R1(15 downto 5) when n = "0101" and OpCode = "01001"  else
		  "000000" & R1(15 downto 6) when n = "0110" and OpCode = "01001"  else
		  "0000000" & R1(15 downto 7) when n = "0111" and OpCode = "01001"  else
		  "00000000" & R1(15 downto 8) when n = "1000" and OpCode = "01001"  else
		  "000000000" & R1(15 downto 9) when n = "1001" and OpCode = "01001"  else
		  "0000000000" & R1(15 downto 10) when n = "1010" and OpCode = "01001"  else
		  "00000000000" & R1(15 downto 11) when n = "1011" and OpCode = "01001"  else
		  "000000000000" & R1(15 downto 12) when n = "1100" and OpCode = "01001"  else
		  "0000000000000" & R1(15 downto 13) when n = "1101" and OpCode = "01001"  else
		  "00000000000000" & R1(15 downto 14) when n = "1110" and OpCode = "01001"  else
		  "000000000000000" & R1(15) when n = "1111" and OpCode = "01001" else
		  
			R1(15 downto 0) when n = "0000" and OpCode = "01000" else
		   R1(14 downto 0) & '0' when n = "0001" and OpCode = "01000" else
		   R1(13 downto 0) & "00" when n = "0010" and OpCode = "01000" else
		   R1(12 downto 0) & "000" when n = "0011" and OpCode = "01000" else
		   R1(11 downto 0) & "0000" when n = "0100" and OpCode = "01000" else
		   R1(10 downto 0) & "00000" when n = "0101" and OpCode = "01000" else
		   R1(9 downto 0)  & "000000" when n = "0110" and OpCode = "01000" else
		   R1(8 downto 0)  & "0000000" when n = "0111" and OpCode = "01000" else
		   R1(7 downto 0)  & "00000000" when n = "1000" and OpCode = "01000" else
		   R1(6 downto 0)  & "000000000" when n = "1001" and OpCode = "01000" else
		   R1(5 downto 0)  & "0000000000" when n = "1010" and OpCode = "01000" else
		   R1(4 downto 0)  & "00000000000" when n = "1011" and OpCode = "01000" else
		   R1(3 downto 0)  & "000000000000" when n = "1100" and OpCode = "01000" else
		   R1(2 downto 0)  & "0000000000000" when n = "1101" and OpCode = "01000" else
		   R1(1 downto 0)  & "00000000000000" when n = "1110" and OpCode = "01000" else
		   R1(0)& "000000000000000" when n = "1111" and OpCode = "01000" else		   
		   
		  R1 and R2 when OpCode ="00100" else  
	      R1 or  R2 when OpCode ="00101" else   
		  not R1    when OpCode ="10000" else
		  TempC2 & R1(15 downto 1)  when OpCode = "00111"else
		  R1(14 downto 0) & TempC2  when OpCode = "00110" else
		 (-R1) when OpCode = "10001" else
		  R1  when OpCode = "00001";
		
		
	OutPut <= TempOut when OpCode = "00010" or OpCode = "00011" or OpCode = "10010" or OpCode = "10011" else 
		      Output_signal;
	c <= TempC;
	z <= TempZ;
	v <= TempV;
	NF <= TempN;
	
end archi;