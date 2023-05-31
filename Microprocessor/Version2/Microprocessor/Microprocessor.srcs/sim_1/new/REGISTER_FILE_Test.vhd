----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 11:01:51
-- Design Name: 
-- Module Name: REGISTER_FILE_Test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REGISTER_FILE_Test is
end REGISTER_FILE_Test;

architecture Behavioral of REGISTER_FILE_Test is
component REGISTER_FILE
    Port ( aA : in STD_LOGIC_VECTOR (3 downto 0);
           aB : in STD_LOGIC_VECTOR (3 downto 0);
           aW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--Inputs
signal aA : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal aB : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal aW : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal W : STD_LOGIC := '0';
signal DATA : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal RST : STD_LOGIC := '0';
signal CLK : STD_LOGIC := '0';

--Outputs
signal QA : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal QB : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

type reg_array is array (0 to 15) of STD_LOGIC_VECTOR  (7 downto 0);



begin
UUT:  REGISTER_FILE PORT MAP(
aA => aA,
aB => aB,
aW => aW,
W => W,
DATA => DATA,
RST => RST,
CLK => CLK,
QA => QA,
QB => QB
);

--SIMULATE CLOCK
SIM_CLK : process
begin
CLK <= NOT(CLK);
WAIT FOR 5ns;
end process;


--READ & WRITE MODE: WE WANT TO WRITE 7 IN THE 4th REGISTER
--QA <= "00000010" after 20ns; --INIT QA = 2 TO SEE THE CHANGE FROM 2 TO 0
--QB <= "00000010" after 20ns; --INIT QB = 2 TO SEE THE CHANGE FROM 2 TO 0
RST <= '0', '1' after 20ns ;
DATA <= "00000111" after 20ns ;
aW <="0011" after 20ns, "0000" after 30ns ; --4th REGISTER
--aW IS THEN CHANGED TO SATISFY THE CONDITION aB/=aW and aA/=aW
W <= '1' after 20ns ;


aA <= "0011" after 40ns, "0000" after 60ns ; --40ns: QA WILL NOT CHANGE BECAUSE aA == aW 
                                             --60ns: QA WILL  CHANGE BECAUSE aA /= aW AND WILL CONTAIN 7
aB <= "0011" after 60ns ; --QB WILL  CHANGE BECAUSE aB /= aW AND WILL CONTAIN 7


end Behavioral;
