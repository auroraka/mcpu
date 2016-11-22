library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.PACK.ALL ;

ENTITY ram2_test IS port(
	clk :in STD_LOGIC ;
	rst : in STD_LOGIC ;
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
	en : out STD_LOGIC;
	
	ram_data_ready_i	:	in STD_LOGIC;
	ram_tbre_i			:	in STD_LOGIC;
	ram_tsre_i			:	in STD_LOGIC;
	--led
	ram_data_ready_o	:	out STD_LOGIC;
	ram_tbre_o			:	out STD_LOGIC;
	ram_tsre_o			:	out STD_LOGIC;
	--
	ram_addr1 : out RamAddrBus;
	ram_data1 : inout DataBus;
	ram1OE : out STD_LOGIC;
	ram1WE : out STD_LOGIC;
	ram1EN : out STD_LOGIC;
	rdn : out STD_LOGIC;
	wrn : out STD_LOGIC
);
END ram2_test;

architecture Behavioral of ram2_test is
--mem
signal mem_data_i : 	DataBus :=ZeroWord;
signal mem_data_o : 	DataBus := ZeroWord ;
signal mem_addr : 		DataAddrBus := ZeroWord;
signal mem_re :			STD_LOGIC := ReadDisable;
signal mem_we :			STD_LOGIC := WriteDisable;
signal mem_ce :			STD_LOGIC := PCChipDisable;
signal clk_inner:				STD_LOGIC;

 component ram1_ctrl
 port(
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
 end component ;

begin
	en <= '0';
	we <= '1';
	oe <= '0';
	data <= "1010101010101010";
	addr <= "000000000011111111";
	clk_inner<= not clk;
	--led
	ram_data_ready_o<=ram_data_ready_i;
	ram_tbre_o<=ram_tbre_i;
	ram_tsre_o<=ram_tsre_i;
	
	process(clk_inner, rst)
	begin
		if(rst = RstEnable) then
			mem_data_i <= ZeroWord ;
			mem_addr <= ZeroWord ;
			mem_ce <= PCChipDisable ;
			mem_re <= ReadDisable ;
			mem_we <= WriteDisable ;
		elsif (clk_inner'event and clk_inner = '1') then
			mem_addr(2 downto 0) <= m_addr ;
			mem_data_i(2 downto 0) <= m_data ;
			mem_ce <= m_ce ;
			mem_re <= m_re ;
			mem_we <= m_we ;
			mem_addr(15 downto 3) <= ZeroWord(15 downto 3) ;
			mem_data_i(15 downto 3) <= ZeroWord(15 downto 3) ;
		end if ;
	end process ;
	
	m_data_o<=mem_data_o(2 downto 0);
	
	uut2: ram1_ctrl PORT MAP(
	clk=>clk_inner,
	--mem
	mem_data_i=>mem_data_i,
	mem_data_o=>mem_data_o,
	mem_addr_i=>mem_addr,
	mem_re=>mem_re,
	mem_we=>mem_we,
	mem_ce=>mem_ce,
	--ram
	ram_data_ready_i=>ram_data_ready_i,
	ram_tbre_i=>ram_tbre_i,
	ram_tsre_i=>ram_tsre_i,
	ram_data_bi=>ram_data1,
	ram_addr_o=>ram_addr1,
	ram_oe_o=>ram1OE,
	ram_we_o=>ram1WE,
	ram_en_o=>ram1EN,
	ram_wrn_o=>wrn,
	ram_rdn_o=>rdn
	);
end Behavioral ;