`include "defines.v"
`timescale 1ns/1ps

module sopc_tb();

reg clk,rst;

sopc sopc0(
	.clk(clk),
	.rst(rst)
);

initial begin
	clk <= 1'b0;
	forever #10 clk<=~clk;
end

initial begin
	rst<=`RstEnable;
	#100 rst<=`RstDisable;
	#1000 $stop;
end

endmodule;