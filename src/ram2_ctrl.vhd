library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

entity ram2_ctrl is port(
	clk :		in	STD_LOGIC;
	--pc
	pc_addr : 	in 	DataAddrBus ;
	inst:		out InstBus ;
	--mem
	mem_data_i : 	in 	DataBus ;
	mem_data_o : 	out DataBus ;
	mem_addr : 		in 	DataAddrBus ;
	mem_re :		in 	STD_LOGIC ;
	mem_we :		in 	STD_LOGIC ;
	mem_ce :		in 	STD_LOGIC 
	-- --ram
	-- ram_data : 		inout 	DataBus ;
	-- ram_addr_o : 	out 	RamAddrBus ;
	-- ram_oe_o :		out 	STD_LOGIC ;
	-- ram_we_o :		out 	STD_LOGIC ;
	-- ram_en_o :		out 	STD_LOGIC 	
	) ;
end ram2_ctrl ;

architecture Behavioral of ram2_ctrl is
	 signal tempRamAddr: STD_LOGIC_VECTOR(17 downto 0) := "000000000000000000";
begin
	ram_we_o <= not mem_we or clk;
	ram_oe_o <= '0' ;
	ram_en_o <= RamEnable;
	ram_addr_o <= tempRamAddr;
	mem_data_o <= ram_data;
	inst <= ram_data;
	process(mem_ce,mem_we,mem_re,pc_addr,mem_addr,mem_data_i)
	begin
		if mem_ce = RamChipEnable then
			tempRamAddr(15 downto 0) <= mem_addr;
		else
			tempRamAddr(15 downto 0) <= pc_addr;
		end if;

		if mem_ce = RamChipEnable and mem_we = RamWriteEnable then
			ram_data <= mem_data_i;
		else
			ram_data <= HighImpWord;
		end if;
	end process;
end Behavioral ;