`timescale 1ns / 1ns
`include "defines.v"
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:39:56 11/22/2016
// Design Name:   ram2_fake
// Module Name:   D:/CPU/mcpu/test/ram2_fake_tb.v
// Project Name:  cpu_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram2_fake
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ram2_fake_tb;

	// Inputs
	reg clk;
	reg [15:0] pc;
	reg [15:0] mem_data_i;
	reg [15:0] mem_addr_i;
	reg mem_re;
	reg mem_we;
	reg mem_ce;

	// Outputs
	wire [15:0] inst;
	wire [15:0] mem_data_o;

	// Instantiate the Unit Under Test (UUT)
	ram2_fake uut (
		.clk(clk), 
		.pc(pc), 
		.inst(inst), 
		.mem_data_i(mem_data_i), 
		.mem_data_o(mem_data_o), 
		.mem_addr_i(mem_addr_i), 
		.mem_re(mem_re), 
		.mem_we(mem_we), 
		.mem_ce(mem_ce)
	);

	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	
	initial begin
		// Initialize Inputs
		pc = 0;
		mem_data_i = 0;
		mem_addr_i = 0;
		mem_re = 0;
		mem_we = 0;
		mem_ce = 0;

		// Wait 100 ns for global reset to finish
		#10;
		pc = 1 ;
		
		#10 ;
		pc = 2 ;
		
		#10 ;
		pc = 3 ;
		
		#10 ;
        
		// Add stimulus here

	end
      
endmodule

