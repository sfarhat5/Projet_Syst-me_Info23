----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 11:28:45
-- Design Name: 
-- Module Name: REGISTER_FILE - Behavioral
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

entity REGISTER_FILE is
    Port ( aA : in STD_LOGIC_VECTOR (3 downto 0);
           aB : in STD_LOGIC_VECTOR (3 downto 0);
           aW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end REGISTER_FILE;

--REG IS A 16-REGISTER ARRAY (REGISTERS ARE 8 bits)
architecture Behavioral of REGISTER_FILE is type reg_array is array (0 to 15) of STD_LOGIC_VECTOR  (7 downto 0);
--INIT OF ARRAY
signal REG : reg_array := (others=>(others=>'0'));
begin    
--WRITE & RESET SYNC WITH CLOCK
    process          
    begin
        wait until CLK'Event and CLK = '1';
            --RESET REG IF RST=0
            if  ( RST = '1') then REG <= (others=>(others=>'0')); 
            --WRITE MODE ACTIVATED, COPY CONTENT OF DATA IN REGISTER THAT HAS THE ADDRESS aW
            elsif ( W = '1') then REG(to_integer(unsigned(aW))) <= DATA; --AFC: WE AFFECT THE CONTENT OF DATA TO @W. EX: AFC 0 (@W) 3 (Data)
            end if;
    end process;   
     
--READ ASYNC
--WE READ THE CONTENT OF aA WHEN WRITE MODE IS NOT ACTIVATED OR WHEN aX /= aW (TO AVOID READING AND WRITING AT THE SAME TIME)
--NOTE: 0 MEANS READ MODE AND 1 MEANS READ & WRITE
    QA <= REG(to_integer(unsigned(aA))) when aA /= aW or W ='0' else DATA;
    QB <= REG(to_integer(unsigned(aB))) when aB /= aW or W ='0' else DATA;
    --ELSE DATA FOR THE BYPASS

end Behavioral;