----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2022 13:06:05
-- Design Name: 
-- Module Name: MEMORY_BANK - Behavioral
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

entity MEMORY_BANK is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end MEMORY_BANK;

architecture Behavioral of MEMORY_BANK is
type MEM_TAB  is array(255 downto 0) of std_logic_vector(7 downto 0); --WE HAVE 256 SLOTS OF MEMORY
signal MEM : MEM_TAB := (others=>(others=>'0'));
begin

process
begin
         wait until CLK'Event and CLK = '1';
            --RESET
            if  ( RST = '1') then MEM <= (others=>X"00");
            --READ MODE
            elsif ( RW = '1') then OUTPUT <= MEM(to_integer(unsigned(ADDR)));
            --WRITE MODE
            else MEM(to_integer(unsigned(ADDR))) <= INPUT;
        end if;
 
end process;

end Behavioral;
