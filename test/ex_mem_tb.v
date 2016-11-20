`timescale 1ns / 1ns
`include "D:\\CPU\\mcpu\\src\\defines.v"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:49:10 11/20/2016
// Design Name:   ex_mem
// Module Name:   D:/CPU/mcpu/test/ex_mem_tb.v
// Project Name:  mcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ex_mem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ex_mem_tb;

	// Inputs
	reg clk;
	reg rst;
	reg stall;
	reg [1:0] ex_memrw;
	reg [15:0] ex_memaddr;
	reg [15:0] ex_memdata;
	reg [15:0] ex_wdata;
	reg [3:0] ex_waddr;
	reg ex_we;

	// Outputs
	wire [15:0] mem_wdata;
	wire [3:0] mem_waddr;
	wire [1:0] mem_memrw;
	wire [15:0] mem_memaddr;
	wire [15:0] mem_memdata;
	wire mem_we;

	// Instantiate the Unit Under Test (UUT)
	ex_mem uut (
		.clk(clk), 
		.rst(rst), 
		.stall(stall), 
		.ex_memrw(ex_memrw), 
		.ex_memaddr(ex_memaddr), 
		.ex_memdata(ex_memdata), 
		.ex_wdata(ex_wdata), 
		.ex_waddr(ex_waddr), 
		.ex_we(ex_we), 
		.mem_wdata(mem_wdata), 
		.mem_waddr(mem_waddr), 
		.mem_memrw(mem_memrw), 
		.mem_memaddr(mem_memaddr), 
		.mem_memdata(mem_memdata), 
		.mem_we(mem_we)
	);
	
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	
	initial begin
		// Initialize Inputs
		rst = `RstEnable ;
		stall = `StallNo ;
		ex_memrw = `MemRW_Idle ;
		ex_memaddr = 0;
		ex_memdata = 0;
		ex_wdata = 0;
		ex_waddr = 0;
		ex_we = `WriteDisable;

		// Wait 100 ns for global reset to finish
		#10 ;
		rst = `RstDisable ;
		ex_wdata = 1 ;
		ex_waddr =1 ;
		ex_we = `WriteEnable ;
		
		#10 ;
		ex_wdata = 0 ;
		ex_waddr = 0 ;
		ex_we = `WriteDisable ;
		ex_memrw = `MemRW_Write ;
		ex_memaddr = 2 ;
		ex_memdata = 2 ;
		
		#10 ;
		stall = `StallYes ;
		ex_waddr = 1 ;
		ex_wdata = 0 ;
		ex_we = `WriteEnable ;
		ex_memrw = `MemRW_Read ;
		ex_memaddr = 2 ;
		ex_memdata = 0 ;
		
		#10 ;
		stall = `StallNo ;
		
		#10 
		rst = `RstEnable ;
		
        
		// Add stimulus here

	end
      
endmodule

