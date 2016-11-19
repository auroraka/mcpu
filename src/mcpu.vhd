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
signal branchflag_o : STD_LOGIC := BranchFlagDown ;
signal branch_addr_o : InstAddrBus := ZeroInstAddr ;
signal pc : InstAddrBus := ZeroInstAddr ;
signal rom_inst_i : DataBus := ZeroData ;
signal rom_ce_o : STD_LOGIC ;
signal rom_addr_o: DataAddrBus := ZeroDataAddr ;

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

component if_id
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
		stallreq : in STD_LOGIC ;
		rst : in STD_LOGIC ;
		
		--aluop_o : out EXE_OP ;
		memrw_o : out MemRWBus ;
		memaddr_o : out DataAddrBus ;
		we_o : out STD_LOGIC ;
		waddr_o : out RegAddrBus ;
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

component exe_mem
	Port(
		clk: in STD_LOGIC ;
		rst: in STD_LOGIC ;
		stall: in STD_LOGIC ;
		ex_memrw: in MemRWBus ;
		ex_memaddr: in DataAddrBus ;
		ex_wdata: in DataBus ;
		ex_waddr : in RegAddrBus ;
		ex_we: in STD_LOGIC ;
		
		mem_wdata: out DataBus ;
		mem_waddr: out RegAddrBus ;
		mem_memrw: out  MemRWBus ;
		mem_memaddr: out DataAddrBus ;
		mem_we: out STD_LOGIC 
	) ;
end component ;


begin

end Behavioral ;