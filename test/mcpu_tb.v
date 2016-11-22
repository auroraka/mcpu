//mcputestbench
`timescale 1ns / 1ns
`include "defines.v"
//`include "D:\\CPU\\mcpu\\src\\defines.v"

module mcpu_tb ;

	//input
	reg rst ;
	reg clk ;

	//output
	wire [15:0] id_pc_i ;
	wire [15:0] id_inst_i ;

	mcpu uut(
		.rst(rst),
		.clk(clk),
		
		.id_pc_i(id_pc_i),
		.id_inst_i(id_inst_i)
	) ;
	
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	
	initial begin
		rst = `RstEnable ;
		
		#10 ;
		rst = `RstDisable ;
		
		#1000 $stop ;
	end
	
endmodule 