-- mcpu,connect wire
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.PACK.ALL ;

entity mcpu is
	Port(
		rst: in STD_LOGIC ;
		clk: in STD_LOGIC ;
		--stall: in STD_LOGIC ;
		id_pc_i: out InstAddrBus ;
		id_inst_i: out InstBus 
	) ;
end mcpu ;

architecture Behavioral of mcpu is
signal branch_flag_o : STD_LOGIC := BranchFlagDown ;
signal branch_addr_o : InstAddrBus := ZeroInstAddr ;
signal pc : InstAddrBus := ZeroInstAddr ;
signal pc_data : InstBus ;
signal stall_pc : STD_LOGIC := StallNo ;
signal stall_id : STD_LOGIC := StallNo;
signal stall_ex : STD_LOGIC := StallNo ;
--signal stall_ex_mem  : STD_LOGIC := StallNo ;
--signal stall_mem_wb : STD_LOGIC := StallNo ;
signal stallreq_id_o : STD_LOGIC ;
--signal stallreq_ex_o : STD_LOGIC ;
signal stallreq_mem_o: STD_LOGIC ;
signal pc_id_i : InstAddrBus ;
signal inst_id_i: InstBus ;
signal reg0_data_id_i : DataBus ;
signal reg1_data_id_i : DataBus ;
signal mem_waddr_id_i : RegAddrBus ;
signal mem_wdata_id_i : DataBus ;
signal mem_we_id_i : STD_LOGIC ;
signal alusel_id_o : AluSelBus ;
signal alusel_ex_i: AluSelBus ;
signal aluop_id_o : AluOpBus ;
signal aluop_ex_i :AluOpBus ;
signal reg0_data_id_o : DataBus;
signal reg1_data_id_o : DataBus ;
signal reg0_data_ex_i : DataBus ;
signal reg1_data_ex_i : DataBus ;
signal reg0_addr_id_o : RegAddrBus ;
signal reg1_addr_id_o : RegAddrBus ;
signal reg0_re_id_o : STD_LOGIC ;
signal reg1_re_id_o : STD_LOGIC ;
signal we_id_o: STD_LOGIC ;
signal we_wb_i : STD_LOGIC ;
signal we_ex_i: STD_LOGIC ;
signal we_ex_o: STD_LOGIC ;
signal we_mem_i: STD_LOGIC ;
signal we_mem_o: STD_LOGIC ;
signal waddr_id_o: RegAddrBus ;
signal waddr_wb_i: RegAddrBus ;
signal waddr_ex_i: RegAddrBus ;
signal waddr_ex_o: RegAddrBus ;
signal waddr_mem_i: RegAddrBus ;
signal waddr_mem_o: RegAddrBus ;
signal wdata_wb_i: DataBus ;
signal wdata_ex_o: DataBus ;
signal wdata_mem_i: DataBus ;
signal wdata_mem_o: DataBus ;
signal memrw_ex_o : MemRWBus ;
signal memrw_mem_i: MemRWBus ;
signal memaddr_ex_o : DataAddrBus ;
signal memaddr_mem_i: DataAddrBus ;
signal memdata_ex_o: DataBus ;
signal memdata_mem_i: DataBus ;
signal ram2_data_i: DataBus ;
signal ram2_data_o: DataBus ;
signal ram2_addr_i: DataAddrBus ;
signal ram2_ce_i: STD_LOGIC ;
signal ram2_we_i: STD_LOGIC ;
signal ram2_re_i: STD_LOGIC ;
signal ram1_addr_i: DataAddrBus ;
signal ram1_data_i: DataBus ;
signal ram1_data_o: DataBus ;
signal ram1_ce_i: STD_LOGIC ;
signal ram1_we_i: STD_LOGIC ;
signal ram1_re_i: STD_LOGIC ;

begin
	mpc:entity work.pc port map(
		stall=>stall_pc, 
		clk=>clk, 
		rst=>rst, 
		branch_flag_o=>branch_flag_o, 
		branch_addr_o=>branch_addr_o, 
		pc=>pc
	) ;
	id_pc_i <= pc ;
	
	mram2_ctrl: entity.work.ram2_ctrl port map(
		clk => clk ,
		--pc
		pc_addr => pc ,
		inst => pc_data ,
		--mem
		mem_data_i => ram2_data_i,
		mem_data_o => ram2_data_o,
		mem_addr => ram2_addr_i,
		mem_re => ram2_re_i,
		mem_we => ram2_we_i,
		mem_ce => ram2_ce_i
	) ;
	
	mif_id: entity work.if_id port map(
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
	
	mid:entity work.id port map(
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
	
	mireg: entity work.RegisterFile port map(
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

	
	mid_ex: entity work.id_ex port map(
		rst => rst ,
		clk => clk ,
		stall_pc => stall_pc ,
		stall_id => stall_id ,
		stall_ex => stall_ex .
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
	
	mexe: entity work.exe port map(
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
	
	mex_mem: entity work.ex_mem port map(
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
	
	mmem_wb: entity work.mem_wb port map(
		clk => clk ,
		rst => rst ,
		mem_wdata => wdata_mem_o, 
		mem_waddr => waddr_mem_o,
		mem_we => we_mem_o ,
		
		wb_wdata => wdata_wb_i,
		wb_waddr => waddr_wb_i, 
		wb_we => we_wb_i
	) ;
	
	mmen: entity work.mem port map(
		rst => rst ,
		--寄存器
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
	
	mstall_ctrl: entity work.stall_ctrl port map(
		rst => rst ,
		stallreq_id => stallreq_id_o, 
		stallreq_mem => stallreq_mem_o,
		
		stall_pc => stall_pc,
		stall_id => stall_id, 
		stall_ex => stall_ex
	) ;
	
	mram1_ctrl: entity work.ram1_ctrl port map(
		clk => clk ,
		--mem
		mem_data_i => ram1_data_i,
		mem_data_o => ram1_data_o,
		mem_addr_i => ram1_addr_i,
		mem_re => ram1_re_i,
		mem_we => ram1_we_i,
		mem_ce => ram1_ce_i

		-- --ram
		-- ram_data_ready_i	:	in STD_LOGIC;
		-- ram_tbre_i			:	in STD_LOGIC;
		-- ram_tsre_i			:	in STD_LOGIC;
		-- ram_data_bi			:	inout DataBus;

		-- ram_oe_o			:	out STD_LOGIC;
		-- ram_en_o			:	out STD_LOGIC;
		-- ram_we_o			:	out STD_LOGIC;
		-- ram_addr_o			: 	out DataAddrBus;
		-- ram_wrn_o			:	out STD_LOGIC;
		-- ram_rdn_o			:	out STD_LOGIC
	) ;
end Behavioral ;