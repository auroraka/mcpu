library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.PACK.ALL ;

entity RegisterFile is
	Port(
		re_0 : in STD_LOGIC ;
		re_1 : in STD_LOGIC ;
		raddr0 : in RegAddrBus ;
		raddr1 : in RegAddrBus ;
		we : in STD_LOGIC ;
		waddr : in RegAddrBus ;
		wdata : in DataBus ;
		--aluop : in EXE_OP ;
		
		rdata0 : out DataBus ;
		rdata1 : out DataBus 
	) ;
end RegisterFile ;

architecture Behavioral of RegisterFile is
-- initial all zero?or Z ? or X ?
signal R0 : DataBus := ZeroData ;
signal R1 : DataBus := ZeroData ;
signal R2 : DataBus := ZeroData ;
signal R3 : DataBus := ZeroData ;
signal R4 : DataBus := ZeroData ;
signal R5 : DataBus := ZeroData ;
signal R6 : DataBus := ZeroData ;
signal R7 : DataBus := ZeroData ;
signal SP : DataBus := ZeroData ;
signal IH : DataBus := ZeroData ;
signal T : DataBus := ZeroData ;

begin
	process(re_0, re_1, raddr0, raddr1) -- read register
	variable tmp0 : DataBus := ZeroData ;
	variable tmp1 : DataBus := ZeroData ;
	begin
		
		if(re_0 = ReadEnable) then
			case raddr0 is
				when Reg0_Addr => tmp0 := R0 ;
				when Reg1_Addr => tmp0 := R1 ;
				when Reg2_Addr => tmp0 := R2 ;
				when Reg3_Addr => tmp0 := R3 ;
				when Reg4_Addr => tmp0 := R4 ;
				when Reg5_Addr => tmp0 := R5 ;
				when Reg6_Addr => tmp0 := R6 ;
				when Reg7_Addr => tmp0 := R7 ;
				when SP_Addr => tmp0 := SP ;
				when IH_Addr => tmp0 := IH ;
				when T_Addr => tmp0 := T ;
				when others => null ;
			end case ;
		end if ;
		if(re_1 = ReadEnable) then
			case raddr1 is
				when Reg0_Addr => tmp1 := R0 ;
				when Reg1_Addr => tmp1 := R1 ;
				when Reg2_Addr => tmp1 := R2 ;
				when Reg3_Addr => tmp1 := R3 ;
				when Reg4_Addr => tmp1 := R4 ;
				when Reg5_Addr => tmp1 := R5 ;
				when Reg6_Addr => tmp1 := R6 ;
				when Reg7_Addr => tmp1 := R7 ;
				when SP_Addr => tmp1 := SP ;
				when IH_Addr => tmp1 := IH ;
				when T_Addr => tmp1 := T ;
				when others => null ;
			end case ;
		end if ;
		rdata0 <= tmp0 ;
		rdata1 <= tmp1 ;
	end process ;
	
	process(we, waddr, wdata)
	begin
		if(we = WriteEnable) then
			case waddr is 
				when Reg0_Addr => R0 <= wdata ;
				when Reg1_Addr => R1 <= wdata ;
				when Reg2_Addr => R2 <= wdata ;
				when Reg3_Addr => R3 <= wdata ;
				when Reg4_Addr => R4 <= wdata ;
				when Reg5_Addr => R5 <= wdata ;
				when Reg6_Addr => R6 <= wdata ;
				when Reg7_Addr => R7 <= wdata ;
				when SP_Addr => SP <= wdata ;
				when IH_Addr => IH <= wdata ;
				when T_Addr => T <= wdata ;
				when others => null ;
			end case ;
		else
			null ;
		end if ;
	end process ;
end Behavioral ;