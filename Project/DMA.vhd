Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity DMA is
PORT  ( Clk,Copy : in std_logic;
	StartingAddress : in std_logic_vector(9 downto 0);
	DataIn : in std_logic_vector(15 downto 0);
	DataOut, M0, M1 : out std_logic_vector (15 downto 0)
);
END DMA;

architecture MyDMA of DMA is

Component syncram is
Generic (n : integer := 8);
port ( clk : in std_logic;
we : in std_logic;
address : in std_logic_vector(n-1 downto 0);
datain : in std_logic_vector(15 downto 0);
dataout : out std_logic_vector(15 downto 0) );
end Component syncram;

signal Address : std_logic_vector(9 downto 0);
signal DI :std_logic_vector(15 downto 0);
signal DO,DO0,DO1 : std_logic_vector(15 downto 0);
signal We : std_logic;
signal dontCare1, dontCare2 : std_logic_vector (15 downto 0);

begin
Mem : syncram generic map(n=>10) port map(Clk,We,Address,DI,DO);
Mem0 : syncram generic map(n=>10) port map(Clk,'0',"0000000000",dontCare1,DO0);
Mem1 : syncram generic map(n=>10) port map(Clk,'0',"0000000001",dontCare2,DO1);



DataOut <= DO;
M0 <= DO0;
M1 <= DO1;


end architecture MyDMA;