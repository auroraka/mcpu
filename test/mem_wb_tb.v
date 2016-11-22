`timescale 1ns / 1ns
`include "D:\\CPU\\mcpu\\src\\defines.v"
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:01:41 11/20/2016
// Design Name:   mem_wb
// Module Name:   D:/CPU/mcpu/test/mem_wb_tb.v
// Project Name:  mcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mem_wb
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mem_wb_tb;

	// Inputs
	reg clk;
	reg rst;
	//reg stall;
	reg [15:0] mem_wdata;
	reg [3:0] mem_waddr;
	reg mem_we;

	// Outputs
	wire [15:0] wb_wdata;
	wire [3:0] wb_waddr;
	wire wb_we;

	// Instantiate the Unit Under Test (UUT)
	mem_wb uut (
		.clk(clk), 
		.rst(rst), 
		//.stall(stall), 
		.mem_wdata(mem_wdata), 
		.mem_waddr(mem_waddr), 
		.mem_we(mem_we), 
		.wb_wdata(wb_wdata), 
		.wb_waddr(wb_waddr), 
		.wb_we(wb_we)
	);

	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	
	initial begin
		// Initialize Inputs
		rst = `RstEnable;
		//stall = `StallNo;
		mem_wdata = 0;
		mem_waddr = 0;
		mem_we = `WriteDisable;

		#10 ;
		rst = `RstDisable ;
		mem_waddr = 1 ;
		mem_wdata = 1 ;
		mem_we = `WriteEnable ;
		
		#10 ;
		mem_waddr = 0 ;
		mem_wdata = 0 ;
		mem_we = `WriteDisable ;
		
		#10 ;
		//stall = `StallYes ;
		mem_waddr = 2 ;
		mem_wdata = 2 ;
		mem_we = `WriteEnable ;
		
		
		#15 ;
		rst = `RstEnable ;
		//rst = `RstEnable ;
        
		// Add stimulus here

	end
      
endmodule

