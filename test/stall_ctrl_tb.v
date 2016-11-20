`timescale 1ns / 1ns
`include "D:\\CPU\\mcpu\\src\\defines.v"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:53:31 11/20/2016
// Design Name:   stall_ctrl
// Module Name:   D:/CPU/mcpu/test/stall_ctrl_tb.v
// Project Name:  mcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stall_ctrl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stall_ctrl_tb;

	// Inputs
	reg rst;
	reg stallreq_id;
	reg stallreq_ex;
	reg stallreq_mem;

	// Outputs
	wire stall_pc;
	wire stall_if_id;
	wire stall_id_ex;
	wire stall_ex_mem;
	wire stall_mem_wb;

	// Instantiate the Unit Under Test (UUT)
	stall_ctrl uut (
		.rst(rst), 
		.stallreq_id(stallreq_id), 
		.stallreq_ex(stallreq_ex), 
		.stallreq_mem(stallreq_mem), 
		.stall_pc(stall_pc), 
		.stall_if_id(stall_if_id), 
		.stall_id_ex(stall_id_ex), 
		.stall_ex_mem(stall_ex_mem), 
		.stall_mem_wb(stall_mem_wb)
	);

	initial begin
		// Initialize Inputs
		rst = `RstEnable;
		stallreq_id = `StallNo;
		stallreq_ex = `StallNo;
		stallreq_mem = `StallNo;

		// Wait 100 ns for global reset to finish
		#10 ;
		rst = `RstDisable ;
		stallreq_id = `StallYes ;
		
		#10 ;
		stallreq_id = `StallNo ;
		stallreq_mem = `StallYes ;
		
		#10 ;
		stallreq_ex = `StallYes ;
		stallreq_mem = `StallNo ;
		
		#10 ;
		stallreq_mem = `StallYes ;
		stallreq_id = `StallYes ;
		stallreq_ex = `StallNo ;
		
		#10 ;
		rst = `RstEnable ;
		
		#10 ;
        
		// Add stimulus here

	end
      
endmodule

