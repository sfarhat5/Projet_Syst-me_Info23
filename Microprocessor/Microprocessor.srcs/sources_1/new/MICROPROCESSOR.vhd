----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2022 20:34:57
-- Design Name: 
-- Module Name: MICROPROCESSOR - Behavioral
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

entity MICROPROCESSOR is
    Port ( CLK : in STD_LOGIC;
           ADDR : in STD_LOGIC_VECTOR (7 downto 0));
end MICROPROCESSOR;

architecture Behavioral of MICROPROCESSOR is

--COMPONENTS

component INSTRUCTION_BANK is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0);
           alea : in STD_LOGIC
 );
end component;

component PIPELINE is
    Port ( CLK : in STD_LOGIC;
           OP_IN : in STD_LOGIC_VECTOR (7 downto 0);
           A_IN : in STD_LOGIC_VECTOR (7 downto 0);
           B_IN : in STD_LOGIC_VECTOR (7 downto 0);
           C_IN : in STD_LOGIC_VECTOR (7 downto 0);
           Alea : in STD_LOGIC :='0'; 
           OP_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           A_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           B_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           C_OUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component REGISTER_FILE is
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

component UAL is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0); 
           B : in STD_LOGIC_VECTOR (7 downto 0);
           CTRL_ALU : in STD_LOGIC_VECTOR (2 downto 0);
           N : out STD_LOGIC; 
           O : out STD_LOGIC; 
           Z : out STD_LOGIC; 
           C : out STD_LOGIC; 
           S : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component MEMORY_BANK is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--SIGNALS

--USELESS SIGNAL FOR 2 LAST PIPELINES
signal USELESS : STD_LOGIC_VECTOR (7 downto 0);

--PIPELINE OUTPUTS
signal LIDI_OP_OUT : STD_LOGIC_VECTOR (7 downto 0);
signal LIDI_A_OUT :  STD_LOGIC_VECTOR (7 downto 0);
signal LIDI_B_OUT :  STD_LOGIC_VECTOR (7 downto 0);
signal LIDI_C_OUT :  STD_LOGIC_VECTOR (7 downto 0);

signal DIEX_OP_OUT : STD_LOGIC_VECTOR (7 downto 0);
signal DIEX_A_OUT :  STD_LOGIC_VECTOR (7 downto 0);
signal DIEX_B_OUT :  STD_LOGIC_VECTOR (7 downto 0);
signal DIEX_C_OUT :  STD_LOGIC_VECTOR (7 downto 0);

signal EXMEM_OP_OUT : STD_LOGIC_VECTOR (7 downto 0);
signal EXMEM_A_OUT :  STD_LOGIC_VECTOR (7 downto 0);
signal EXMEM_B_OUT :  STD_LOGIC_VECTOR (7 downto 0);
signal EXMEM_C_OUT :  STD_LOGIC_VECTOR (7 downto 0); --WE DO NOT NEED IT

signal MEMRE_OP_OUT : STD_LOGIC_VECTOR (7 downto 0);
signal MEMRE_A_OUT :  STD_LOGIC_VECTOR (7 downto 0);
signal MEMRE_B_OUT :  STD_LOGIC_VECTOR (7 downto 0);
signal MEMRE_C_OUT :  STD_LOGIC_VECTOR (7 downto 0); --WE DO NOT NEED IT

--INSTRUCTION BANK OUTPUT
signal INSTR_BANK_OUT : STD_LOGIC_VECTOR(31 downto 0);


--REGISTER FILE OUTPUTS
signal REG_FILE_QA_OUT : STD_LOGIC_VECTOR (7 downto 0);
signal REG_FILE_QB_OUT : STD_LOGIC_VECTOR (7 downto 0);

--UAL OUTPUT
signal UAL_S_OUT : STD_LOGIC_VECTOR (7 downto 0);

--MEMORY BANK OUTPUTS
signal MEM_BANK_OUT : STD_LOGIC_VECTOR (7 downto 0);

--LC
    --LC UAL OUTPUT
signal LC_UAL_OUT : STD_LOGIC_VECTOR (2 downto 0);
    --LC MEMORY BANK OUTPUTS
signal LC_MEM_BANK_OUT: STD_LOGIC;
    --LC FINAL_OUTPUT
signal LC_FINAL_OUT : STD_LOGIC;

--MUX
    --MUX REGISTER FILE OUTPUT
signal MUX_REG_FILE_OUT : STD_LOGIC_VECTOR (7 downto 0);
    --MUX_UAL OUTPUT
signal MUX_UAL_OUT : STD_LOGIC_VECTOR (7 downto 0);
    --MUX MEMORY BANK
signal MUX_MEM_BANK_OUT : STD_LOGIC_VECTOR (7 downto 0);
signal MUX_OUT_MEM_BANK_IN : STD_LOGIC_VECTOR (7 downto 0);

--Signaux des aléas 
signal LIDI_READ : STD_LOGIC; 
signal DIEX_WRITE : STD_LOGIC; 
signal EXMEM_WRITE : STD_LOGIC; 
signal CONFLICT : STD_LOGIC := '0';

signal enable : STD_LOGIC := '0';
signal LIDI_Signal1 :   STD_LOGIC_VECTOR (7 downto 0); 
signal LIDI_Signal2 :   STD_LOGIC_VECTOR (7 downto 0); 
signal LIDI_Signal3 :   STD_LOGIC_VECTOR (7 downto 0); 
signal LIDI_Signal4 :   STD_LOGIC_VECTOR (7 downto 0); 


signal IP : STD_LOGIC_VECTOR( 7 downto 0) := (others => '0'); 

--PORT MAPS
begin



--INSTRUCTION BANK
INSTRUCTION_BANK_MAP: INSTRUCTION_BANK
port map(           
CLK => CLK,
ADDR => IP,
OUTPUT => INSTR_BANK_OUT,
alea => conflict
);

--INSTRUCTION_BANK => LI/DI
LIDI_MAP: PIPELINE
port map(           
CLK => CLK,
OP_IN => LIDI_Signal1,
A_IN => LIDI_Signal2, 
B_IN => LIDI_Signal3,
C_IN => LIDI_Signal4, 
Alea => CONFLICT,
OP_OUT => LIDI_OP_OUT,
A_OUT => LIDI_A_OUT,
B_OUT => LIDI_B_OUT,
C_OUT => LIDI_C_OUT
);

LIDI_Signal1 <= INSTR_BANK_OUT(31 downto 24) when enable = '1';--FIRST 8 BITS GO TO OP
LIDI_Signal2 <= INSTR_BANK_OUT(23 downto 16) when enable = '1';  --SECOND 8 BITS GO TO A
LIDI_Signal3 <= INSTR_BANK_OUT(15 downto 8) when enable = '1'; --THIRD 8 BITS GO TO B
LIDI_Signal4 <= INSTR_BANK_OUT(7 downto 0) when enable = '1';  --LAST 8 BITS GO TO C

--MUX REGISTER FILE
--FOR AFC AND LOAD INSTRUCTIONS: WE NEED THE OUTPUT OF LI/DI 
--(NB FOR AFC AND @B FOR LOAD), WE DO NOT NEED ITS CONTENT
--FOR ALL OTHER CASES (COP INCLUDED) WE NEED ITS CONTENT SO WE READ QA
MUX_REG_FILE_OUT <= LIDI_B_OUT when to_integer(unsigned(LIDI_OP_OUT)) = 6 or to_integer(unsigned(LIDI_OP_OUT)) = 7 else REG_FILE_QA_OUT;

-- LI/DI => DI/EX  
DIEX_MAP: PIPELINE
port map(           
CLK => CLK,
OP_IN => LIDI_OP_OUT,
A_IN => LIDI_A_OUT,
B_IN => MUX_REG_FILE_OUT,
C_IN => REG_FILE_QB_OUT,
OP_OUT => DIEX_OP_OUT,
A_OUT => DIEX_A_OUT,
B_OUT => DIEX_B_OUT,
C_OUT => DIEX_C_OUT
);



--LC UAL
--TELLS CNTRL ALU IN WHICH MODE IT SHOULD SWITCH
--DI/EX OP: OP ADD 0X01 OP MUL 0X02 OP SOU 0X03 OP DIV 0X04
--UAL CNTRL ALU: ADD 001 SOU 011 MUL 010 DIV(DECAL 2) 100
LC_UAL_OUT <= "001" when to_integer(unsigned(DIEX_OP_OUT)) = 1 else
    "010" when to_integer(unsigned(DIEX_OP_OUT)) = 2 else
    "011" when to_integer(unsigned(DIEX_OP_OUT)) = 3 else
    "100";

--UAL
UAL_MAP: UAL
port map(           
A => DIEX_B_OUT,
B => DIEX_C_OUT,
CTRL_ALU => LC_UAL_OUT,
S => UAL_S_OUT
);

--MUX UAL
--WE NEED THE OUTPUT OF THE UAL IN CASE THE OP WAS ADD/SOU/MUL/DIV
--IN ALL OTHER CASES, WE DIRECTLY USE THE OUTPUT OF DIEX_B
MUX_UAL_OUT <= UAL_S_OUT
    when to_integer(unsigned(DIEX_OP_OUT)) = 1
    or to_integer(unsigned(DIEX_OP_OUT)) = 2
    or to_integer(unsigned(DIEX_OP_OUT)) = 3
    or to_integer(unsigned(DIEX_OP_OUT)) = 4
    else DIEX_B_OUT;


--DI/EX => EX/MEM
EXMEM_MAP: PIPELINE
port map(           
CLK => CLK,
OP_IN =>  DIEX_OP_OUT,
A_IN => DIEX_A_OUT,
B_IN => MUX_UAL_OUT,
C_IN => (others=>'0'),--WE DO NOT NEED IT FOR THIS PIPELINE
OP_OUT => EXMEM_OP_OUT,
A_OUT => EXMEM_A_OUT,
B_OUT => EXMEM_B_OUT,
C_OUT => USELESS --WE DO NOT NEED IT FOR THIS PIPELINE
);

--EX/MEM => MEM/RE
MEMRE_MAP: PIPELINE
port map(           
CLK => CLK,
OP_IN =>  EXMEM_OP_OUT,
A_IN => EXMEM_A_OUT,
B_IN => MUX_MEM_BANK_OUT,
C_IN => (others=>'0'),--WE DO NOT NEED IT FOR THIS PIPELINE
OP_OUT => MEMRE_OP_OUT,
A_OUT => MEMRE_A_OUT,
B_OUT => MEMRE_B_OUT,
C_OUT => USELESS --WE DO NOT NEED IT FOR THIS PIPELINE
);

--FINAL LC
--W=1: READ & WRITE
--W=0: READ 
--OPERATIONS THAT WRITE IN THE REGISTER FILE: ALL OF THEM EXCEPT STORE
--WHICH WRITES IN THE MEMORY BANK(ITS INPUT IS AN ADDRESS AND NOT A REGISTER)
--WE SET W TO 0 ONLY FOR STORE, FOR ALL OTHER OPERATIONS WE SET W TO 1
LC_FINAL_OUT <= '0' when to_integer(unsigned(MEMRE_OP_OUT)) = 8 else '1';

--MEM/RE => REGISTER FILE
REGISTER_FILE_MAP: REGISTER_FILE
port map(           
aA => LIDI_B_OUT(3 downto 0), --WE ONLY NEED THE 4 FIRST BITS
aB => LIDI_C_OUT(3 downto 0), --WE ONLY NEED THE 4 FIRST BITS
aW => MEMRE_A_OUT(3 downto 0), --WE ONLY NEED THE 4 FIRST BITS
W => LC_FINAL_OUT,
DATA => MEMRE_B_OUT,
RST => '0',
CLK => CLK,
QA => REG_FILE_QA_OUT,
QB => REG_FILE_QB_OUT
);




--LC MEMORY_BANK
--THE ONLY OPERATION THAT READS IS STORE (8)
LC_MEM_BANK_OUT <= '0' when to_integer(unsigned(EXMEM_OP_OUT)) = 8 else '1';

--MUX MEMORY BANK IN
--MEMORY BANK IS USED FOR THE LOAD(7) AND STORE(8) OPERATIONS TO RETRIEVE THE VALUE OF THE VARIABLE
--LOAD(7): WRITE MDOE: WE TAKE B AS @ (LOAD Ri @j)
--STORE(8): READ MODE: WE TAKE A AS @ (STORE @i Rj)

MUX_OUT_MEM_BANK_IN <= EXMEM_A_OUT when to_integer(unsigned(EXMEM_OP_OUT)) = 8 else EXMEM_B_OUT;
     
--MUX MEMORY BANK OUT
--LOAD: WE TAKE THE @ OF B TO RETRIEVE ITS VALUE AND SOTRE IT IN A REGISTER.
--SO THE OUT OF THE MUX MUST BE THE VALUE IN @B SO WE ASSIGN MUX OUT TO MEMORY BANK OUT
--STORE: WE TAKE THE @ OF A TO PUT THE VALUE OF SOME REGISTER IN THAT @
--MEANING WE DO NOT NEED THE VALUE CONTAINED IN @A SO WE ASSIGN MUX OUT TO @ OF MEMORY BANK DIRECTLY (@A)
MUX_MEM_BANK_OUT <= MEM_BANK_OUT when to_integer(unsigned(EXMEM_OP_OUT)) = 7 else EXMEM_B_OUT;

--Detection d'aléas 
LIDI_READ <= '1' 
    when INSTR_BANK_OUT(31 downto 24) = x"05" or  --COP
         INSTR_BANK_OUT(31 downto 24) = x"02" or  --SUB
         INSTR_BANK_OUT(31 downto 24) = x"03" or  --MUL
         INSTR_BANK_OUT(31 downto 24) = x"01" or  --ADD
         INSTR_BANK_OUT(31 downto 24) = x"08"     --STORE
     else '0'; 
DIEX_WRITE <= '1' when (DIEX_OP_OUT=x"01" or DIEX_OP_OUT=x"02" or DIEX_OP_OUT=x"03" or DIEX_OP_OUT=x"06" or DIEX_OP_OUT=x"05") else '0'; 
EXMEM_WRITE <= '1' 
    when 
        EXMEM_OP_OUT =x"01" or --ADD
        EXMEM_OP_OUT =x"02" or --SUB
        EXMEM_OP_OUT =x"03" or --MUL
        EXMEM_OP_OUT =x"06" or --AFC
        EXMEM_OP_OUT =x"05" --COP
     else '0'; 

CONFLICT <= '1' 
    when (LIDI_READ = '1' and DIEX_WRITE = '1' and  INSTR_BANK_OUT(15 downto 8 ) = LIDI_A_OUT) or
         ( LIDI_READ = '1' and DIEX_WRITE = '1' and  INSTR_BANK_OUT(7 downto 0) = LIDI_A_OUT) or
         (LIDI_READ = '1' and EXMEM_WRITE = '1' and INSTR_BANK_OUT(15 downto 8 ) = DIEX_A_OUT) or  
         ( LIDI_READ = '1' and EXMEM_WRITE = '1' and INSTR_BANK_OUT(7 downto 0) = DIEX_A_OUT) 
    else 
         '0'; 

process 
begin 
    wait until CLK'Event and CLK = '1';
  if CONFLICT = '0' then 
         IP <= IP +1;
         enable <= '1';
  else 
        enable <= '0'; 
  end if; 
end process;  
    
    
--stop <= '1'when(LIDI_READ = '1'and DIEX_WRITE = '1' and CONFLICT_LIDI_DIEX = '1') or (LIDI_READ = '1' and EXMEM_WRITE ='1'and CONFLICT_LIDI_EXMEM ='1'); 

--MEMORY BANK
MEMORY_BANK_MAP: MEMORY_BANK
port map ( 
ADDR => MUX_OUT_MEM_BANK_IN,
INPUT => EXMEM_B_OUT,
RW => LC_MEM_BANK_OUT,
RST => '0',
CLK => CLK,
OUTPUT => MEM_BANK_OUT
);

end Behavioral;

