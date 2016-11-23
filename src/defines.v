`define RstEnable 1'b0
`define RstDisable 1'b1

`define WriteEnable 1'b0
`define WriteDisable 1'b1

`define ReadEnable 1'b0
`define ReadDisable 1'b1

`define PCChipEnable 1'b0
`define PCChipDisable 1'b1

`define StallYes 1'b0 	
`define StallNo  1'b1

`define BranchFlagDown  1'b0
`define BranchFlagUp  1'b1 

//word
`define WordLength 16
`define WordBus `WordLength-1:0
`define ZeroWord `WordLength'b0
`define HighImpWord `WordLength'bZZZZZZZZZZZZZZZZ

//data
`define DataAddrBus `WordBus
`define DataBus `WordBus
`define ZeroData `ZeroWord
`define ZeroDataAddr `ZeroWord

//inst_mem
`define InstValid 1'b0
`define InstInvalid 1'b1
`define InstAddrBus `WordBus
`define InstBus `WordBus
`define ZeroInst `ZeroWord
`define ZeroInstAddr `ZeroWord
`define NopInst 16'b0000100000000000

//regs 
//R0-R7 000-111
`define RegNum 16
`define RegNumLog2 4
`define RegAddrBus `RegNumLog2-1:0
`define ZeroRegAddr `RegNumLog2'b0
//[REG_ADDR_R0 - REG_ADDR_R7] = 0000-0111
//REG_PC = 1000 is not in regfile

`define Reg0_Addr `RegNumLog2'b0000
`define Reg1_Addr `RegNumLog2'b0001
`define Reg2_Addr `RegNumLog2'b0010
`define Reg3_Addr `RegNumLog2'b0011
`define Reg4_Addr `RegNumLog2'b0100
`define Reg5_Addr `RegNumLog2'b0101
`define Reg6_Addr `RegNumLog2'b0110
`define Reg7_Addr `RegNumLog2'b0111
`define SP_Addr `RegNumLog2'b1000
`define PC_Addr `RegNumLog2'b1001
`define IH_Addr `RegNumLog2'b1010
`define T_Addr `RegNumLog2'b1011

//mem
`define MemRWBus 1:0
`define MemRWLength 2
`define MemRW_Idle	`MemRWLength'b00
`define MemRW_Read	`MemRWLength'b01
`define MemRW_Write	`MemRWLength'b10

//mem's ram
`define RamReadEnable 1'b1
`define RamReadDisable 1'b0
`define RamWriteEnable 1'b1
`define RamWriteDisable 1'b0
`define RamChipEnable 1'b1
`define RamChipDisable 1'b0
`define RamEnable 1'b0
`define RamDisable 1'b1

//ram
`define RamAddrBus   17:0
`define RamWEHigh 1'b1
`define RamWELow 1'b0

//ops id send to ex
`define AluOpBus 2:0
`define AluSelBus 2:0 
//nop
`define EXE_OP_NOP		3'b000
`define EXE_OP_INT		3'b001
//reg
`define EXE_OP_LI		3'b000
`define EXE_OP_MFIH		3'b001
`define EXE_OP_MFPC		3'b010
`define EXE_OP_MOVE		3'b011
`define EXE_OP_MTIH		3'b100
`define EXE_OP_MTSP		3'b101
//jump
`define EXE_OP_B		3'b000
`define EXE_OP_BEQZ		3'b001
`define EXE_OP_BNEZ		3'b010
`define EXE_OP_BTEQZ	3'b011
`define EXE_OP_JR		3'b100
//lw
`define EXE_OP_LW		3'b000
`define EXE_OP_LW_SP	3'b001
`define EXE_OP_SW		3'b010
`define EXE_OP_SW_SP	3'b011
`define EXE_OP_SW_OTHER	3'b111

//cmp
`define EXE_OP_CMP		3'b000
`define EXE_OP_CMPI		3'b001

//logic
`define EXE_OP_AND		3'b000
`define EXE_OP_NEG		3'b001
`define EXE_OP_OR		3'b010

//shift
`define EXE_OP_SLL		3'b000
`define EXE_OP_SLLV		3'b001
`define EXE_OP_SRA		3'b010
`define EXE_OP_SRL		3'b011

//arith
`define EXE_OP_SUBU		3'b000
`define EXE_OP_ADDIU	3'b001
`define EXE_OP_ADDIU3	3'b010
`define EXE_OP_ADDSP	3'b011
`define EXE_OP_ADDU		3'b100

//sels id send to ex
`define EXE_SEL_SPECIAL	3'b000
`define EXE_SEL_REG		3'b001
`define EXE_SEL_JUMP	3'b010
`define EXE_SEL_LW		3'b011
`define EXE_SEL_CMP		3'b100
`define EXE_SEL_LOGIC	3'b101
`define EXE_SEL_SHIFT	3'b110
`define EXE_SEL_ARITH	3'b111

//mips16 instrcution sets( split into op0123)
`define OP_ADDSP3	5'b00000
`define OP_NOP		5'b00001
`define OP_B		5'b00010
`define OP_BEQZ		5'b00100
`define OP_BNEZ		5'b00101
`define OP_SLL		5'b00110
`define OP_SRL 		5'b00110
`define OP_SRA		5'b00110
`define OP_ADDIU3	5'b01000
`define OP_ADDIU	5'b01001
`define OP_SLTI		5'b01010
`define OP_SLTUI	5'b01011
`define OP_BTEQZ	5'b01100
`define OP_BTNEZ	5'b01100
`define OP_SW_RS	5'b01100
`define OP_ADDSP	5'b01100
`define OP_MTSP		5'b01100
`define OP_LI		5'b01101
`define OP_CMPI		5'b01110
`define OP_MOVE		5'b01111
`define OP_LW_SP	5'b10010
`define OP_LW		5'b10011
`define OP_SW_SP	5'b11010
`define OP_SW		5'b11011
`define OP_ADDU		5'b11100
`define OP_SUBU		5'b11100
`define OP_JR		5'b11101
`define OP_JRRA		5'b11101
`define OP_MFPC		5'b11101
`define OP_JALR		5'b11101
`define OP_SLT		5'b11101
`define OP_SLTU		5'b11101
`define OP_SRLV		5'b11101
`define OP_SRAV		5'b11101
`define OP_CMP		5'b11101
`define OP_NEG		5'b11101
`define OP_AND		5'b11101
`define OP_OR		5'b11101
`define OP_NOT		5'b11101
`define OP_XOR		5'b11101
`define OP_MFIH		5'b11110
`define OP_MTIH		5'b11110
`define OP_INT		5'b11111

`define OP4_SLL 2'b00
`define OP4_SRL 2'b10
`define OP4_SRA 2'b11

`define OP1_BTEQZ	3'b000
`define OP1_BTNEZ	3'b001
`define OP1_SW_RS	3'b010
`define OP1_ADDSP	3'b011
`define OP1_MTSP	3'b100

`define OP4_ADDU 2'b01
`define OP4_SUBU 2'b11

`define OP2_JR 		3'b000
`define OP2_JRRA 	3'b001
`define OP2_MFPC	3'b010
`define OP2_JALR	3'b110

`define OP3_JR		5'b00000
`define OP3_SLT		5'b00010
`define OP3_SLTU	5'b00011
`define OP3_SLLV	5'b00100
`define OP3_SRLV	5'b00110
`define OP3_SRAV	5'b00111
`define OP3_CMP		5'b01010
`define OP3_NEG		5'b01011
`define OP3_AND		5'b01100
`define OP3_OR		5'b01101
`define OP3_NOT		5'b01111
`define OP3_XOR		5'b01110

`define OP3_MFIH	5'b00000
`define OP3_MTIH	5'b00001
