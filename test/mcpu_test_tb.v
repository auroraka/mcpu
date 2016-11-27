//mcpu_test
`timescale 1ns / 1ns
`include "defines.v"

module mcpu_test_tb ;

	//input
	reg rst ;
	reg clk ;
	reg stallreq_cpu ;

	//output
	wire [15:0] pc_test ;

	mcpu_test mcpu0(
		.rst(rst),
		.clk(clk),
		.stallreq_cpu(stallreq_cpu),
		
		.pc_test(pc_test)
	) ;
	
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	
	initial begin
		rst = `RstEnable ;
		stallreq_cpu = `StallNo ;
		
		#20 ;
		rst = `RstDisable ;
		
		#10000 $stop ;
	end
	
endmodule  