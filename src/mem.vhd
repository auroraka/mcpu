library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

entity mem is port(
		we_i : 		in STD_LOGIC ;
		wdata_i : 	in DataBus ;
		waddr_i : 	in RegAddrBus ;
		memaddr_i : in DataAddress ;
		memrw_i : 	in MemRWBus ;

		ram_data_i : 	in DataBus ;
		rst : 		in STD_LOGIC ;

		we_o : 		out STD_LOGIC ;
		waddr_o : 	out RegAddrBus ;
		wdata_o : 	out DataBus ;

		ram_re_o :		out STD_LOGIC ;
		ram_we_o :		out STD_LOGIC ;
		ram_addr_o : 	out DataAddress ;
		ram_data_o : 	out DataBus ;
		ram_ce_o :		out STD_LOGIC ;

		stall_req : out STD_LOGIC
	) ;
end mem ;

architecture Behavioral of mem is
begin
	--aluop_o <= aluop_i ;
	we_o <= we_i ;
	waddr_o <= waddr_i ;
	--wdata_o <= ZeroData ;
	ram_addr_o <= memaddr_i;
	
	case memrw_i is
		when MemRW_Idle =>
			ram_re_o <= RamReadDisable;
			ram_we_o <= RamWriteDisable;
			ram_ce_o <= RamChipDisable;
		when MemRW_Read =>
			ram_ce_o <= RamChipEnable;
			ram_re_o <= RamReadEnable;
			ram_we_o <= RamWriteDisable;
			ram_data_o <= HighImpWord;
		when MemRW_Write =>
			ram_ce_o <= RamChipEnable;
			ram_re_o <= RamReadDisable;
			ram_we_o <= RamWriteEnable;
			ram_data_o <= wdata_i;
		when others =>
	end case;
	
	we_o <= we_i;
	waddr_o <= waddr_i;
	case memrw_i is
		when MemRW_Read =>
			wdata_o <= ram_data_i;
		when others =>
			wdata_o <= wdata_i;
	end case;
--stall_req
	stall_req <= StallNo;
end Behavioral ;