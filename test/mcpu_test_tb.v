//mcpu_test
`timescale 1ns / 1ns
`include "defines.v"

module mcpu_test_tb ;

	//input
	reg rst ;
	reg clk ;

	//output
	wire [15:0] pc_test ;

	mcpu_test mcpu0(
		.rst(rst),
		.clk(clk),
		
		.pc_test(pc_test)
	) ;
	
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	
	initial begin
		rst = `RstEnable ;
		
		#30 ;
		rst = `RstDisable ;
		
		#10000 $stop ;
	end
	
endmodule  