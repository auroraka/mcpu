library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

entity mem is port(
		--寄存�
		we_i : 		in STD_LOGIC ;
		waddr_i : 	in RegAddrBus ;
		wdata_i : 	in DataBus ;
		--ram
		memdata_i : in DataBus ;
		memrw_i : 	in MemRWBus ; 
		memaddr_i : in DataAddrBus ;
		rst : 		in STD_LOGIC ;

		we_o : 		out STD_LOGIC ;
		waddr_o : 	out RegAddrBus ;
		wdata_o : 	out DataBus ;
		stall_req : out STD_LOGIC ;
		--ram 2
		ram2_data : 	inout DataBus ;
		ram2_re_o :		out STD_LOGIC ;
		ram2_we_o :		out STD_LOGIC ;
		ram2_addr_o : 	out DataAddrBus ;
		ram2_ce_o :		out STD_LOGIC;
		--ram 1
		ram1_data : 	inout DataBus ;
		ram1_re_o :		out STD_LOGIC ;
		ram1_we_o :		out STD_LOGIC ;
		ram1_addr_o : 	out DataAddrBus ;
		ram1_ce_o :		out STD_LOGIC	
	) ;
end mem ;

architecture Behavioral of mem is
begin
	ram: process(memdata_i,memaddr_i,memrw_i,rst)
	begin
		if(rst = RstEnable)then
			ram1_ce_o <= RamChipDisable;
			ram1_we_o <= RamWriteDisable;
			ram1_re_o <= RamReadDisable;
			ram1_addr_o <= ZeroWord;
			ram1_data <= ZeroWord;
			ram2_ce_o <= RamChipDisable;
			ram2_we_o <= RamWriteDisable;
			ram2_re_o <= RamReadDisable;
			ram2_addr_o <= ZeroWord;
			ram2_data <= ZeroWord;
		else
			ram1_re_o <= RamReadDisable;
			ram1_we_o <= RamWriteDisable;
			ram1_addr_o <= memaddr_i;
			ram2_re_o <= RamReadDisable;
			ram2_we_o <= RamWriteDisable;
			ram2_addr_o <= memaddr_i;
			case memrw_i is
				when MemRW_Idle =>
					ram1_ce_o <= RamChipDisable;
					ram2_ce_o <= RamChipDisable;
				when MemRW_Read =>
					ram1_data <= HighImpWord;
					ram2_data <= HighImpWord;
					if(memaddr_i<="0111111111111111")then
						ram2_ce_o <= RamChipEnable;
						ram2_re_o <= RamReadEnable;
						ram1_ce_o <= RamChipDisable;
					else
						ram1_ce_o <= RamChipEnable;
						ram1_re_o <= RamReadEnable;
						ram2_ce_o <= RamChipDisable;
					end if;
				when MemRW_Write =>
					ram1_data <= memdata_i;
					ram2_data <= memdata_i;
					if(memaddr_i<="0111111111111111")then
						ram2_ce_o <= RamChipEnable;
						ram2_we_o <= RamWriteEnable;
						ram1_ce_o <= RamChipDisable;
					else
						ram1_ce_o <= RamChipEnable;
						ram1_we_o <= RamWriteEnable;
						ram2_ce_o <= RamChipDisable;
					end if;
				when others =>
			end case;
		end if;
	end process;
	
	stall: process(memdata_i,memaddr_i,memrw_i,rst)
	begin
		if(rst = RstEnable or memrw_i = MemRW_Idle)then
			stall <= StallNo;
		elsif(memrw_i = MemRW_Read or memrw_i = MemRW_Write)then
			if(memaddr_i<="0111111111111111")then
				stall <= StallYes;
			else
				stall <= StallNo;
			end if;
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

end Behavioral ;