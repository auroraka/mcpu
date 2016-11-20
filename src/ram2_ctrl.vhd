library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

entity ram2_ctrl is port(
		--pc
		pc_addr : 	in 	DataAddrBus ;
		pc_ce : 	in 	STD_LOGIC ;
		inst:		out InstBus ;
		--mem
		ram_data_i : 	inout 	DataBus ;
		ram_re_o :		in STD_LOGIC ;
		ram_we_o :		in STD_LOGIC ;
		ram_addr_o : 	in DataAddrBus ;
		ram_ce_o :		in STD_LOGIC
	) ;
end ram2_ctrl ;

architecture Behavioral of ram2_ctrl is
begin
	
end Behavioral ;