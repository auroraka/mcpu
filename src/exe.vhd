library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

entity exe is 
	Port(
		aluop_i : in AluOpBus ;
		alusel_i : in AluSelBus ;
		reg0_i : in DataBus ;
		reg1_i : in DataBus ;
		waddr_i : in RegAddrBus ;
		we_i : in STD_LOGIC ;
		--stallreq : in STD_LOGIC ;
		rst : in STD_LOGIC ;
		
		--aluop_o : out EXE_OP ;
		memrw_o : out MemRWBus ;
		memaddr_o : out DataAddrBus ;
		we_o : out STD_LOGIC ;
		waddr_o : out RegAddrBus ;
		stallreq: out STD_LOGIC ;
		wdata_o : out DataBus 
	) ;
end exe ;

architecture Behavioral of exe is
begin
	--aluop_o <= aluop_i ;
	we_o <= we_i ;
	waddr_o <= waddr_i ;
	--wdata_o <= ZeroData ;
	
	process(alusel_i, aluop_i, reg0_i, reg1_i, stallreq, rst)
	variable ans : DataBus := ZeroData ;
	variable rw : MemRWBus := MemRW_Idle ;
	variable memaddr : DataAddrBus := ZeroDataAddr ;
	variable stall : STD_LOGIC := StallNo ;
	begin
		ans := ZeroData ;
		rw := MemRW_Idle ;
		memaddr := ZeroDataAddr ;
		if(rst = RstDisable) then
			case alusel_i is 
				when EXE_SEL_ARITH =>
					case aluop_i is
						when EXE_OP_SUBU =>
							ans := reg0_i - reg1_i ;
						when EXE_OP_ADDIU =>
							ans := reg0_i + reg1_i ;
						when EXE_OP_ADDIU3 =>
							ans := reg0_i + reg1_i ;
						when EXE_OP_ADDSP =>
							ans := reg0_i + reg1_i ;
						when EXE_OP_ADDU =>
							ans := reg0_i + reg1_i ;
						when others =>
							null ;
					end case ;
				when EXE_SEL_LOGIC =>
					case aluop_i is 
						when EXE_OP_AND =>
							ans := reg0_i and reg1_i ;
						when EXE_OP_NEG =>
							ans := ZeroData - reg0_i ;
						when EXE_OP_OR =>
							ans := reg0_i or reg1_i ;
						when others =>
							null ;
					end case ;
				when EXE_SEL_CMP =>
					case aluop_i is
						when EXE_OP_CMP =>
							if(reg0_i = reg1_i) then
								ans := ZeroData ;
							else
								ans := "0000000000000001" ;
							end if ;
						when EXE_OP_CMPI =>
							if(reg0_i = reg1_i) then
								ans := ZeroData ;
							else
								ans := "0000000000000001" ;
							end if ;
						when others =>
							null ;
					end case ;
				when EXE_SEL_SHIFT =>
					case aluop_i is 
						when EXE_OP_SLL =>
							if(reg1_i = ZeroData) then
								ans := to_stdlogicvector(TO_BITVECTOR(reg0_i) sll 8) ;
							else
								ans := to_stdlogicvector(TO_BITVECTOR(reg0_i) sll CONV_INTEGER(reg1_i)) ;
							end if ;
						when EXE_OP_SLLV =>
							ans := to_stdlogicvector(TO_BITVECTOR(reg1_i) sll CONV_INTEGER(reg0_i)) ;
						when EXE_OP_SRA =>
							if(reg1_i = ZeroData) then
								ans := to_stdlogicvector(TO_BITVECTOR(reg0_i) sra 8) ;
							else
								ans := to_stdlogicvector(TO_BITVECTOR(reg0_i) sra CONV_INTEGER(reg1_i)) ;
							end if ;
						when EXE_OP_SRL =>
							if(reg1_i = ZeroData) then
								ans := to_stdlogicvector(TO_BITVECTOR(reg0_i) srl 8) ;
							else
								ans := to_stdlogicvector(TO_BITVECTOR(reg0_i) srl CONV_INTEGER(reg1_i)) ;
							end if ;
						when others => 
							null ;
					end case ;
				when EXE_SEL_REG =>
					case aluop_i is 
						when EXE_OP_LI =>
							ans := reg0_i ;
						when EXE_OP_MFIH =>
							ans := reg0_i ;
						when EXE_OP_MFPC =>
							ans := reg0_i ;
						when EXE_OP_MOVE =>
							ans := reg0_i ;
						when EXE_OP_MTIH =>
							ans := reg0_i ;
						when EXE_OP_MTSP =>
							ans := reg0_i ;
						when others =>null ;
					end case ;
				when EXE_SEL_LW =>
					case aluop_i is
						when EXE_OP_LW =>
							memaddr := reg0_i + reg1_i ;
							rw := MemRW_Read ;
						when EXE_OP_LW_SP =>
							memaddr := reg0_i + reg1_i ;
							rw := MemRW_Read ;
						when EXE_OP_SW =>
							memaddr := reg0_i + reg1_i ;
							rw := MemRW_Write ;
						when EXE_OP_SW_SP => 
							memaddr := reg0_i + reg1_i ;
							rw := MemRW_Write ;
						when others =>
							null ;
					end case ;
				when others => null ; -- jump, and special ,alu do nothing
			end case ;
		else
			null ;
		end if ;
		wdata_o <= ans ;
		memaddr_o <= memaddr ;
		memrw_o <= rw ;
		stallreq <= stall ;
	end process ;
		
end Behavioral ;