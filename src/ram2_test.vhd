library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.PACK.ALL ;

ENTITY ram2_test IS port(
	clk :in STD_LOGIC ;
	rst : in STD_LOGIC ;
	pc : in std_logic_vector(2 downto 0);
	ins_o : out std_logic_vector(2 downto 0);
	m_data : in std_logic_vector(2 downto 0);
	m_data_o : out std_logic_vector(2 downto 0);
	state_o: out std_logic_vector(1 downto 0) ;
	m_addr : in std_logic_vector(2 downto 0);
	m_re : in STD_LOGIC;
	m_we : in STD_LOGIC;
	m_ce : in STD_LOGIC;
	
	addr : out RamAddrBus;
	data : inout DataBus;
	oe : out STD_LOGIC;
	we : out STD_LOGIC;
	en : out STD_LOGIC;
	
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
signal pc_addr : 	DataAddrBus := ZeroWord;
signal inst:		InstBus :=ZeroInst;
--mem
signal mem_data_i : 	DataBus :=ZeroWord;
signal mem_data_o : 	DataBus := ZeroWord ;
signal mem_addr : 		DataAddrBus := ZeroWord;
signal mem_re :			STD_LOGIC := ReadDisable;
signal mem_we :			STD_LOGIC := WriteDisable;
signal mem_ce :			STD_LOGIC := PCChipDisable;
signal clk_inner:				STD_LOGIC;
 component ram2_ctrl
 port(
	 clk : in STD_LOGIC ;
	 --pc
	 pc_addr : 	in 	DataAddrBus ;
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

begin
	wrn <= '1';
	rdn <= '1';
	ram1EN <= '0';
	ram1WE <= '1';
	ram1OE <= '0';
	ram_data1 <= "1010101010101010";
	ram_addr1 <= "000000000011111111";
	clk_inner<= clk;
	process(clk_inner, rst)
	begin
		if(rst = RstEnable) then
			pc_addr <= ZeroWord ;
			mem_data_i <= ZeroWord ;
			mem_addr <= ZeroWord ;
			mem_ce <= PCChipDisable ;
			mem_re <= ReadDisable ;
			mem_we <= WriteDisable ;
		elsif (clk'event and clk = '1') then
			pc_addr(2 downto 0) <= pc ;
			mem_addr(2 downto 0) <= m_addr ;
			mem_data_i(2 downto 0) <= m_data ;
			mem_ce <= m_ce ;
			mem_re <= m_re ;
			mem_we <= m_we ;
			pc_addr(15 downto 3) <= ZeroWord(15 downto 3) ;
			mem_addr(15 downto 3) <= ZeroWord(15 downto 3) ;
			mem_data_i(15 downto 3) <= ZeroWord(15 downto 3) ;
		end if ;
	end process ;
	
	ins_o<= inst(2 downto 0);
	m_data_o<=mem_data_o(2 downto 0);
	state_o <= "11";
	
	uut: ram2_ctrl PORT MAP(
	clk=>clk_inner,
	pc_addr=>pc_addr,
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
	ram_addr_o=>addr,
	ram_oe_o=>oe,
	ram_we_o=>we,
	ram_en_o=>en	
	);
end Behavioral ;