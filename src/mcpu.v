`include "defines.v"

module mcpu(
	input wire clk,
	input wire rst,
	input wire[`DataBus] rom_inst_i, //ROM <=> IF/ID
	
	output wire rom_ce_o, //PC <=> ROM
	output wire[`DataAddrBus] rom_addr_o //PC <=> ROM
);

//PC <=> IF/ID
wire[`InstAddrBus] pc;

//IF/ID <=> ID
wire[`InstAddrBus] id_pc_i;
wire[`InstBus] id_inst_i;

//ID <=> ID/EX 
wire[`AluSelBus] id_alusel_o;
wire[`AluOpBus] id_aluop_o;
wire[`DataBus] id_reg0_o;
wire[`DataBus] id_reg1_o;
wire[`RegAddrBus] id_waddr_o;
wire id_we_o;

//ID <=> Regfile
wire reg0_re;
wire reg1_re;
wire[`DataBus] reg0_data;
wire[`DataBus] reg1_data;
wire[`RegAddrBus] reg0_addr;
wire[`RegAddrBus] reg1_addr;


//ID/EX <=> EX
wire[`AluSelBus] ex_alusel_i;
wire[`AluOpBus] ex_aluop_i;
wire[`DataBus] ex_reg0_i;
wire[`DataBus] ex_reg1_i;
wire[`RegAddrBus] ex_waddr_i;
wire ex_we;

//EX <=> EX/MEM
wire[`RegAddrBus] ex_waddr_o;
wire ex_we_o;
wire[`DataBus] ex_wdata_o;

//EX/MEM <=> MEM
wire[`RegAddrBus] mem_waddr_i;
wire mem_we_i;
wire[`DataBus] mem_wdata_i;

//MEM <=> MEM/WB
wire[`RegAddrBus] mem_waddr_o;
wire mem_we_o;
wire[`DataBus] mem_wdata_o;

//MEM/WB <=> Regfile
wire[`RegAddrBus] wb_waddr_i;
wire wb_we_i;
wire[`DataBus] wb_wdata_i;

//MEM/WB <=> HILO
wire wb_we_hilo_i;
wire[`DataBus] wb_hi_i;
wire[`DataBus] wb_lo_i; 

//HILO <=> EX
wire[`DataBus] hi_o;
wire[`DataBus] lo_o; 

assign rom_addr_o = pc;

	pc pc0(
		.clk(clk),
		.rst(rst),
		.pc(pc),
		.ce(rom_ce_o)
	);
	
	if_id if_id0(
		.clk(clk),
		.rst(rst),
		.if_pc(pc),
		.if_inst(rom_inst_i),
		.id_pc(id_pc_i),
		.id_inst(id_inst_i)
	);
	
	id id0(
		.rst(rst),
		//[IN]
		//IF/ID
		.pc_i(id_pc_i),
		.inst_i(id_inst_i),
		//Regfile
		.reg0_data_i(reg0_data),
		.reg1_data_i(reg1_data),

		
		//[OUT]
		//ID/EX
		.aluop_o(id_aluop_o),
		.alusel_o(id_alusel_o),
		.reg0_o(id_reg0_o),
		.reg1_o(id_reg1_o),
		.waddr_o(id_waddr_o),
		.we_o(id_we_o),
		//Regfile
		.reg0_addr_o(reg0_addr),
		.reg1_addr_o(reg1_addr),
		.reg0_re_o(reg0_re),
		.reg1_re_o(reg1_re)

		//EX
		//.ex_wdata_i(ex_wdata_o),
		//.ex_waddr_i(ex_waddr_o),
		//.ex_we_i(ex_we_o),
		//MEM
		//.mem_wdata_i(mem_wdata_o),
		//.mem_waddr_i(mem_waddr_o),
		//.mem_we_i(mem_we_o)
	);
	
	regfile regfile0(
		//[IN]
		.rst(rst),
		.clk(clk),
		//<=ID
		.re0(reg0_re),
		.re1(reg1_re),
		.raddr0(reg0_addr),
		.raddr1(reg1_addr),
		//<=WB
		.we(wb_we_i),
		.waddr(wb_waddr_i),
		.wdata(wb_wdata_i),

		//[OUT]
		.rdata0(reg0_data),
		.rdata1(reg1_data)
	);

	id_ex id_ex0(
		.rst(rst),
		.clk(clk),
		
		.id_aluop(id_aluop_o),
		.id_alusel(id_alusel_o),
		.id_reg0(id_reg0_o),
		.id_reg1(id_reg1_o),
		.id_waddr(id_waddr_o),
		.id_we(id_we_o),
		
		.ex_aluop(ex_aluop_i),
		.ex_alusel(ex_alusel_i),
		.ex_reg0(ex_reg0_i),
		.ex_reg1(ex_reg1_i),
		.ex_waddr(ex_waddr_i),
		.ex_we(ex_we_i)
	);
	
	ex ex0(
		.rst(rst),
		//in
		.aluop_i(ex_aluop_i),
		.alusel_i(ex_alusel_i),
		.reg0_i(ex_reg0_i),
		.reg1_i(ex_reg1_i),
		.waddr_i(ex_waddr_i),
		.we_i(ex_we_i),
		
		//.hi_i(hi_o),
		//.lo_i(lo_o),
		//.wb_we_hilo_i(wb_we_hilo_i),
		//.wb_hi_i(wb_hi_i),
		//.wb_lo_i(wb_lo_i),
		//.mem_we_hilo_i(mem_we_hilo_o),
		//.mem_hi_i(mem_hi_o),
		//.mem_lo_i(mem_lo_o),
		
		//out
		.wdata_o(ex_wdata_o),
		.waddr_o(ex_waddr_o),
		.we_o(ex_we_o)
		//.we_hilo_o(ex_we_hilo_o),
		//.hi_o(ex_hi_o),
		//.lo_o(ex_lo_o)
	);
	
	ex_mem ex_mem0(
		.rst(rst),
		.clk(clk),
	
		.ex_wdata(ex_wdata_o),
		.ex_waddr(ex_waddr_o),
		.ex_we(ex_we_o),
		//.ex_we_hilo(ex_we_hilo_o),
		//.ex_hi(ex_hi_o),
		//.ex_lo(ex_lo_o),
		
		.mem_wdata(mem_wdata_i),
		.mem_waddr(mem_waddr_i),
		.mem_we(mem_we_i)
		//.mem_we_hilo(mem_we_hilo_i)
		//.mem_hi(mem_hi_i),
		//.mem_lo(mem_lo_i)
	);
	
	mem mem0(
		.rst(rst),
		.wdata_i(mem_wdata_i),
		.waddr_i(mem_waddr_i),
		.we_i(mem_we_i),
		//.we_hilo_i(mem_we_hilo_i),
		//.hi_i(mem_hi_i),
		//.lo_i(mem_lo_i),

		.wdata_o(mem_wdata_o),
		.waddr_o(mem_waddr_o),
		.we_o(mem_we_o)
		//.we_hilo_o(mem_we_hilo_o),
		//.hi_o(mem_hi_o),
		//.lo_o(mem_lo_o)
	);
	
	mem_wb mem_wb0(
		.rst(rst),
		.clk(clk),
		.mem_wdata(mem_wdata_o),
		.mem_waddr(mem_waddr_o),
		.mem_we(mem_we_o),
		//.mem_we_hilo(mem_we_hilo_o),
		//.mem_hi(mem_hi_o),
		//.mem_lo(mem_lo_o),
		.wb_wdata(wb_wdata_i),
		.wb_waddr(wb_waddr_i),
		.wb_we(wb_we_i)
		//.wb_we_hilo(wb_we_hilo_i),
		//.wb_hi(wb_hi_i),
		//.wb_lo(wb_lo_i)
	);
	
	// hilo_reg hilo_reg0(
		// .rst(rst),
		// .clk(clk),
		// .we_i(wb_we_hilo_i),
		// .hi_i(wb_hi_i),
		// .lo_i(wb_lo_i),
		// .hi_o(hi_o),
		// .lo_o(lo_o)
	// );
	
endmodule