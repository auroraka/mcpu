-- mcpu,connect wire
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.PACK.ALL ;

entity mcpu is
	Port(
		rst: in STD_LOGIC ;
		clk: in STD_LOGIC ;
		stall: in STD_LOGIC ;
		id_pc_i: out InstAddrBus ;
		id_inst_i: out InstBus 
	) ;
end mcpu ;

architecture Behavioral of mcpu is
signal branchflag_o : STD_LOGIC := BranchFlagDown ;
signal branch_addr_o : InstAddrBus := ZeroInstAddr ;
signal pc : InstAddrBus := ZeroInstAddr ;
signal rom_inst_i : DataBus := ZeroData ;
component 

begin

end Behavioral ;