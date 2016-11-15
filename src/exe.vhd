library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

entity exe is 
	Port(
		aluop_i : in EXE_OP ;
		alusel_i : in sel ;
		reg0_i : in DataBus ;
		reg1_i : in DataBus ;
		waddr_i : in RegAddrBus ;
		we_i : in STD_LOGIC ;
		stallreq : in STD_LOGIC ;
		
		aluop_o : out EXE_OP ;
		we_o : out STD_LOGIC ;
		waddr_o : out RegAddrBus ;
		wdata_o : out DataBus 
	) ;
end exe ;

architecture Behavioral of exe is
begin
	aluop_o <= aluop_i ;
	we_o <= we_i ;
	waddr_o <= waddr_i ;
	
	process(alusel_i, aluop_i, reg0_i, reg1_i, stallreq)
	--variable ans := DataBus := ZeroData ;
	begin 
		-- nop or int alu do nothing now
		if(stallreq = StallNo and alusel_i = EXE_SEL_SPECIAL) then
			null ;
		else 
			null ;
		end if ;
	end process ;
	
	process(alusel_i, aluop_i, reg0_i, reg1_i, stallreq) -- reg0_i(10:8), -- reg1_i(7:5)
	variable ans : DataBus := ZeroData ;
	begin
		if(stallreq = StallNo and alusel_i = EXE_SEL_REG) then
			case aluop_i is 
				when EXE_OP_LI =>
					ans := reg0_i ;
				when EXE_OP_MFIH =>
					ans := reg0_i ;
				when EXE_OP_MFPC =>
					ans := reg0_i ;
				when EXE_OP_MOVE =>
					ans := reg1_i ;
				when EXE_OP_MTIH =>
					ans := reg0_i ;
				when EXE_OP_MTSP =>
					ans := reg1_i ;
				when others =>null ;
			end case ;
			wdata_o <= ans ;
		else
			null ;
		end if ;
	end process ;
	
	process(alusel_i, aluop_i, reg0_i, reg1_i, stallreq) -- when jump finish in ID and exe do nothing
	variable ans : DataBus := ZeroData ;
	begin
		if(stallreq = StallNo and alusel_i = EXE_SEL_JUMP) then
			null ;
		else 
			null ;
		end if ;
	end process ;
	
	process(alusel_i, aluop_i, reg0_i, reg1_i, stallreq)
	variable ans : DataBus := ZeroData ;
	begin
		if(stallreq = StallNo and alusel_i = EXE_SEL_ARITH) then
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
			wdata_o <= ans ;
		else
			null ;
		end if ;
	end process ;
	
	process(alusel_i, aluop_i, reg0_i, reg1_i, stallreq)
	variable ans : DataBus := ZeroData ;
	--variable shift_num : DataBus := ZeroData ;
	begin
		if(stallreq = StallNo and alusel_i = EXE_SEL_SHIFT) then
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
			wdata_o <= ans ;
		else
			null ;
		end if ;
	end process ;
	
	process(alusel_i, aluop_i, reg0_i, reg1_i, stallreq)
	variable ans : DataBus := ZeroData ;
	begin
		if(stallreq = StallNo and alusel_i = EXE_SEL_LOGIC) then
			case aluop_i is 
				when EXE_OP_AND =>
					ans := reg0_i and reg1_i ;
				when EXE_OP_NEG =>
					ans := ZeroData - reg1_i ;
				when EXE_OP_OR =>
					ans := reg0_i or reg1_i ;
				when others =>
					null ;
			end case ;
			wdata_o <= ans ;
		else
			null ;
		end if ;
	end process ;
	
	process(alusel_i, aluop_i, reg0_i, reg1_i, stallreq)
	variable ans : DataBus := ZeroData ;
	begin
		if(stallreq = StallNo and alusel_i = EXE_SEL_CMP) then
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
			wdata_o <= ans ;
		else
			null ;
		end if ;
	end process ;
	
	process(alusel_i, aluop_i, reg0_i, reg1_i, stallreq)
	variable ans : DataBus := ZeroData ;
	begin
		if(stallreq = StallNo and alusel_i = EXE_SEL_LW) then
			case aluop_i is
				when EXE_OP_LW =>
					ans := reg0_i + reg1_i ;
				when EXE_OP_LW_SP =>
					ans := reg0_i + reg1_i ;
				when EXE_OP_SW =>
					ans := reg0_i + reg1_i ;
				when EXE_OP_SW_SP => 
					ans := reg0_i + reg1_i ;
				when others =>
					null ;
			end case ;
			wdata_o <= ans ;
		else
			null ;
		end if ;
	end process ;
	
end Behavioral ;