--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package pack is
constant RstEnable : STD_lOGIC := '0' ;
constant RstDisable : STD_lOGIC := '1' ;

constant WriteEnable : STD_lOGIC := '0' ;
constant WriteDisable : STD_lOGIC := '1' ;

constant ReadEnable : STD_lOGIC := '0' ;
constant ReadDisable : STD_lOGIC := '1' ;

constant ChipEnable : STD_lOGIC := '0' ;
constant ChipDisable : STD_lOGIC := '1' ;

-- added ;
constant RamEnable : STD_lOGIC := '1' ;
constant RamDisable : STD_lOGIC := '0' ;

constant StallYes : STD_lOGIC := '0' ; 
constant StallNo : STD_lOGIC := '1' ;

constant BranchFlagDown : STD_lOGIC := '0' ;
constant BranchFlagUp : STD_lOGIC := '1' ; 

--word
subtype Word is STD_lOGIC_VECTOR (15 downto 0) ;
subtype WordBus is STD_lOGIC_VECTOR(15 downto 0) ;
constant ZeroWord : Word := "0000000000000000" ;
constant HighImpWord : Word := "ZZZZZZZZZZZZZZZZ" ;
--data
subtype DataAddrBus is STD_lOGIC_VECTOR (15 downto 0) ;
subtype DataBus is STD_lOGIC_VECTOR(15 downto 0) ;
constant ZeroData : Word := "0000000000000000" ;
constant ZeroDataAddr : Word := "0000000000000000" ;

--inst_mem
constant InstValid : STD_lOGIC := '0' ;
constant InstInvalid :STD_lOGIC := '1' ;
subtype InstAddrBus is STD_LOGIC_VECTOR (15 downto 0) ;
subtype InstBus is STD_lOGIC_VECTOR (15 downto 0) ;
--constant InstMemNum : INTEGER := 32767 ;
--constant InstMemNumLog2 : INTEGER := 15 ;
constant ZeroInst : Word := "0000000000000000" ;
constant ZeroInstAddr : Word := "0000000000000000" ;

--regs 
--R0-R15 0000-1111
--constant RegNum : INTEGER := 16 ;
--constant RegNumLog2 : INTEGER := 4 ;
subtype RegAddrBus is STD_lOGIC_VECTOR (3 downto 0) ;
constant ZeroRegAddr : RegAddrBus := "0000" ;
constant Reg0_Addr : RegAddrBus := "0000" ;
constant Reg1_Addr : RegAddrBus := "0001" ;
constant Reg2_Addr : RegAddrBus := "0010" ;
constant Reg3_Addr : RegAddrBus := "0011" ;
constant Reg4_Addr : RegAddrBus := "0100" ;
constant Reg5_Addr : RegAddrBus := "0101" ;
constant Reg6_Addr : RegAddrBus := "0110" ;
constant Reg7_Addr : RegAddrBus := "0111" ;
constant SP_Addr : RegAddrBus := "1000" ;
constant PC_Addr : RegAddrBus := "1001" ;
constant IH_Addr : RegAddrBus := "1010" ;
constant T_Addr : RegAddrBus := "1011" ;

-- mem
subtype MemRWBus is STD_lOGIC_VECTOR (1 downto 0) ;
constant MemRW_Idle : MemRWBus := "00" ;
constant MemRW_Read : MemRWBus := "01" ;
constant MemRW_Write : MemRWBus := "10" ;

-- mem's ram
constant RamReadEnable 		: STD_lOGIC := '1';
constant RamReadDisable 	: STD_lOGIC := '0';
constant RamWriteEnable 	: STD_lOGIC := '1';
constant RamWriteDisable	: STD_lOGIC := '0';
constant RamChipEnable 		: STD_lOGIC := '1';
constant RamChipDisable 	: STD_lOGIC := '0';

--ops id send to ex
subtype AluOpBus is STD_lOGIC_VECTOR(2 downto 0) ;
subtype AluSelBus is STD_lOGIC_VECTOR(2 downto 0) ; 

--subtype AluOpBus is STD_lOGIC_VECTOR(2 downto 0) ;
--special
constant EXE_OP_NOP	: AluOpBus := "000" ;
constant EXE_OP_INT	: AluOpBus := "001" ;

--reg
constant EXE_OP_LI	: AluOpBus := "000" ;
constant EXE_OP_MFIH : AluOpBus := "001" ;
constant EXE_OP_MFPC : AluOpBus := "010" ;
constant EXE_OP_MOVE : AluOpBus := "011" ;
constant EXE_OP_MTIH : AluOpBus := "100" ;
constant EXE_OP_MTSP : AluOpBus := "101" ;

--jump
constant EXE_OP_B	: AluOpBus := "000" ;
constant EXE_OP_BEQZ : AluOpBus := "001" ;
constant EXE_OP_BNEZ : AluOpBus := "010" ;
constant EXE_OP_BTEQZ : AluOpBus := "011" ;
constant EXE_OP_JR	: AluOpBus := "100" ;


--lw
constant EXE_OP_LW	: AluOpBus := "000" ;
constant EXE_OP_LW_SP : AluOpBus := "001" ;
constant EXE_OP_SW	: AluOpBus := "010" ;
constant EXE_OP_SW_SP : AluOpBus := "011" ;
constant EXE_OP_OTHER : AluOpBus := "111" ;

--cmp
constant EXE_OP_CMP	: AluOpBus := "000" ;
constant EXE_OP_CMPI : AluOpBus := "001" ;

--logic
constant EXE_OP_AND	: AluOpBus := "000" ;
constant EXE_OP_NEG	: AluOpBus := "001" ;
constant EXE_OP_OR	: AluOpBus := "010" ;

--shift
constant EXE_OP_SLL	: AluOpBus := "000" ;
constant EXE_OP_SLLV : AluOpBus := "001" ;
constant EXE_OP_SRA	 : AluOpBus := "010" ;
constant EXE_OP_SRL	: AluOpBus := "011" ;

--arith
constant EXE_OP_SUBU: AluOpBus := "000" ;
constant EXE_OP_ADDIU : AluOpBus := "001" ;
constant EXE_OP_ADDIU3 : AluOpBus := "010" ;
constant EXE_OP_ADDSP : AluOpBus := "011" ;
constant EXE_OP_ADDU : AluOpBus := "100" ;

--sels id send to ex
--subtype sel is STD_lOGIC_VECTOR (2 downto 0) ;
constant EXE_SEL_SPECIAL : AluSelBus := "000" ;
constant EXE_SEL_REG : AluSelBus := "001" ;
constant EXE_SEL_JUMP : AluSelBus := "010" ;
constant EXE_SEL_LW	: AluSelBus := "011" ;
constant EXE_SEL_CMP : AluSelBus := "100" ;
constant EXE_SEL_LOGIC : AluSelBus := "101" ;
constant EXE_SEL_SHIFT : AluSelBus := "110" ;
constant EXE_SEL_ARITH : AluSelBus := "111" ;

--mips16 instrcution sets( split into op0123)
subtype OP is STD_lOGIC_VECTOR(4 downto 0) ;
constant OP_NOP	: OP := "00001" ;
constant OP_B	: OP :=	"00010" ;
constant OP_BEQZ : OP := "00100" ;
constant OP_BNEZ : OP := "00101" ;
constant OP_SLL	: OP :=	"00110" ;
constant OP_SRL : OP :=	"00110" ;
constant OP_SRA	: OP :=	"00110" ;
constant OP_ADDIU3 : OP := "01000" ;
constant OP_ADDIU : OP := "01001" ;
constant OP_BTEQZ : OP := "01100" ;
constant OP_ADDSP : OP := "01100" ;
constant OP_MTSP : OP := "01100" ;
constant OP_LI : OP := "01101" ;
constant OP_CMPI : OP := "01110" ;
constant OP_MOVE : OP := "01111" ;
constant OP_LW_SP : OP := "10010" ;
constant OP_LW : OP := "10011" ;
constant OP_SW_SP : OP := "11010" ;
constant OP_SW : OP := "11011" ;
constant OP_ADDU : OP := "11100" ;
constant OP_SUBU : OP := "11100" ;
constant OP_JR : OP := "11101" ;
constant OP_MFPC : OP := "11101" ;
constant OP_CMP	: OP :=	"11101" ;
constant OP_NEG	: OP := "11101" ;
constant OP_AND	: OP :=	"11101" ;
constant OP_OR	: OP :=	"11101" ;
constant OP_SLLV : OP := "11101" ;
constant OP_MFIH : OP := "11110" ;
constant OP_MTIH : OP := "11110" ;
constant OP_INT	: OP :=	"11111" ;


-- subtype op0123
subtype OP1 is STD_lOGIC_VECTOR(2 downto 0) ;
subtype OP2 is STD_lOGIC_VECTOR(2 downto 0) ;
subtype OP3 is STD_lOGIC_VECTOR(4 downto 0) ;
subtype OP4 is STD_lOGIC_VECTOR(1 downto 0) ;

constant OP4_SLL : OP4 := "00" ;
constant OP4_SRL : OP4 := "10" ;
constant OP4_SRA : OP4 := "11" ;
constant OP4_ADDU : OP4 := "01" ;
constant OP4_SUBU : OP4 := "11" ;

constant OP1_BTEQZ : OP1 :=	"000" ;
constant OP1_ADDSP : OP1 := "011" ;
constant OP1_MTSP : OP1 := "100" ;


constant OP2_JR : OP2 := "000" ;
constant OP2_MFPC : OP2 := "010" ;

constant OP3_JR	: OP3 := "00000" ;
constant OP3_SLLV : OP3 := "00100" ;
constant OP3_CMP : OP3 := "01010" ;
constant OP3_NEG : OP3 := "01011" ;
constant OP3_AND : OP3 := "01100" ;
constant OP3_OR	: OP3 := "01101" ;
constant OP3_MFIH : OP3	:= "00000" ;
constant OP3_MTIH : OP3 := "00001" ;

end pack;

