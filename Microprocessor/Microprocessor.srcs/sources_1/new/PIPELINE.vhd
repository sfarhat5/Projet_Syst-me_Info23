----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2022 19:08:46
-- Design Name: 
-- Module Name: PIPELINE - Behavioral
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

entity PIPELINE is
    Port ( CLK : in STD_LOGIC;
           OP_IN : in STD_LOGIC_VECTOR (7 downto 0);
           A_IN : in STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in STD_LOGIC_VECTOR (7 downto 0);
           C_IN : in STD_LOGIC_VECTOR (7 downto 0);
           Alea : in STD_LOGIC;
           OP_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           A_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           B_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           C_OUT : out STD_LOGIC_VECTOR (7 downto 0));
            
end PIPELINE;

architecture Behavioral of PIPELINE is

begin
process 
    begin
    wait until CLK'Event and CLK = '1';

    if Alea = '1' then 
        OP_OUT <= "00000000";
        A_OUT <= "00000000";
        B_OUT <= "00000000";
        C_OUT <= "00000000"; 
    else 
        OP_OUT <= OP_IN;
        A_OUT <= A_IN;
        B_OUT <= B_IN;
        C_OUT <= C_IN;
    end if; 
    end process; 

end Behavioral;
