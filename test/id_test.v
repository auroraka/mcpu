//`include "defines.v"
`include "D:\\CPU\\mcpu\\src\\defines.v"
`timescale 1ns / 1ns
module exe_test ;

//input 

reg rst ;	
reg[`InstAddrBus] pc_i ;
reg[`InstBus] inst_i ;
	
reg[`DataBus] reg0_data_i ;
reg[`DataBus] reg1_data_i ;
	
reg[`RegAddrBus] ex_waddr_i ;
reg ex_we_i ;
reg[`DataBus] ex_wdata_i ;

reg[`RegAddrBus] mem_waddr_i ;
reg mem_we_i ;
reg[`DataBus] mem_wdata_i ;

// output
wire[`AluSelBus] alusel_o;
wire[`AluOpBus] aluop_o ;
wire[`DataBus] reg0_data_o ;
wire[`DataBus] reg1_data_o ;
wire reg0_re_o ;
wire reg1_re_o ;
wire[`RegAddrBus] reg0_addr_o ;
wire[`RegAddrBus] reg1_addr_o ;
wire we_o ;
wire[`RegAddrBus] waddr_o ;	

wire stall_req ;
wire branch_flag_o ;
wire[`InstAddrBus] branch_addr_o ;

id uut(
	.rst(rst),
	.pc_i(pc_i),
	.inst_i(inst_i),
	.reg0_data_i(reg0_data_i),
	.reg1_data_i(reg1_data_i),
	.ex_waddr_i(ex_waddr_i),
	.ex_wdata_i(ex_wdata_i),
	.mem_waddr_i(mem_waddr_i),
	.mem_wdata_i(mem_wdata_i),
	.alusel_o(alusel_o),
	.aluop_o(aluop_o),
	.reg0_addr_o(reg0_addr_o),
	.reg1_addr_o(reg1_addr_o),
	.reg0_data_o(reg0_data_o),
	.reg1_data_o(reg1_data_o),
	.reg0_re_o(reg0_re_o),
	.reg1_re_o(reg1_re_o),
	.we_o(we_o),
	.waddr_o(waddr_o),
	.stall_req(stall_req),
	.branch_flag_o(branch_flag_o),
	.branch_addr_o(branch_addr_o)
) ;

initial begin
rst = `RstEnable ;
pc_i = 0 ;
inst_i = 0 ;
reg0_data_i = 0 ;
reg1_data_i = 0 ;
ex_waddr_i = 0 ;
ex_wdata_i = 0 ;
mem_wdata_i = 0 ;
mem_waddr_i = 0 ;
mem_we_i = `WriteDisable ;
ex_we_i = `WriteDisable ;

#10 ;
rst = `RstDisable ;
pc_i = 1 ;
reg0_data_i = 1 ;
inst_i = 16'b0100101000001111 ;


#10 ;
pc_i = 1 ;
pc_i = 2 ;
inst_i = 16'b0100101000001111 ;

#10 ;

end

endmodule

