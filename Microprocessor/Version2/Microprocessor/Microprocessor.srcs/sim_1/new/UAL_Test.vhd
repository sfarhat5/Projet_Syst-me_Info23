----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 09:46:25
-- Design Name: 
-- Module Name: UAL_Test - Behavioral
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

entity UAL_Test is

end UAL_Test;

architecture Behavioral of UAL_Test is
component UAL
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
       B : in STD_LOGIC_VECTOR (7 downto 0);
       CTRL_ALU : in STD_LOGIC_VECTOR (2 downto 0);
       N : out STD_LOGIC;
       O : out STD_LOGIC;
       Z : out STD_LOGIC;
       C : out STD_LOGIC;
       S : out STD_LOGIC_VECTOR (7 downto 0)
       );
end component;

--Inputs
signal A : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal B : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal CTRL_ALU : STD_LOGIC_VECTOR (2 downto 0) := (others=>'0');

--Outputs
signal N : STD_LOGIC := '0';
signal O : STD_LOGIC := '0';
signal Z : STD_LOGIC := '0';
signal C : STD_LOGIC := '0';
signal S : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

begin
UUT:  UAL PORT MAP(
A => A,
B => B,
CTRL_ALU => CTRL_ALU,
N => N,
O => O,
Z => Z,
C => C,
S => S
);

process
begin
A <= x"04";
B <= x"02";
CTRL_ALU <= "001"; --ADD OPERATION TEST
wait for 2ps;
A <= x"04";
B <= x"02";
CTRL_ALU <= "011"; --SUB OPERATION TEST
wait for 2ps;
A <= x"04";
B <= x"02";
CTRL_ALU <= "010"; --MUL OPERATION TEST
wait for 2ps;


A <= x"ff";
B <= x"ff";
CTRL_ALU <= "001"; --C FLAG TEST
wait for 2ps;
A <= x"02";
B <= x"02";
CTRL_ALU <= "011"; --Z FLAG TEST
wait for 2ps;
A <= x"01";
B <= x"02";
CTRL_ALU <= "011"; --N FLAG TEST
wait for 2ps;
A <= x"ff";
B <= x"02";
CTRL_ALU <= "010"; --O FLAG TEST
wait for 2ps;
end process;


end Behavioral;
