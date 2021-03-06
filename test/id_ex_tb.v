`timescale 1ns / 1ns
`include "D:\\CPU\\mcpu\\src\\defines.v"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:34:35 11/21/2016
// Design Name:   id_ex
// Module Name:   D:/CPU/mcpu/test/id_ex_tb.v
// Project Name:  cpu_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: id_ex
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module id_ex_tb;

	// Inputs
	reg rst;
	reg clk;
	reg stall_pc;
	reg stall_id;
	reg stall_ex;
	reg [2:0] id_aluop;
	reg [2:0] id_alusel;
	reg [15:0] id_reg0;
	reg [15:0] id_reg1;
	reg [3:0] id_waddr;
	reg id_we;

	// Outputs
	wire [2:0] ex_aluop;
	wire [2:0] ex_alusel;
	wire [15:0] ex_reg0;
	wire [15:0] ex_reg1;
	wire [3:0] ex_waddr;
	wire ex_we;

	// Instantiate the Unit Under Test (UUT)
	id_ex uut (
		.rst(rst), 
		.clk(clk), 
		.stall_pc(stall_pc), 
		.stall_id(stall_id), 
		.stall_ex(stall_ex), 
		.id_aluop(id_aluop), 
		.id_alusel(id_alusel), 
		.id_reg0(id_reg0), 
		.id_reg1(id_reg1), 
		.id_waddr(id_waddr), 
		.id_we(id_we), 
		.ex_aluop(ex_aluop), 
		.ex_alusel(ex_alusel), 
		.ex_reg0(ex_reg0), 
		.ex_reg1(ex_reg1), 
		.ex_waddr(ex_waddr), 
		.ex_we(ex_we)
	);
	
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end

	initial begin
		// Initialize Inputs
		rst = `RstEnable ;
		stall_pc = `StallNo ;
		stall_id = `StallNo;
		stall_ex = `StallNo;
		id_aluop = 0;
		id_alusel = 0;
		id_reg0 = 0;
		id_reg1 = 0;
		id_waddr = 0;
		id_we = `WriteDisable ;

		// Wait 100 ns for global reset to finish
		#10;
		rst = `RstDisable ;
		id_aluop = 1 ;
		id_alusel = 1 ;
		id_reg0 = 3 ;
		id_reg1 = 2 ;
		id_waddr = 4 ;
		id_we = `WriteEnable ;
		
		#10;
		stall_id = `StallYes ;
		stall_pc = `StallYes ;
		id_aluop = 2 ;
		id_alusel = 3 ;
		id_reg0 = 1 ;
		id_reg1 = 1 ;
		id_waddr = 1 ;
		id_we = `WriteEnable ;
		
		#10 ;
		stall_id = `StallNo ;
		
		#10 ;
		stall_pc = `StallNo ;
		id_alusel = 1 ;
		id_aluop = 2 ;
		id_reg0 = 3 ;
		id_reg1 = 0 ;
		id_waddr = 0 ;
		id_we = `WriteDisable ;
		
		#10 ;
		rst = `RstEnable ;
		
		#10 ;
        
		// Add stimulus here

	end
      
endmodule

