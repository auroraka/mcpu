`timescale 1ns / 1ns
`include "D:\\CPU\\mcpu\\src\\defines.v"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:21:30 11/21/2016
// Design Name:   pc
// Module Name:   D:/CPU/mcpu/test/pc_tb.v
// Project Name:  cpu_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pc_tb;

	// Inputs
	reg stall;
	reg clk;
	reg rst;
	reg branch_flag_o;
	reg [15:0] branch_addr_o;

	// Outputs
	wire [15:0] pc;

	// Instantiate the Unit Under Test (UUT)
	pc uut (
		.stall(stall), 
		.clk(clk), 
		.rst(rst), 
		.branch_flag_o(branch_flag_o), 
		.branch_addr_o(branch_addr_o), 
		.pc(pc)
	);

	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	
	initial begin
		// Initialize Inputs
		stall = `StallNo;
		rst = `RstEnable;
		branch_flag_o = `BranchFlagDown;
		branch_addr_o = `ZeroInstAddr;

		// Wait 100 ns for global reset to finish
		#10;
		rst = `RstDisable ;
		
		#20 ;
		branch_flag_o = `BranchFlagUp ;
		branch_addr_o = 10 ;
		
		#10 ;
		branch_flag_o = `BranchFlagUp ;
		stall = `StallYes ;
		branch_addr_o = 8 ;
		
		#10 ;
		stall = `StallNo ;
		branch_flag_o = `BranchFlagDown ;
		branch_addr_o = 0 ;
		
		#20 ;
		branch_flag_o = `BranchFlagUp ;
		branch_addr_o = 10 ;
		
		
		#15 ;
		rst = `RstEnable ;
		
		#10 ;
		// Add stimulus here

	end
      
endmodule

