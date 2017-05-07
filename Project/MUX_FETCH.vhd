
library  ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;
 
entity MUX_Fetch is 
port (
	Sel: in std_logic_vector (1 downto 0);--input from control unit
			
--at reset control unit send zeroes to pcs
	--PC1: in std_logic_vector(15 downto 0 ); --
	PC2: in std_logic_vector(15 downto 0 ); --address to jump to from BRANCH
	PC3: in std_logic_vector(15 downto 0 ); --address from memory[0]
	PC4: in std_logic_vector(15 downto 0 ); --address from memory[1]
	CLK: in std_logic;
	Out_instruction: out std_logic_vector(15 downto 0 );
	--Out_PC: out std_logic_vector(15 downto 0 );
	RESET: in std_logic
);
end entity MUX_Fetch;




architecture MUX_Fetch_Arch of MUX_Fetch is 




Component syncram is
		generic ( n : integer := 16);
port ( 
					clk : in std_logic;
					we : in std_logic;
					address : in std_logic_vector(n-1 downto 0);
					datain : in std_logic_vector(15 downto 0);
					dataout : out std_logic_vector(15 downto 0)				
				  );
			end component;
--***********************************************************************************
Component PC is
		
port ( 

	counter: in std_logic_vector(15 downto 0 ); 
	new_counter: out std_logic_vector(15 downto 0 );
	CLK: in std_logic;
	RESET: in std_logic
);
end component;




signal MY_PC_SIGNAL: std_logic_vector(15 downto 0);
--signal new_count: std_logic_vector(15 downto 0);
signal PC1: std_logic_vector(15 downto 0);

signal copied_data: std_logic_vector(15 downto 0);

begin 

--send zero to pc when reset
MY_PC_SIGNAL <= PC1 when Sel = "00" and RESET='0' else
     PC2 when Sel = "01" and RESET='0' else
     PC3 when Sel = "10" and RESET='0' else
     PC4 when Sel = "11" and RESET='0'else 
	(others => '0') when RESET='1' else
	(others => '0');

	

--------------------------------------
 

set0: syncram generic map (n =>16) port map (CLK,'0',MY_PC_SIGNAL,"0000000000000000",copied_data); --clk,enable,(address to WRITE in),data to write, outputdata from selected address

My_PC: PC port map (MY_PC_SIGNAL,PC1,CLK,RESET);

--PC1<=MY_PC_SIGNAL;
Out_instruction<=copied_data;
--Out_PC<=MY_PC_SIGNAL;
end architecture MUX_Fetch_Arch;