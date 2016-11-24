library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

entity ram1_ctrl is port(
	rst :       in STD_LOGIC;
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
	type STATUS is (PORT_READ, PORT_WRITE, PORT_CHECK, MEM_READ,MEM_WRITE, IDLE);
	signal state : STATUS := IDLE;
begin
	process (clk,rst,mem_addr_i,mem_data_i,mem_re,mem_we,mem_ce) begin
		if (rst = RstEnable) then
			state<=IDLE;
		else
			if (mem_ce = RamChipEnable) then
				if (mem_addr_i = "1011111100000000") then
					if (mem_re =  RamReadEnable) then
						state<=PORT_READ;
					elsif (mem_we = RamWriteEnable) then
						state<=PORT_WRITE;
					end if;
				elsif (mem_addr_i = "1011111100000001") then
					state<=PORT_CHECK;
				else 
					if (mem_re =  RamReadEnable) then
						state<=MEM_READ;
					elsif (mem_we = RamWriteEnable) then
						state<=MEM_WRITE;
					end if;
				end if;
			else 
				state<=IDLE;
			end if;	
		end if;
	end process;

	process(clk,rst,state,mem_addr_i,mem_data_i,mem_re,mem_we,mem_ce,ram_data_bi,ram_data_ready_i,ram_tsre_i,ram_tbre_i) begin
		if (rst = RstEnable) then
			mem_data_o<=ZeroData;
			ram_en_o<='1';
			ram_oe_o<='1';
			ram_we_o<='1';
			ram_wrn_o<='1';
			ram_rdn_o<='1';
		else
			case state is 
				when PORT_READ =>
					ram_data_bi<=HighImpWord;
					ram_en_o<='1';
					ram_oe_o<='1';
					ram_we_o<='1';
					ram_rdn_o<=clk;
					ram_wrn_o<='1';
				when PORT_WRITE =>
					ram_data_bi<=mem_data_i;
					ram_addr_o<="00" & ZeroData;
					ram_en_o<='1';
					ram_oe_o<='1';
					ram_we_o<='1';
					ram_rdn_o<='1';
					ram_wrn_o<=clk;
				when PORT_CHECK =>
					ram_data_bi <= "00000000000000" & ram_data_ready_i & (ram_tbre_i and ram_tsre_i);
					ram_addr_o <= "00" & ZeroData;
					ram_en_o<='1';
					ram_oe_o<='1';
					ram_we_o<='1';	
					ram_rdn_o<='1';
					ram_wrn_o<='1';
				when MEM_READ =>
					ram_data_bi<=HighImpWord;
					ram_addr_o<="00" & ZeroData;
					ram_en_o<='0';
					ram_oe_o<='1';
					ram_we_o<=clk;
					ram_rdn_o<='1';
					ram_wrn_o<='1';
				when MEM_WRITE =>
					ram_data_bi<=mem_data_i;
					ram_addr_o<="00" & mem_addr_i;
					ram_en_o<='0';
					ram_oe_o<='0';
					ram_we_o<='1';
					ram_rdn_o<='1';
					ram_wrn_o<='1';
				when IDLE =>
					ram_data_bi<=HighImpWord;
					ram_addr_o<="00" & ZeroData;
					ram_en_o<='1';
					ram_oe_o<='1';
					ram_we_o<='1';
					ram_rdn_o<='1';
					ram_wrn_o<='1';
				when others =>
					ram_data_bi<=HighImpWord;
					ram_addr_o<="00" & ZeroData;
					ram_en_o<='1';
					ram_oe_o<='1';
					ram_we_o<='1';
					ram_rdn_o<='1';
					ram_wrn_o<='1';				
			end case;
		end if;
	end process;
end Behavioral ;