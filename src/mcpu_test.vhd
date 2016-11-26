--mcpu_test
-- mcpu,connect wire
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.PACK.ALL ;

entity mcpu_test is
	Port(
		rst: in STD_LOGIC ;
		clk: in STD_LOGIC ;
		--stall: in STD_LOGIC ;
		pc_test : out InstAddrBus ;
		inst_test : out InstBus
		

		dev_ram1_data_ready_i	:	in STD_LOGIC;
		dev_ram1_tbre_i			:	in STD_LOGIC;
		dev_ram1_tsre_i			:	in STD_LOGIC;
		dev_ram1_data_bi			:	inout DataBus;

		dev_ram1_oe_o			:	out STD_LOGIC;
		dev_ram1_en_o			:	out STD_LOGIC;
		dev_ram1_we_o			:	out STD_LOGIC;
		dev_ram1_addr_o			: 	out RamAddrBus;
		dev_ram1_wrn_o			:	out STD_LOGIC;
		dev_ram1_rdn_o			:	out STD_LOGIC;

		-- dev_ram2_data : 		inout 	DataBus ;
		-- dev_ram2_addr_o : 	out 	RamAddrBus ;
		-- dev_ram2_oe_o :		out 	STD_LOGIC ;
		-- dev_ram2_we_o :		out 	STD_LOGIC ;
		-- dev_ram2_en_o :		out 	STD_LOGIC 

	) ;
end mcpu_test ;

architecture Behavioral of mcpu_test is
signal branch_flag_o : STD_LOGIC := BranchFlagDown ;
signal branch_addr_o : InstAddrBus := ZeroInstAddr ;
signal pc : InstAddrBus := ZeroInstAddr ;
signal pc_inst : InstAddrBus := ZeroInstAddr ;
signal pc_data : InstBus := NopInst;
signal stall_pc : STD_LOGIC := StallNo ;
signal stall_id : STD_LOGIC := StallNo;
signal stall_ex : STD_LOGIC := StallNo ;
signal stallreq_id_o : STD_LOGIC := StallNo;
signal stallreq_mem_o: STD_LOGIC := StallNo;
signal pc_id_i : InstAddrBus := ZeroInstAddr;
signal inst_id_i: InstBus := NopInst;
signal reg0_data_id_i : DataBus := ZeroData;
signal reg1_data_id_i : DataBus := ZeroData;
signal mem_waddr_id_i : RegAddrBus := ZeroRegAddr;
signal mem_wdata_id_i : DataBus := ZeroData;
signal mem_we_id_i : STD_LOGIC := WriteDisable;
signal alusel_id_o : AluSelBus := EXE_SEL_SPECIAL;
signal alusel_ex_i: AluSelBus := EXE_SEL_SPECIAL;
signal aluop_id_o : AluOpBus := EXE_OP_NOP;
signal aluop_ex_i :AluOpBus := EXE_OP_NOP;
signal reg0_data_id_o : DataBus := ZeroData;
signal reg1_data_id_o : DataBus := ZeroData;
signal reg0_data_ex_i : DataBus := ZeroData;
signal reg1_data_ex_i : DataBus := ZeroData;
signal reg0_addr_id_o : RegAddrBus := ZeroRegAddr;
signal reg1_addr_id_o : RegAddrBus := ZeroRegAddr;
signal reg0_re_id_o : STD_LOGIC := ReadDisable;
signal reg1_re_id_o : STD_LOGIC := ReadDisable;
signal we_id_o: STD_LOGIC := WriteDisable;
signal we_wb_i : STD_LOGIC := WriteDisable;
signal we_ex_i: STD_LOGIC := WriteDisable;
signal we_ex_o: STD_LOGIC := WriteDisable;
signal we_mem_i: STD_LOGIC := WriteDisable;
signal we_mem_o: STD_LOGIC := WriteDisable;
signal waddr_id_o: RegAddrBus := ZeroRegAddr;
signal waddr_wb_i: RegAddrBus := ZeroRegAddr;
signal waddr_ex_i: RegAddrBus := ZeroRegAddr;
signal waddr_ex_o: RegAddrBus := ZeroRegAddr;
signal waddr_mem_i: RegAddrBus := ZeroRegAddr;
signal waddr_mem_o: RegAddrBus := ZeroRegAddr;
signal wdata_wb_i: DataBus := ZeroData;
signal wdata_ex_o: DataBus := ZeroData;
signal wdata_mem_i: DataBus := ZeroData;
signal wdata_mem_o: DataBus := ZeroData;
signal memrw_ex_o : MemRWBus := MemRW_Idle;
signal memrw_mem_i: MemRWBus := MemRW_Idle;
signal memaddr_ex_o : DataAddrBus := ZeroDataAddr;
signal memaddr_mem_i: DataAddrBus := ZeroDataAddr;
signal memdata_ex_o: DataBus := ZeroData;
signal memdata_mem_i: DataBus := ZeroData;
signal ram2_data_i: DataBus := ZeroData;
signal ram2_data_o: DataBus := ZeroData;
signal ram2_addr_i: DataAddrBus := ZeroDataAddr;
signal ram2_ce_i: STD_LOGIC := RamChipDisable;
signal ram2_we_i: STD_LOGIC := RamWriteDisable;
signal ram2_re_i: STD_LOGIC := RamReadDisable;
signal ram1_addr_i: DataAddrBus := ZeroDataAddr;
signal ram1_data_i: DataBus := ZeroData;
signal ram1_data_o: DataBus := ZeroData;
signal ram1_ce_i: STD_LOGIC := RamChipDisable;
signal ram1_we_i: STD_LOGIC := RamWriteDisable;
signal ram1_re_i: STD_LOGIC := RamReadDisable;

component id is
	port(
		rst : in STD_LOGIC ;
		pc_i : in InstAddrBus ;
		inst_i : in InstAddrBus ;
		reg0_data_i: in DataBus ;
		reg1_data_i : in DataBus ;
		ex_we_i: STD_LOGIC ;
		ex_waddr_i : in RegAddrBus  ;
		ex_wdata_i : in DataBus ;
		mem_we_i : in STD_LOGIC ;
		mem_waddr_i : in RegAddrBus ;
		mem_wdata_i : in DataBus ;
		
		alusel_o: out AluSelBus ;
		aluop_o: out AluOpBus ;
		reg0_data_o : out DataBus ;
		reg1_data_o : out DataBus ;
		reg0_re_o: out STD_LOGIC ;
		reg1_re_o: out STD_LOGIC ;
		reg0_addr_o: out RegAddrBus ;
		reg1_addr_o: out RegAddrBus ;
		we_o : out STD_LOGIC ;
		waddr_o: out RegAddrBus ;
		stall_req: out STD_LOGIC ;
		branch_flag_o: out STD_LOGIC ;
		branch_addr_o: out InstAddrBus 
	) ;
end component ;

component ex_mem is
	port(
		clk : in STD_LOGIC ;
		rst : in STD_LOGIC ;
		ex_memrw : in MemRWBus ;
		ex_memaddr : in DataAddrBus ;
		ex_memdata : in DataBus ;
		ex_wdata : in DataBus ;
		ex_waddr: in RegAddrBus ;
		ex_we : in STD_LOGIC ;
		
		mem_wdata: out DataBus ;
		mem_waddr : out RegAddrBus ;
		mem_memrw : out MemRWBus ;
		mem_memaddr: out DataAddrBus ;
		mem_memdata: out DataBus ;
		mem_we : out STD_LOGIC
	) ;
end component ;

component mem_wb is
	port(
		clk : in STD_LOGIC ;
		rst : in STD_LOGIC ;
		mem_wdata : in DataBus ;
		mem_waddr : in RegAddrBus ;
		mem_we : in STD_LOGIC ;
		wb_wdata : out DataBus ;
		wb_waddr : out RegAddrBus ;
		wb_we: out STD_LOGIC 
	) ;
end component ;

begin
	pc0:entity work.pc port map(
		stall=>stall_pc, 
		clk=>clk, 
		rst=>rst, 
		branch_flag_o=>branch_flag_o, 
		branch_addr_o=>branch_addr_o, 
		pc_inst => pc_inst ,
		pc=>pc
	) ;
	
	pc_test <= pc_inst ;
	
	-- ram2_ctrl0: entity work.ram2_ctrl port map(
		-- clk => clk ,
		-- --pc
		-- pc_addr => pc_inst ,
		-- inst => pc_data ,
		-- --mem
		-- mem_data_i => ram2_data_i,
		-- mem_data_o => ram2_data_o,
		-- mem_addr => ram2_addr_i,
		-- mem_re => ram2_re_i,
		-- mem_we => ram2_we_i,
		-- mem_ce => ram2_ce_i,

		-- --ramn2
		-- ram_data => dev_ram2_data,
		-- ram_addr_o => dev_ram2_addr_o,
		-- ram_oe_o => dev_ram2_oe_o,
		-- ram_we_o => dev_ram2_we_o,
		-- ram_en_o =>dev_ram2_en_o
	-- ) ;
	
	ram2_ctrl0 : entity work.ram2_fake port map(
		clk => clk, 
		pc => pc_inst, 
		inst => pc_data,
		mem_data_i => ram2_data_i ,
		mem_data_o => ram2_data_o ,
		mem_addr_i => ram2_addr_i,
		mem_re => ram2_re_i,
		mem_we => ram2_we_i,
		mem_ce => ram2_ce_i
	) ;
	
	inst_test <= pc_data ;
	
	if_id0: entity work.if_id port map(
		rst => rst ,
		clk => clk ,
		stall_pc => stall_pc ,
		stall_id => stall_id ,
		stall_ex => stall_ex ,
		if_pc => pc ,
		if_inst =>  pc_data ,
		id_pc => pc_id_i, 
		id_inst => inst_id_i
	) ;
	
	id0: id port map(
		rst => rst ,
		pc_i => pc_id_i,
		inst_i => inst_id_i,
		reg0_data_i => reg0_data_id_i ,
		reg1_data_i => reg1_data_id_i ,
		ex_waddr_i => waddr_ex_o,
		ex_we_i => we_ex_o,
		ex_wdata_i => wdata_ex_o,
		mem_waddr_i => waddr_mem_o,
		mem_we_i => we_mem_o,
		mem_wdata_i => wdata_mem_o,
		
		alusel_o => alusel_id_o,
		aluop_o => aluop_id_o,
		reg0_data_o => reg0_data_id_o,
		reg1_data_o => reg1_data_id_o,
		reg0_re_o => reg0_re_id_o,
		reg1_re_o => reg1_re_id_o,
		reg0_addr_o => reg0_addr_id_o,
		reg1_addr_o => reg1_addr_id_o,
		we_o => we_id_o,
		waddr_o => waddr_id_o,
		stall_req => stallreq_id_o,
		branch_flag_o => branch_flag_o, 
		branch_addr_o => branch_addr_o
	) ;
	
	regfile0: entity work.RegisterFile port map(
		re_0 => reg0_re_id_o,
		re_1 => reg1_re_id_o,
		raddr0 => reg0_addr_id_o,
		raddr1 => reg1_addr_id_o,
		we => we_wb_i,
		waddr => waddr_wb_i,
		wdata => wdata_wb_i,
		rst => rst,
		clk => clk,

		rdata0 => reg0_data_id_i,
		rdata1 => reg1_data_id_i
	) ;

	
	id_ex0: entity work.id_ex port map(
		rst => rst ,
		clk => clk ,
		stall_pc => stall_pc ,
		stall_id => stall_id ,
		stall_ex => stall_ex ,
		id_aluop => aluop_id_o,
		id_alusel => alusel_id_o,
		id_reg0 => reg0_data_id_o,
		id_reg1 => reg1_data_id_o,
		id_waddr => waddr_id_o,
		id_we => we_id_o,
		ex_aluop => aluop_ex_i ,
		ex_alusel => alusel_ex_i ,
		ex_reg0 => reg0_data_ex_i ,
		ex_reg1 => reg1_data_ex_i ,
		ex_waddr => waddr_ex_i ,
		ex_we => we_ex_i
	);
	
	ex0: entity work.ex port map(
		aluop_i => aluop_ex_i,
		alusel_i => alusel_ex_i, 
		reg0_i => reg0_data_ex_i, 
		reg1_i => reg1_data_ex_i, 
		waddr_i => waddr_ex_i, 
		we_i => we_ex_i, 
		rst => rst,
		
		memrw_o => memrw_ex_o,
		memaddr_o => memaddr_ex_o,
		memdata_o => memdata_ex_o ,
		we_o => we_ex_o,
		waddr_o => waddr_ex_o,
		--stallreq => stallreq_ex_o,
		wdata_o => wdata_ex_o
	) ;
	
	ex_mem0: ex_mem port map(
		clk => clk,
		rst => rst, 
		ex_memrw => memrw_ex_o,
		ex_memaddr => memaddr_ex_o,
		ex_memdata => memdata_ex_o,
		ex_wdata => wdata_ex_o,
		ex_waddr => waddr_ex_o,
		ex_we => we_ex_o,
		
		mem_wdata => wdata_mem_i ,
		mem_waddr => waddr_mem_i,
		mem_memrw => memrw_mem_i,
		mem_memaddr => memaddr_mem_i,
		mem_memdata => memdata_mem_i, 
		mem_we => we_mem_i
	) ;
	
	mem_wb0: mem_wb port map(
		clk => clk ,
		rst => rst ,
		mem_wdata => wdata_mem_o, 
		mem_waddr => waddr_mem_o,
		mem_we => we_mem_o ,
		
		wb_wdata => wdata_wb_i,
		wb_waddr => waddr_wb_i, 
		wb_we => we_wb_i
	) ;
	
	mem0: entity work.mem port map(
		rst => rst ,
		--寄存�
		we_i => we_mem_i,
		waddr_i => waddr_mem_i,
		wdata_i => wdata_mem_i,
		--ram
		memdata_i => memdata_mem_i,
		memrw_i => memrw_mem_i, 
		memaddr_i => memaddr_mem_i,

		we_o => we_mem_o,
		waddr_o => waddr_mem_o,
		wdata_o => wdata_mem_o,
		stall_req => stallreq_mem_o,
		--ram 2
		ram2_data_i => ram2_data_o,
		ram2_data_o => ram2_data_i,
		ram2_re_o => ram2_re_i,
		ram2_we_o => ram2_we_i,
		ram2_addr_o => ram2_addr_i,
		ram2_ce_o => ram2_ce_i,
		--ram 1
		ram1_data_i => ram1_data_o,
		ram1_data_o => ram1_data_i ,
		ram1_re_o => ram1_re_i,
		ram1_we_o => ram1_we_i,
		ram1_addr_o => ram1_addr_i,
		ram1_ce_o => ram1_ce_i	
	) ;
	
	stall_ctrl0: entity work.stall_ctrl port map(
		rst => rst ,
		stallreq_id => stallreq_id_o, 
		stallreq_mem => stallreq_mem_o,
		
		stall_pc => stall_pc,
		stall_id => stall_id, 
		stall_ex => stall_ex
	) ;
	
	ram1_ctrl0: entity work.ram1_ctrl port map(
		clk => clk ,
		--mem
		mem_data_i => ram1_data_i,
		mem_data_o => ram1_data_o,
		mem_addr_i => ram1_addr_i,
		mem_re => ram1_re_i,
		mem_we => ram1_we_i,
		mem_ce => ram1_ce_i,

		--ram
		ram_data_ready_i => dev_ram1_data_ready_i,
		ram_tbre_i => dev_ram1_tbre_i,
		ram_tsre_i => dev_ram1_tsre_i,
		ram_data_bi => dev_ram1_data_bi,

		ram_oe_o => dev_ram1_oe_o,
		ram_en_o => dev_ram1_en_o,
		ram_we_o => dev_ram1_we_o,
		ram_addr_o => dev_ram1_addr_o,
		ram_wrn_o => dev_ram1_wrn_o,
		ram_rdn_o => dev_ram1_rdn_o
	) ;
	
	-- ram1_ctrl0 : entity work.ram1_fake port map(
		-- clk => clk ,
		-- -- --mem
		-- mem_data_i => ram1_data_i,
		-- mem_data_o => ram1_data_o,
		-- mem_addr_i => ram1_addr_i,
		-- mem_re => ram1_re_i,
		-- mem_we => ram1_we_i,
		-- mem_ce => ram1_ce_i
	-- ) ;
end Behavioral ;