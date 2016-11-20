library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

ENTITY ram2_test IS port(
	pc : in std_logic_vector(2 downto 0);
	ins : out std_logic_vector(2 downto 0);
	m_data : in std_logic_vector(2 downto 0);
	m_data_o : out std_logic_vector(2 downto 0);
	m_addr : in std_logic_vector(2 downto 0);
	m_re : in STD_LOGIC;
	m_we : in STD_LOGIC;
	m_ce : in STD_LOGIC;
	
	addr : out RamAddrBus;
	data : inout DataBus;
	oe : out STD_LOGIC;
	we : out STD_LOGIC;
	en : out STD_LOGIC
);
END ram2_test;
architecture Behavioral of ram2_test is
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
--	signal ram_data : 		DataBus := (others => '0');
	signal ram_addr_o : 	RamAddrBus := (others => '0');
	signal ram_oe_o :		STD_LOGIC := '0';
	signal ram_we_o :		STD_LOGIC := '0';
	signal ram_en_o :		STD_LOGIC := '0';

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
	ram_data=>data,
	ram_addr_o=>ram_addr_o,
	ram_oe_o=>ram_oe_o,
	ram_we_o=>ram_we_o,
	ram_en_o=>ram_en_o	
	);
	pc_addr(2 downto 0) <= pc;
	ins<= inst(2 downto 0);
	mem_data_i(2 downto 0) <= m_data;
	m_data_o<=mem_data_o(2 downto 0);
	mem_addr(2 downto 0)<=m_addr;
	mem_re<=m_re;
	mem_we<=m_we;
	mem_ce<=m_ce;
	addr<=ram_addr_o;
	oe<=ram_oe_o;
	we<=ram_we_o;
	en<=ram_en_o;
end Behavioral ;