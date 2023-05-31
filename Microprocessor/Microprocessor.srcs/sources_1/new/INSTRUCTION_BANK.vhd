----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2022 15:30:17
-- Design Name: 
-- Module Name: INSTRUCTION_BANK - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity INSTRUCTION_BANK is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0);
           Alea : in STD_LOGIC);
end INSTRUCTION_BANK;

architecture Behavioral of INSTRUCTION_BANK is
type MEM_TAB  is array(255 downto 0) of std_logic_vector(31 downto 0);
signal MEM : MEM_TAB  := (others =>(others =>'0')) ;
begin

--TESTS FOR FINAL PART
MEM(0) <= x"06000500"; --AFC 0 5, REG(0) WILL CONTAIN 5
MEM(1) <= x"06010600"; --AFC 1 6, REG(1) WILL CONTAIN 6
MEM(2) <= x"01020001"; --ADD 2 0 1, REG(2) WILL CONTAIN 11
--MEM(3) <= x"05030200"; --COP 3 2, REG(3) WILL CONTAIN 11
--MEM(4) <= x"06050900"; --AFC 5 9, REG(5) WILL CONTAIN 9
--MEM(5) <= x"08000500"; --STORE 0 5, MEM(0) WILL CONTAIN 9 !NOTE! WE STORE IN THE MEMORY BANK AND NOT THE REGISTER FILE
--MEM(6) <= x"07040000"; --LOAD 4 0, REG(4) WILL CONTAIN 9  
--MEM(7) <= x"02070001"; --MUL 7 0 1, REG(7) WILL CONTAIN 5*6=30 AKA 0X1E
--MEM(8) <= x"03080305"; --SOU 8 3 5, REG(8) WILL CONTAIN 11-9=2
--MEM(9) <= x"04090100"; --DIV 9 1 0, REG(9) WILL CONTAIN 6/2=3 !NOTE! THE LAST ARG IS USELESS, WE JUST DEVIDE BY 2 (LEFT SHIFT ONCE)


process
begin
    wait until CLK'Event and CLK = '1';
        if(alea='0') then 
        OUTPUT <= MEM(to_integer(unsigned(ADDR)));     
        end if;  
                        
end process;


end Behavioral;
