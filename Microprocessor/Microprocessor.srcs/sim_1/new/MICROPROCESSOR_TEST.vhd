----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2022 21:16:20
-- Design Name: 
-- Module Name: MICROPROCESSOR_TEST - Behavioral
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

entity MICROPROCESSOR_TEST is
end MICROPROCESSOR_TEST;

architecture Behavioral of MICROPROCESSOR_TEST is

component MICROPROCESSOR is
    Port ( CLK : in STD_LOGIC;
          ADDR : in STD_LOGIC_VECTOR (7 downto 0)
 );
end component;

--INPUTS
signal testCLK:  STD_LOGIC :='0' ;
signal testADDR :  std_logic_vector(7 downto 0) := (others => '0');

begin

MICROPROCESSOR_MAP: MICROPROCESSOR
PORT MAP(
CLK => testCLK,
ADDR => testADDR
);

--SIMULATE CLOCK
SIM_CLK : process
begin
testCLK <= NOT(testCLK);
wait for 5ns;
end process;


--THE INSTRUCTIONS HAVE BEEN INITIALIZED IN THE INSTRUCTION BANK FILE
--WE LOADED THE 8 FIRST SLOTS
--WE WILL NOW SEE IF THE COMPONENTS WORK PROPERLY BY ANALIZING THEIR FIELD CONTENTS

--testADDR <= "00000000", --AFC 0 5, REG(0) WILL CONTAIN 5
--            "00000001" after 100ns, --AFC 1 6, REG(1) WILL CONTAIN 6
--            "00000010" after 200ns, --ADD 2 0 1, REG(2) WILL CONTAIN 11
--            "00000011" after 300ns, --COP 3 2, REG(3) WILL CONTAIN 11
--            "00000100" after 400ns, --AFC 5 9, REG(5) WILL CONTAIN 9
--            "00000101" after 500ns, --STORE 0 5, MEM(0) WILL CONTAIN 9 !NOTE! WE STORE IN THE MEMORY BANK AND NOT THE REGISTER FILE
--            "00000110" after 600ns, --LOAD 4 0, REG(4) WILL CONTAIN 9  
--            "00000111" after 700ns, --MUL 7 4 1, REG(7) WILL CONTAIN 9*6=54 AKA 0X36
--            "00001000" after 800ns, --SOU 8 3 5, REG(8) WILL CONTAIN 11-9=2
--            "00001001" after 900ns; --DIV 9 1 0, REG(9) WILL CONTAIN 6/2=3 !NOTE! THE LAST ARG IS USELESS, WE JUST DEVIDE BY 2 (LEFT SHIFT ONCE)
end Behavioral;
