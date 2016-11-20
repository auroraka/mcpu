library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

ENTITY ram2_tb IS
END ram2_tb;
architecture Behavioral of ram2_tb is
component ram2_ctrl
port(
	--pc
	pc_addr : 	in 	DataAddrBus ;
	pc_ce : 	in 	STD_LOGIC ;
	inst:		out InstBus ;
	--mem
	mem_data_i : 	in 	DataBus ;
	mem_data_o : 	out DataBus ;
	mem_addr : 		in 	DataAddrBus ;
	mem_re :		in 	STD_LOGIC ;
	mem_we :		in 	STD_LOGIC ;
	mem_ce :		in 	STD_LOGIC ;
	--ram
	ram_data : 		inout 	DataBus ;
	ram_addr_o : 	out 	RamAddrBus ;
	ram_oe_o :		out 	STD_LOGIC ;
	ram_we_o :		out 	STD_LOGIC ;
	ram_en_o :		out 	STD_LOGIC 	
	) ;
end component ;
	signal pc_addr : 	DataAddrBus := ZeroWord;
	signal pc_ce : 		STD_LOGIC := '0';
	signal inst:		InstBus :=ZeroInst;
	--mem
	signal mem_data_i : 	DataBus :=ZeroWord;
	signal mem_data_o : 	DataBus := (others => '0');
	signal mem_addr : 		DataAddrBus := (others => '0');
	signal mem_re :			STD_LOGIC := '0';
	signal mem_we :			STD_LOGIC := '0';
	signal mem_ce :			STD_LOGIC := '0';
	--ram
	signal ram_data : 		DataBus := (others => '0');
	signal ram_addr_o : 	RamAddrBus := (others => '0');
	signal ram_oe_o :		STD_LOGIC := '0';
	signal ram_we_o :		STD_LOGIC := '0';
	signal ram_en_o :		STD_LOGIC := '0';

   constant clk_period :time :=20 ns;   
begin
	uut: ram2_ctrl PORT MAP(
	pc_addr=>pc_addr,
	pc_ce=>pc_ce,
	inst=>inst,
	--mem
	mem_data_i=>mem_data_i,
	mem_data_o=>mem_data_o,
	mem_addr=>mem_addr,
	mem_re=>mem_re,
	mem_we=>mem_we,
	mem_ce=>mem_ce,
	--ram
	ram_data=>ram_data,
	ram_addr_o=>ram_addr_o,
	ram_oe_o=>ram_oe_o,
	ram_we_o=>ram_we_o,
	ram_en_o=>ram_en_o	
	);

	process
	begin
		wait for 10 ns;
		pc_addr <= pc_addr +1;
		wait for 10 ns;
		pc_addr <= pc_addr +1;
		wait for 10 ns;
		
		mem_ce <= '1';
		mem_re <= '1';
		mem_addr <= mem_addr + '1';
		mem_data_i <= mem_data_i +'1';
		wait for 10 ns;
		
		mem_we<='1';
		mem_re<='0';
		mem_addr<=mem_addr+1;
		mem_data_i<=mem_data_i+1;
		wait for 10 ns;
		
		mem_ce<='0';
		wait;

	end process;
end Behavioral ;