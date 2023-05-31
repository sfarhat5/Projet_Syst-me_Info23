----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2022 16:03:22
-- Design Name: 
-- Module Name: MEMORY_BANK_TEST - Behavioral
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

entity MEMORY_BANK_TEST is
end MEMORY_BANK_TEST;

architecture Behavioral of MEMORY_BANK_TEST is
component MEMORY_BANK
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--Inputs
signal ADDR : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal INPUT : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal RW : STD_LOGIC := '0';
signal RST : STD_LOGIC := '0';
signal CLK : STD_LOGIC := '0';

--Outputs
signal OUTPUT : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

type MEM_TAB is array (0 to 15) of STD_LOGIC_VECTOR  (7 downto 0);

begin

Test:  MEMORY_BANK PORT MAP(
ADDR => ADDR,
INPUT => INPUT,
RW => RW,
RST => RST,
CLK => CLK,
OUTPUT => OUTPUT
);

--SIMULATE CLOCK
SIM_CLK : process
begin
CLK <= NOT(CLK);
WAIT FOR 5ns;
end process;

RST <= '1', '0' after 20ns ;

--READ MODE
RW <= '0' after 30ns, '1' after 60ns; --30ns: WRITE MODE, 60ns: READ MODE
ADDR <= "00000001" after 30ns;
INPUT <= "00000011" after 30ns;
--MEM(1) SHOULD CHANGE AT 30ns TO 3
--OUTPUT SHOULD CHANGE AT 60ns TO 3


end Behavioral;
