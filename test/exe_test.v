`timescale 1ns / 1ns
module exe_test ;

// input
reg [2:0] aluop_i  ;
reg [2:0] alusel_i ;
reg [15:0] reg0_i ;
reg [15:0] reg1_i ;
reg [3:0] waddr_i ;
reg we_i ;
reg rst ;

//output
//wire [2:0] aluop_o ;
wire we_o ;
wire [3:0] waddr_o ;
wire [15:0] wdata_o ;
wire [1:0] memrw_o ;
wire [15:0]	memaddr_o ;
wire [15:0] memdata_o ;
wire stallreq ;

// Instantiate the Unit Under Test (UUT)
exe uut(
	.aluop_i(aluop_i),
	.alusel_i(alusel_i),
	.reg0_i(reg0_i),
	.reg1_i(reg1_i),
	.waddr_i(waddr_i),
	.we_i(we_i),
	.stallreq(stallreq),
	.rst(rst),
	.we_o(we_o),
	.waddr_o(waddr_o),
	.wdata_o(wdata_o),
	.memrw_o(memrw_o),
	.memdata_o(memdata_o),
	.memaddr_o(memaddr_o)
) ;

initial begin
	reg0_i = 0 ;
	reg1_i = 0 ;
	aluop_i = 0 ;
	alusel_i = 0 ;
	waddr_i = 1 ;
	we_i = 1 ;
	rst = 1 ;
	
	#10 ;
	alusel_i = 3'b011 ;
	aluop_i = 3'b000 ;
	reg0_i = 8 ;
	reg1_i = 1 ;
/* 	aluop_i = #10 3'b001 ;
	aluop_i = #10 3'b010 ;
	aluop_i = #10 3'b001 ;
	aluop_i = #10 3'b100 ;
	
	#10
	alusel_i = 3'b101 ;
	aluop_i = 3'b000 ;
	aluop_i = #10 3'b001 ;
	aluop_i = #10 3'b010 ;
	
	# 20 ;
	alusel_i = 3'b100 ;
	aluop_i = 3'b000 ;
	# 20 
	reg0_i = 1 ;
	# 20 ;
	aluop_i = 3'b001 ;
	# 20 ;
	reg0_i = 8 ; */
/*	#10 ;
	alusel_i = 3'b110 ;
	reg1_i = #5 0 ;
	#10 ;
	aluop_i = 3'b001 ;
	reg1_i = 1 ;
	#10 ;
	aluop_i = 3'b010 ;
	reg0_i = 16'b1000000001111111 ;
	reg1_i = #5 0 ;
	#10 ;
	aluop_i = 3'b011 ;
	reg1_i = #5 4 ;
	#10 ;
	alusel_i = 3'b000 ;
	#10 ;
	alusel_i = 3'b011 ;
	aluop_i = 3'b000 ;
	#10 ;
	alusel_i = 3'b001 ;*/
	aluop_i = #5 3'b001 ;
	aluop_i = #5 3'b010 ;
	aluop_i = #5 3'b011 ;
	aluop_i = #5 3'b100 ;
	alusel_i = #5 3'b001 ;
	aluop_i = 0 ;
	aluop_i = #5 3'b001 ;
	alusel_i = #5 3'b111 ;
//	aluop_i = #5 3'b101 ;
	rst = #10 0 ;
	#10 ;
end

endmodule