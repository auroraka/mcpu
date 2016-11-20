-- mcpu,connect wire
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.PACK.ALL ;

entity mcpu is
	Port(
		rst: in STD_LOGIC ;
		clk: in STD_LOGIC ;
		stall: in STD_LOGIC ;
		id_pc_i: out InstAddrBus ;
		id_inst_i: out InstBus 
	) ;
end mcpu ;

architecture Behavioral of mcpu is
signal branch_flag_o : STD_LOGIC := BranchFlagDown ;
signal branch_addr_o : InstAddrBus := ZeroInstAddr ;
signal pc : InstAddrBus := ZeroInstAddr ;
signal rom_inst_i : InstBus  ;
signal rom_ce_o : STD_LOGIC ;
signal rom_addr_o: DataAddrBus ;
signal stall_pc : STD_LOGIC := StallNo ;
signal stall_if_id : STD_LOGIC := StallNo;
signal stall_id_ex : STD_LOGIC := StallNo ;
signal stall_ex_mem  : STD_LOGIC := StallNo ;
signal stall_mem_wb : STD_LOGIC := StallNo ;
signal stallreq_id_o : STD_LOGIC ;
signal stallreq_ex_o : STD_LOGIC ;
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
signal ram2_data: DataBus ;
signal ram2_addr_o: DataAddrBus ;
signal ram2_ce_o: STD_LOGIC ;
signal ram2_we_o: STD_LOGIC ;
signal ram2_re_o: STD_LOGIC ;
signal ram1_addr_o: DataAddrBus ;
signal ram1_data: DataBus ;
signal ram1_ce_o: STD_LOGIC ;
signal ram1_we_o: STD_LOGIC ;
signal ram1_re_o: STD_LOGIC ;

component pc
	Port(
		stall:		in		std_logic;
		clk:		in 		std_logic;
		rst:		in 		std_logic;
		branch_flag_o:	in	std_logic;
		branch_addr_o:	in	InstAddrBus;
		pc:				out InstAddrBus;
		ce:				out std_logic
	) ;
end component ;

component inst_rom
	Port(
		ce : in STD_LOGIC ;
		addr: in InstAddrBus ;
		inst : out InstBus
	) ;
end component ;

component id
	Port(
		rst : in STD_LOGIC ;
		pc_i : in InstAddrBus ;
		inst_i : in InstBus ;
		reg0_data_i: in DataBus ;
		reg1_data_i: in DataBus ;
		ex_waddr_i: in RegAddrBus ;
		ex_we_i : in STD_LOGIC ;
		ex_wdata_i: in DataBus ;
		mem_waddr_i: in RegAddrBus ;
		mem_we_i: in STD_LOGIC ;
		mem_wdata_i: in DataBus ;
		
		alusel_o: out AluSelBus ;
		aluop_o: out AluOpBus ;
		reg0_data_o: out DataBus ;
		reg1_data_o: out DataBus ;
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

component if_id
	Port(
		rst: in STD_LOGIC ;
		clk: in STD_LOGIC ;
		stall: in STD_LOGIC ;
		if_pc: in InstAddrBus ;
		if_inst: in InstBus ;
		id_pc: out InstAddrBus ;
		id_inst: out InstBus
	) ;
end component ;

component id_ex
	Port(
		rst : in STD_LOGIC ;
		clk: in STD_LOGIC ;
		stall: in STD_LOGIC ;
		id_aluop: in AluOpBus ;
		id_alusel: in AluSelBus ;
		id_reg0: in DataBus ;
		id_reg1: in DataBus ;
		id_waddr: in RegAddrBus ;
		id_we: in STD_LOGIC ;
		ex_aluop: out AluOpBus ;
		ex_alusel: out AluSelBus ;
		ex_reg0: out DataBus ;
		ex_reg1: out DataBus ;
		ex_waddr: out RegAddrBus ;
		ex_we: out STD_LOGIC ;
	) ;
end component ;

component exe
	Port(
		aluop_i : in AluOpBus ;
		alusel_i : in AluSelBus ;
		reg0_i : in DataBus ;
		reg1_i : in DataBus ;
		waddr_i : in RegAddrBus ;
		we_i : in STD_LOGIC ;
		rst : in STD_LOGIC ;
		
		memrw_o : out MemRWBus ;
		memaddr_o : out DataAddrBus ;
		memdata_o : out DataBus ;
		we_o : out STD_LOGIC ;
		waddr_o : out RegAddrBus ;
		stallreq: out STD_LOGIC ;
		wdata_o : out DataBus
	) ;
end component ;

component RegisterFile
	Port(
		re_0 : in STD_LOGIC ;
		re_1 : in STD_LOGIC ;
		raddr0 : in RegAddrBus ;
		raddr1 : in RegAddrBus ;
		we : in STD_LOGIC ;
		waddr : in RegAddrBus ;
		wdata : in DataBus ;
		rst : in STD_LOGIC ;
		clk : in STD_LOGIC ;
		
		rdata0 : out DataBus ;
		rdata1 : out DataBus 
	) ;
end component ;

component ex_mem
	Port(
		clk: in STD_LOGIC ;
		rst: in STD_LOGIC ;
		stall: in STD_LOGIC ;
		ex_memrw: in MemRWBus ;
		ex_memaddr: in DataAddrBus ;
		ex_memdata: in DataBus ;
		ex_wdata: in DataBus ;
		ex_waddr : in RegAddrBus ;
		ex_we: in STD_LOGIC ;
		
		mem_wdata: out DataBus ;
		mem_waddr: out RegAddrBus ;
		mem_memrw: out  MemRWBus ;
		mem_memaddr: out DataAddrBus ;
		mem_memdata: out DataBus ;
		mem_we: out STD_LOGIC 
	) ;
end component ;

component mem_wb
	Port(
		clk: in STD_LOGIC ;
		rst: in STD_LOGIC ;
		stall: in STD_LOGIC ;
		mem_wdata: in DataBus ;
		mem_waddr: in RegAddrBus ;
		mem_we: in STD_LOGIC ;
		
		wb_wdata: out DataBus ;
		wb_waddr: out RegAddrBus ;
		wb_we: out STD_LOGIC 
	) ;
end component ;

component mem
	Port(
		--寄存器
		we_i : 		in STD_LOGIC ;
		waddr_i : 	in RegAddrBus ;
		wdata_i : 	in DataBus ;
		--ram
		memdata_i : in DataBus ;
		memrw_i : 	in MemRWBus ; 
		memaddr_i : in DataAddrBus ;
		rst : 		in STD_LOGIC ;

		we_o : 		out STD_LOGIC ;
		waddr_o : 	out RegAddrBus ;
		wdata_o : 	out DataBus ;
		stall_req : out STD_LOGIC
		--ram 2
		ram2_data : 	inout DataBus ;
		ram2_re_o :		out STD_LOGIC ;
		ram2_we_o :		out STD_LOGIC ;
		ram2_addr_o : 	out DataAddrBus ;
		ram2_ce_o :		out STD_LOGIC;
		--ram 1
		ram1_data : 	inout DataBus ;
		ram1_re_o :		out STD_LOGIC ;
		ram1_we_o :		out STD_LOGIC ;
		ram1_addr_o : 	out DataAddrBus ;
		ram1_ce_o :		out STD_LOGIC	
	) ;
end component ;

component stall_ctrl
	Port(
		rst : in STD_LOGIC ;
		stallreq_id: in STD_LOGIC ;
		stallreq__ex: in STD_LOGIC ;
		stallreq_mem: in STD_LOGIC ;
		
		stall_pc: out STD_LOGIC ;
		stall_if_id: out STD_LOGIC ;
		stall_id_ex: out STD_LOGIC ;
		stall_ex_mem: out STD_LOGIC ;
		stall_mem_wb: out STD_LOGIC
	) ;
end component ;

component ram1_ctrl
	Port(
	) ;
end component ;

component ram2_ctrl
	Port(
	) ;
end component ;

begin
	mpc: pc port map(stall=>stall_pc, clk=>clk, rst=>rst, branch_flag_o=>branch_flag_o, branch_addr_o=>branch_addr_o, pc=>pc, ce=>rom_ce_o) ;
	id_pc_i <= pc ;
	rom_addr_o <= pc ;
	minst_rom: inst_rom port map(ce=>rom_ce_o, addr=>pc, inst=>rom_inst_i) ;
	id_inst_i <= rom_inst_i ;
	mif_id: if_id port map(
		rst => rst ,
		clk => clk ,
		stall => stall_if_id ,
		if_pc => pc ,
		if_inst => rom_inst_i ;
		id_pc => pc_id_i, 
		id_inst => inst_id_i
	) ;
	mid: id port map(
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
	
	mireg: RegisterFile port map(
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

	
	mid_ex: id_ex port map(
		rst => rst ,
		clk => clk ,
		stall => stall_id_ex ,
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
	
	mexe: exe port map(
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
		stallreq => stallreq_ex_o,
		wdata_o => wdata_ex_o
	) ;
	
	mex_mem: ex_mem port map(
		clk => clk,
		rst => rst, 
		stall => stall_ex_mem,
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
	
	mmem_wb: mem_wb port map(
		clk => clk ,
		rst => rst ,
		stall => stall_mem_wb ,
		mem_wdata => wdata_mem_o, 
		mem_waddr => waddr_mem_o,
		mem_we => we_mem_o ,
		
		wb_wdata => wdata_wb_i,
		wb_waddr => waddr_wb_i, 
		wb_we => we_wb_i
	) ;
	
	mmen: mem port map(
		--寄存器
		we_i => we_mem_i,
		waddr_i => waddr_mem_i,
		wdata_i => wdata_mem_i,
		--ram
		memdata_i => memdata_mem_i,
		memrw_i => memrw_mem_i, 
		memaddr_i => memaddr_mem_i,
		rst => rst ,

		we_o => we_mem_o,
		waddr_o => waddr_mem_o,
		wdata_o => wdata_mem_o,
		stall_req => stallreq_mem_o,
		--ram 2
		ram2_data => ram2_data,
		ram2_re_o => ram2_re_o,
		ram2_we_o => ram2_we_o,
		ram2_addr_o => ram2_addr_o,
		ram2_ce_o => ram2_ce_o,
		--ram 1
		ram1_data => ram1_data,
		ram1_re_o => ram1_re_o,
		ram1_we_o => ram1_we_o,
		ram1_addr_o => ram1_addr_o,
		ram1_ce_o => ram1_ce_o	
	) ;
	
	mstall_ctrl: stall_ctrl port map(
		rst => rst ,
		stallreq_id => stallreq_id_o, 
		stallreq__ex => stallreq_ex_o,
		stallreq_mem => stallreq_mem_o,
		
		stall_pc => stall_pc,
		stall_if_id => stall_if_id, 
		stall_id_ex => stall_id_ex,
		stall_ex_mem => stall_ex_mem,
		stall_mem_wb => stall_mem_wb
	) ;
end Behavioral ;