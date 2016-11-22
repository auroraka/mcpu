library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

entity mem is port(
		rst : 		in STD_LOGIC ;
		clk : 		in STD_LOGIC ;
		--寄存
		we_i : 		in STD_LOGIC ;
		waddr_i : 	in RegAddrBus ;
		wdata_i : 	in DataBus ;
		--ram
		memdata_i : in DataBus ;
		memrw_i : 	in MemRWBus ; 
		memaddr_i : in DataAddrBus ;

		we_o : 		out STD_LOGIC ;
		waddr_o : 	out RegAddrBus ;
		wdata_o : 	out DataBus ;
		
		--ram 1 
		ram1_data_i:	in 	DataBus ;
		ram1_data_o : 	out DataBus ;
		ram1_addr_o : 	out DataAddrBus ;
		ram1_re_o :		out STD_LOGIC ;
		ram1_we_o :		out STD_LOGIC ;
		ram1_ce_o :		out STD_LOGIC; -- ce = ChipEnable -> 
		
		--ram 2 
		ram2_data_i:	in 	DataBus ;
		ram2_data_o : 	out DataBus ;
		ram2_addr_o : 	out DataAddrBus ;
		ram2_re_o :		out STD_LOGIC ;
		ram2_we_o :		out STD_LOGIC ;
		ram2_ce_o :		out STD_LOGIC; -- ce = RamChipEnable -> Ram Read    &    ce = RamChipDisable ->  PC Read

		--stall_reg
		stall_req : out STD_LOGIC 
	) ;
end mem ;

architecture Behavioral of mem is
begin
	ram_out: process(memdata_i,memaddr_i,memrw_i,rst)
	begin
		if(rst = RstEnable)then
			ram1_ce_o <= RamChipDisable;
			ram1_we_o <= RamWriteDisable;
			ram1_re_o <= RamReadDisable;
			ram1_addr_o <= ZeroWord;
			ram1_data_o <= ZeroWord;
			ram2_ce_o <= RamChipDisable;
			ram2_we_o <= RamWriteDisable;
			ram2_re_o <= RamReadDisable;
			ram2_addr_o <= ZeroWord;
			ram2_data_o <= ZeroWord;
		else
			if(memaddr_i(15)='0')then -- ram2
				ram2_we_o<=memrw_i(1);
				ram2_re_o<=memrw_i(0);
				ram2_ce_o<=memrw_i(1) or memrw_i(0);
				ram1_we_o<='0';
				ram1_re_o<='0';
				ram1_ce_o<='0';
			else
				ram1_we_o<=memrw_i(1);
				ram1_re_o<=memrw_i(0);
				ram1_ce_o<=memrw_i(1) or memrw_i(0);
				ram2_we_o<='0';
				ram2_re_o<='0';
				ram2_ce_o<='0';
			end if;
			ram1_addr_o <= memaddr_i;
			ram2_addr_o <= memaddr_i;
			ram1_data_o <= memdata_i;
			ram2_data_o <= memdata_i;
		end if;
	end process;
	
	stall: process(memdata_i,memaddr_i,memrw_i,rst)
	begin
		if(rst = RstEnable or memrw_i = MemRW_Idle or memaddr_i(15)='1')then -- ram1
			stall_req <= StallNo;
		else
			stall_req <= StallYes;
		end if;
	end process;

	we_o <= we_i;
	waddr_o <= waddr_i;
	wdata: process(ram1_data_i,ram2_data_i,rst)
	begin
		if(rst = RstEnable)then
			wdata_o <= ZeroWord;
		else
			case memrw_i is
				when MemRW_Read =>
					if(memaddr_i(15)='0')then -- ram2
						wdata_o <= ram2_data_i;
					else
						wdata_o <= ram1_data_i;
					end if;
				when others =>
					wdata_o <= wdata_i;
			end case;
		end if;
	end process;

end Behavioral ;