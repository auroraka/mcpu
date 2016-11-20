`include "D:\\CPU\\mcpu\\src\\defines.v"
`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:05:32 11/20/2016
// Design Name:   if_id
// Module Name:   D:/CPU/mcpu/project/if_id_tb.v
// Project Name:  mcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: if_id
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module if_id_tb;

	// Inputs
	reg rst;
	reg clk;
	reg stall;
	reg [15:0] if_pc;
	reg [15:0] if_inst;

	// Outputs
	wire [15:0] id_pc;
	wire [15:0] id_inst;

	// Instantiate the Unit Under Test (UUT)
	if_id uut (
		.rst(rst), 
		.clk(clk), 
		.stall(stall), 
		.if_pc(if_pc), 
		.if_inst(if_inst), 
		.id_pc(id_pc), 
		.id_inst(id_inst)
	);
	
	initial begin
		clk = 0 ;
		forever #5 clk=~clk;
	end

	initial begin
		// Initialize Inputs
		rst = `RstEnable ;
		stall = `StallNo ;
		if_pc = 0;
		if_inst = 0;

		#10 ;
		rst = `RstDisable ;
		if_pc = 1 ;
		if_inst = 1 ;
		
		#10 ;
		if_pc = 3 ;
		if_inst = 8 ;
		
		#10 ;
		stall = `StallYes ;
		if_pc = 4 ;
		if_inst = 1 ;
		
		#10 ;
		stall = `StallNo ;
		
		#20 ;
		rst = `RstEnable ;
        
		// Add stimulus here

	end
      
endmodule

