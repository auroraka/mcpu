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
	ram_addr_o			: 	out RamAddrBus;
	ram_wrn_o			:	out STD_LOGIC;
	ram_rdn_o			:	out STD_LOGIC
	) ;
end ram1_ctrl ;

architecture Behavioral of ram1_ctrl is
	signal flag: STD_LOGIC :='0';
	signal data_flag: DataBus := (others => '0');
	signal tempRamData: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin
	ram_addr_o(17 downto 16)<="00";
	process(mem_addr_i)
	begin
		if(mem_addr_i = "1011111100000000")then
			flag<='1';
		else
			flag<='0';
		end if;
	end process;
	ram_rdn_o<= not (flag and mem_re and not clk);
	ram_wrn_o<= not (flag and mem_we and not clk);
	ram_we_o<= not mem_we or clk or flag;
	mem_data_o<= (not data_flag or ram_data_bi) and (data_flag or tempRamData);
	process(mem_ce,mem_we,mem_re,mem_addr_i,mem_data_i)
	begin
		if mem_ce = RamChipDisable then
			tempRamData<=ZeroData;
			ram_data_bi<=ZeroData;
			data_flag<=ZeroData;
			--据说应该改一下
			ram_oe_o<='1';
			ram_en_o<=RamDisable;
		else
			if (mem_re = RamReadEnable) then
				if (mem_addr_i = "1011111100000001") then --0xBF01
					ram_oe_o<='1';
					ram_en_o<=RamDisable;
					ram_data_bi<=ZeroData;
					tempRamData<="00000000000000" & ram_data_ready_i & ram_tsre_i;
					data_flag<=ZeroData;
				elsif (flag = '1') then --0xBF00
					ram_oe_o<='1';
					ram_en_o<=RamDisable;
					ram_data_bi<=HighImpWord;
					data_flag<=(others => '1');
				else -- ram Read
					ram_en_o<=RamEnable;
					ram_oe_o<='0';
					ram_addr_o(15 downto 0)<=mem_addr_i;
					ram_data_bi<=HighImpWord;
					data_flag<=(others => '1');
				end if;	
			elsif (mem_we = RamWriteEnable) then 
				if (mem_addr_i = "1011111100000001") then --0xBF01
					-- not enable to write 0xBF01
					ram_data_bi<=ZeroData;
					data_flag<=ZeroData;
				elsif (flag = '1') then --0xBF00
					ram_en_o<=RamDisable;
					ram_oe_o<='1';
					ram_data_bi<=mem_data_i;
					ram_addr_o(15 downto 0)<=mem_addr_i;
					data_flag<=ZeroData;
				else -- ram write
					ram_en_o<=RamEnable;
					ram_oe_o<='0';
					ram_addr_o(15 downto 0)<=mem_addr_i;
					ram_data_bi<=mem_data_i;
					data_flag<=ZeroData;
				end if;
			else
				tempRamData<=ZeroData;
				data_flag<=ZeroData;
				ram_data_bi<=ZeroData;
				--据说应该改一下
				ram_oe_o<='1';
				ram_en_o<=RamDisable;
			end if ;
		end if;
	end process;
end Behavioral ;