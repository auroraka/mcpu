library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

entity mem is port(
		--寄存器
		we_i : 		in STD_LOGIC ;
		waddr_i : 	in RegAddrBus ;
		--数据
		wdata_i : 	in DataBus ;
		--ram
		memrw_i : 	in MemRWBus ; 
		memaddr_i : in DataAddrBus ;
		rst : 		in STD_LOGIC ;

		we_o : 		out STD_LOGIC ;
		waddr_o : 	out RegAddrBus ;
		wdata_o : 	out DataBus ;
		stall_req : out STD_LOGIC
		--ram 2
		ram2_data_i : 	inout DataBus ;
		ram2_re_o :		out STD_LOGIC ;
		ram2_we_o :		out STD_LOGIC ;
		ram2_addr_o : 	out DataAddrBus ;
		ram2_data_o : 	out DataBus ;
		ram2_ce_o :		out STD_LOGIC;
		--ram 1
		ram1_data_i : 	inout DataBus ;
		ram1_re_o :		out STD_LOGIC ;
		ram1_we_o :		out STD_LOGIC ;
		ram1_addr_o : 	out DataAddrBus ;
		ram1_data_o : 	out DataBus ;
		ram1_ce_o :		out STD_LOGIC	
	) ;
end mem ;

architecture Behavioral of mem is
begin
	ram_addr_o <= memaddr_i;
	ram: process
	begin
		if(rst = RstEnable)then
			ram1_ce_o <= RamChipDisable;
			ram1_we_o <= RamWriteDisable;
			ram1_re_o <= RamReadDisable;
			ram1_data_o <= ZeroWord;
			ram2_ce_o <= RamChipDisable;
			ram2_we_o <= RamWriteDisable;
			ram2_re_o <= RamReadDisable;
			ram2_data_o <= ZeroWord;
		else
			case memrw_i is
				when MemRW_Idle =>
					ram_re_o <= RamReadDisable;
					ram_we_o <= RamWriteDisable;
					ram_ce_o <= RamChipDisable;
					ram_data_o <= wdata_i;--这里什么都ok
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
		end if;
	end process;
	
	we_o <= we_i;
	waddr_o <= waddr_i;
	wdata: process
	begin
		if(rst = RstEnable)then
			wdata_o <= ZeroWord;
		else
			case memrw_i is
				when MemRW_Read =>
					wdata_o <= ram_data_i;
				when others =>
					wdata_o <= wdata_i;
			end case;
		end if;
	end process;
--stall_req
	stall_req <= StallNo;
end Behavioral ;