`timescale 1ns / 1ns
`include "defines.v"
//`include "D:\\CPU\\mcpu\\src\\defines.v"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:47:48 11/22/2016
// Design Name:   id
// Module Name:   D:/CPU/mcpu/test/id_tb.v
// Project Name:  cpu_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: id
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module id_tb;

	// Inputs
	reg rst;
	reg [15:0] pc_i;
	reg [15:0] inst_i;
	reg [15:0] reg0_data_i;
	reg [15:0] reg1_data_i;
	reg ex_we_i;
	reg [3:0] ex_waddr_i;
	reg [15:0] ex_wdata_i;
	reg mem_we_i;
	reg [3:0] mem_waddr_i;
	reg [15:0] mem_wdata_i;

	// Outputs
	wire [2:0] alusel_o;
	wire [2:0] aluop_o;
	wire [15:0] reg0_data_o;
	wire [15:0] reg1_data_o;
	wire reg0_re_o;
	wire reg1_re_o;
	wire [3:0] reg0_addr_o;
	wire [3:0] reg1_addr_o;
	wire we_o;
	wire [3:0] waddr_o;
	wire stall_req;
	wire branch_flag_o;
	wire [15:0] branch_addr_o;

	// Instantiate the Unit Under Test (UUT)
	id uut (
		.rst(rst), 
		.pc_i(pc_i), 
		.inst_i(inst_i), 
		.reg0_data_i(reg0_data_i), 
		.reg1_data_i(reg1_data_i), 
		.ex_we_i(ex_we_i), 
		.ex_waddr_i(ex_waddr_i), 
		.ex_wdata_i(ex_wdata_i), 
		.mem_we_i(mem_we_i), 
		.mem_waddr_i(mem_waddr_i), 
		.mem_wdata_i(mem_wdata_i), 
		.alusel_o(alusel_o), 
		.aluop_o(aluop_o), 
		.reg0_data_o(reg0_data_o), 
		.reg1_data_o(reg1_data_o), 
		.reg0_re_o(reg0_re_o), 
		.reg1_re_o(reg1_re_o), 
		.reg0_addr_o(reg0_addr_o), 
		.reg1_addr_o(reg1_addr_o), 
		.we_o(we_o), 
		.waddr_o(waddr_o), 
		.stall_req(stall_req), 
		.branch_flag_o(branch_flag_o), 
		.branch_addr_o(branch_addr_o)
	);

	initial begin
		// Initialize Inputs
		rst = `RstEnable;
		pc_i = 0;
		inst_i = 0;
		reg0_data_i = 0;
		reg1_data_i = 0;
		ex_we_i = 0;
		ex_waddr_i = 0;
		ex_wdata_i = 0;
		mem_we_i = 0;
		mem_waddr_i = 0;
		mem_wdata_i = 0;

		// Wait 100 ns for global reset to finish
		#10;
		rst = `RstDisable ;
		pc_i = 1 ;
		reg0_data_i = 1 ;
		inst_i = 16'b0100101000001111 ;
		
        
		// Add stimulus here

	end
      
endmodule

