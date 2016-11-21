library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library WORK;
use WORK.PACK.ALL ;

entity if_id is
	Port(
		rst : in STD_LOGIC ;
		clk : in STD_LOGIC ;
		stall_pc : in STD_LOGIC ;
		stall_id: in STD_LOGIC ;
		stall_ex : in STD_LOGIC ;
		--stall_mem: in STD_LOGIC ;
		if_pc: in InstAddrBus ;
		if_inst: in InstBus ;
		
		id_pc: out InstAddrBus ;
		id_inst: out InstBus 
	) ;
end if_id ;

architecture Behavioral of if_id is
begin
	process(clk, rst)
	variable tmp_pc : InstAddrBus := ZeroInstAddr ;
	variable tmp_inst : InstBus := ZeroInst ;
	begin
		if(rst = RstEnable) then
			tmp_pc := ZeroInstAddr ;
			tmp_inst := ZeroInst ;
			id_pc <= tmp_pc ;
			id_inst <= tmp_inst ;
		elsif(clk'event and clk = '1') then
			if(stall_id = StallYes) then -- load add confilct
				id_pc <= tmp_pc ;
				id_inst <= tmp_inst ; -- hold the origial inst ;
			elsif(stall_pc = StallYes) then -- pc mem confilct
				id_pc <= if_pc ;
				id_inst <= NopInst ; -- insert a nop ;
			else -- narmal flow
				tmp_pc := if_pc ;
				tmp_inst := if_inst ;
				id_pc <= tmp_pc ;
				id_inst <= tmp_inst ;
			end if ;
		end if ;
	end process ;
end Behavioral ;
