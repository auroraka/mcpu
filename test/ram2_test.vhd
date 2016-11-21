library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.PACK.ALL ;

ENTITY ram2_test IS port(
	clk :in STD_LOGIC ;
	rst : in STD_LOGIC ;
	pc : in std_logic_vector(2 downto 0);
	--ins_o : out std_logic_vector(2 downto 0);
	m_data : in std_logic_vector(2 downto 0);
	--m_data_o : out std_logic_vector(2 downto 0);
	state_o: out std_logic_vector(1 downto 0) ;
	m_addr : in std_logic_vector(2 downto 0);
	m_re : in STD_LOGIC;
	m_we : in STD_LOGIC;
	m_ce : in STD_LOGIC;
	
	addr : out RamAddrBus;
	data : inout DataBus;
	oe : out STD_LOGIC;
	we : out STD_LOGIC;
	en : out STD_LOGIC
	
	-- for simulate
	-- pc_addr : out DataAddrBus ;
	-- mem_addr : out DataAddrBus ;
	-- mem_data_i : out DataBus ;
	-- mem_re : out STD_LOGIC ;
	-- mem_ce : out STD_LOGIC ;
	-- mem_we : out STD_LOGIC

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
signal state : std_logic_vector(1 downto 0) := "00" ;

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
	
	process(clk, rst)
	begin
		if(rst = RstEnable) then
			pc_addr <= ZeroWord ;
			mem_data_i <= ZeroWord ;
			mem_addr <= ZeroWord ;
			mem_ce <= PCChipDisable ;
			mem_re <= ReadDisable ;
			mem_we <= WriteDisable ;
		elsif (clk'event and clk = '1') then
			case state is
				when "00" =>
					pc_addr(2 downto 0) <= pc ;
					mem_addr(2 downto 0) <= m_addr ;
					mem_data_i(2 downto 0) <= m_data ;
					mem_ce <= m_ce ;
					mem_re <= m_re ;
					mem_we <= m_we ;
					state <= "01" ;
				when others => 
					pc_addr <= ZeroWord ;
					mem_addr <= ZeroWord ;
					mem_data_i <= ZeroWord ;
					mem_ce <= PCChipDisable ;
					mem_re <= ReadDisable ;
					mem_we <= WriteDisable ;
					state <= "00" ;
			end case ;
		end if ;
	end process ;
	
	ins_o<= inst(2 downto 0);
	m_data_o<=mem_data_o(2 downto 0);
	state_o <= state ;

	uut: ram2_ctrl PORT MAP(
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