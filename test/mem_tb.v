`timescale 1ns / 1ns
`include "defines.v"
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:01:06 11/22/2016
// Design Name:   mem
// Module Name:   D:/CPU/mcpu/test/mem_tb.v
// Project Name:  cpu_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mem_tb;

	// Inputs
	reg rst;
	reg we_i;
	reg [3:0] waddr_i;
	reg [15:0] wdata_i;
	reg [15:0] memdata_i;
	reg [1:0] memrw_i;
	reg [15:0] memaddr_i;
	reg [15:0] ram1_data_i;
	reg [15:0] ram2_data_i;

	// Outputs
	wire we_o;
	wire [3:0] waddr_o;
	wire [15:0] wdata_o;
	wire [15:0] ram1_data_o;
	wire [15:0] ram1_addr_o;
	wire ram1_re_o;
	wire ram1_we_o;
	wire ram1_ce_o;
	wire [15:0] ram2_data_o;
	wire [15:0] ram2_addr_o;
	wire ram2_re_o;
	wire ram2_we_o;
	wire ram2_ce_o;
	wire stall_req;

	// Instantiate the Unit Under Test (UUT)
	mem uut (
		.rst(rst), 
		.we_i(we_i), 
		.waddr_i(waddr_i), 
		.wdata_i(wdata_i), 
		.memdata_i(memdata_i), 
		.memrw_i(memrw_i), 
		.memaddr_i(memaddr_i), 
		.we_o(we_o), 
		.waddr_o(waddr_o), 
		.wdata_o(wdata_o), 
		.ram1_data_i(ram1_data_i), 
		.ram1_data_o(ram1_data_o), 
		.ram1_addr_o(ram1_addr_o), 
		.ram1_re_o(ram1_re_o), 
		.ram1_we_o(ram1_we_o), 
		.ram1_ce_o(ram1_ce_o), 
		.ram2_data_i(ram2_data_i), 
		.ram2_data_o(ram2_data_o), 
		.ram2_addr_o(ram2_addr_o), 
		.ram2_re_o(ram2_re_o), 
		.ram2_we_o(ram2_we_o), 
		.ram2_ce_o(ram2_ce_o), 
		.stall_req(stall_req)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		we_i = 0;
		waddr_i = 0;
		wdata_i = 0;
		memdata_i = 0;
		memrw_i = 0;
		memaddr_i = 0;
		ram1_data_i = 0;
		ram2_data_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

