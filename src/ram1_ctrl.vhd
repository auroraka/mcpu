library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

entity ram1_ctrl is port(
	clk :		in	STD_LOGIC;
	--mem
	mem_data_i : 	in 	DataBus ;
	mem_data_o : 	out DataBus ;
	mem_addr_i : 	in 	DataAddrBus ;
	mem_re :		in 	STD_LOGIC ;
	mem_we :		in 	STD_LOGIC ;
	mem_ce :		in 	STD_LOGIC ;

	--ram
	ram_data_ready_i	:	in STD_LOGIC;
	ram_tbre_i			:	in STD_LOGIC;
	ram_tsre_i			:	in STD_LOGIC;
	ram_data_bi			:	inout DataBus;

	ram_oe_o			:	out STD_LOGIC;
	ram_en_o			:	out STD_LOGIC;
	ram_we_o			:	out STD_LOGIC;
	ram_addr_o			: 	out DataAddrBus;
	ram_wrn_o			:	out STD_LOGIC;
	ram_rdn_o			:	out STD_LOGIC
	) ;
end ram1_ctrl ;

architecture Behavioral of ram1_ctrl is
begin
	process(mem_ce,mem_we,mem_re,mem_addr_i,mem_data_i)
	variable tempRamData: STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
	begin
		if mem_ce = RamChipDisable then
			tempRamData:=ZeroData;
			ram_data_bi<=HighImpWord;
			mem_data_o <= tempRamData;
		else
			if (mem_re = ReadEnable) then
				if (mem_data_i = "1011111100000001") then --0xBF01
					ram_oe_o<='1';
					ram_en_o<='1';
					ram_we_o<='1';
					ram_data_bi<=HighImpWord;
					tempRamData:="00000000000000" & ram_data_ready_i & ram_tsre_i;
					mem_data_o <= tempRamData;
				elsif (mem_data_i = "1011111100000001") then --0xBF00
					ram_oe_o<='1';
					ram_en_o<='1';
					ram_we_o<='1';
					ram_rdn_o<=clk;
					ram_data_bi<=HighImpWord;
					mem_data_o <= ram_data_bi;
				else -- ram Read
					ram_en_o<='0';
					ram_oe_o<='0';
					ram_we_o<='1';
					ram_addr_o<=mem_addr_i;
					ram_data_bi<=HighImpWord;
					mem_data_o <= ram_data_bi;	
				end if;	
			elsif (mem_we = WriteEnable) then 
				if (mem_data_i = "1011111100000001") then --0xBF01
					-- not enable to write 0xBF01
					ram_data_bi<=HighImpWord;
				elsif (mem_data_i = "1011111100000001") then --0xBF00
					ram_en_o<='1';
					ram_oe_o<='1';
					ram_we_o<='1';
					ram_wrn_o<=clk;
					ram_data_bi<=mem_data_i;
					ram_addr_o<=mem_addr_i;
				else -- ram Read
					ram_en_o<='0';
					ram_oe_o<='0';
					ram_we_o<=clk;
					ram_addr_o<=mem_addr_i;
					ram_data_bi<=mem_data_i;
				end if;					
			else
				tempRamData:=ZeroData;
				mem_data_o<=tempRamData;
			end if ;
		end if;

	end process;
end Behavioral ;