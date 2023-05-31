library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0); 
           B : in STD_LOGIC_VECTOR (7 downto 0);
           CTRL_ALU : in STD_LOGIC_VECTOR (2 downto 0); --Type of operation: ADD | SUB | MUL | DIV
           N : out STD_LOGIC; --Negative output: if S<0 then N<=1 else N<=0 
           O : out STD_LOGIC; --Overflow: O<=1 when A OP B > 8 bits
           Z : out STD_LOGIC; --Output is equal to zero: if S==0 then Z<=1 else Z<=0 
           C : out STD_LOGIC; --Carry: C <=S_ADD(8): carry of the ADD operation
           S : out STD_LOGIC_VECTOR (7 downto 0));
end UAL;

architecture Behavioral of UAL is
signal OP : STD_LOGIC_VECTOR (15 downto 0);
begin 
process(A,B,CTRL_ALU) --THE PROCESS IS RE EXECUTED EACH TIME ONE OF THESE CHANGES
    begin
        if CTRL_ALU="001" then OP<=(x"00"&A) + (x"00"&B); --OP ADD
        elsif CTRL_ALU="011" then OP<=(x"00"&A) - (x"00"&B); --OP SUB
        elsif CTRL_ALU="010" then OP<= A * B; --OP MUL
        elsif CTRL_ALU="100" then OP(7 downto 0)<= shr(A,"1"); --OP DIV (ONLY BY 2 : LEFT SHIFT)
        end if;
end process;

--UPDATE FLAGS
N <= '1' when OP < 0 else '0'; --If the result if negative the flag is updated  
Z <= '1' when OP(15 downto 0) = x"00" else '0'; 
O <= '1' when OP(15 downto 8) /=x"00" else '0'; --We check if bits from 8 to 15 have been changed
C <= OP(8); --Carry of OP ADD in the 8th bit

S <= OP (7 downto 0); --Output stored

end Behavioral;