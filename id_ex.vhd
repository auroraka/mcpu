library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library WORK;
use WORK.PACK.ALL ;

entity id_ex is 
	Port(
		rst : in STD_LOGIC ;
		clk : in STD_LOGIC ;
		stall_pc : in STD_LOGIC ;
		stall_id : in STD_LOGIC ;
		stall_ex : in STD_LOGIC ;
		id_aluop : in AluOpBus ;
		id_alusel : in AluSelBus ;
		id_reg0 : in DataBus ;
		id_reg1 : in DataBus ;
		id_waddr : in RegAddrBus ;
		id_we : in STD_LOGIC ;
		
		ex_aluop : out AluOpBus ;
		ex_alusel : out AluSelBus ;
		ex_reg0 : out DataBus ;
		ex_reg1 : out DataBus ;
		ex_waddr : out RegAddrBus ;
		ex_we : out STD_LOGIC 
	) ;
end id_ex ;

architecture Behavioral of id_ex is
begin
	process(clk, rst)
	begin
		if(rst = RstEnable) then -- 异步清零，因为不会用verilog的异步清零,所以改成vhdl了
		
			ex_alusel <= EXE_SEL_SPECIAL ;
			ex_aluop <= EXE_OP_NOP ;
			ex_reg0 <= ZeroData ;
			ex_reg1 <= ZeroData ;
			ex_waddr <= ZeroRegAddr ;
			ex_we <= WriteDisable ;
		elsif(clk'event and clk = '1') then
			if(stall_ex = StallYes) then -- int stall, ex run
				ex_alusel <= id_alusel ;
				ex_aluop <= id_aluop ;
				ex_reg0 <= id_reg0 ;
				ex_reg1 <= if_reg1 ;
				ex_waddr <= id_waddr ;
				ex_we <= id_we ;
			elsif(stall_id = StallYes) then -- load add conflict, insert a nop in exe
				ex_alusel <= EXE_SEL_SPECIAL ;
				ex_aluop <= EXE_OP_NOP ;
				ex_reg0 <= ZeroData ;
				ex_reg1 <= ZeroData ;
				ex_waddr <= ZeroRegAddr ;
				ex_we <= WriteDisable ;
			else
				ex_alusel <= id_alusel ;
				ex_aluop <= id_aluop ;
				ex_reg0 <= id_reg0 ;
				ex_reg1 <= id_reg1 ;
				ex_waddr <= id_waddr ;
				ex_we <= id_we ;
			end if ;
		end if ;
	end process ;
end Behavioral ;
