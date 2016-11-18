`timescale 1ns / 1ns
module RegisterFile_test ;

// input
reg re_0 ;
reg re_1 ;
reg [3:0] raddr0 ;
reg [3:0] raddr1 ;
reg [3:0] waddr ;
reg we ;
reg [15:0] wdata ;
reg rst ;
reg clk ;

// output
wire [15:0] rdata0 ;
wire [15:0] rdata1 ;

RegisterFile uut(
	.re_0(re_0),
	.re_1(re_1),
	.raddr0(raddr0),
	.raddr1(raddr1),
	.waddr(waddr),
	.we(we),
	.wdata(wdata),
	.rst(rst),
	.clk(clk),
	.rdata0(rdata0),
	.rdata1(rdata1)
) ;

initial begin
		clk=0;
		forever #5 clk=~clk;
	end

initial begin
	rst = 0 ;
	re_0 = 1 ;
	re_1 = 1 ;
	raddr0 = 1 ;
	raddr1 = 2 ;
	we = 1 ;
	wdata = 0 ;
	waddr = 0 ;
	
	#5
	rst = 1 ;
	we = 0 ;
	wdata = 1 ;
	waddr = 3 ;
	
	#10 
	we = 1 ;
	wdata = 0 ;
	waddr = 0 ;
	re_0 = 0 ;
	re_1 = 0 ;
	raddr0 = 1 ;
	raddr1 = 2 ;
	
	#10
	we = 1 ;
	re_0 = 0 ;
	raddr0 = 3 ;
	re_1 = 1 ;
	raddr1 = 0 ;
	
	#10 
	we = 0 ;
	waddr = 4 ;
	wdata = 8 ;
	re_0 = 0 ;
	raddr0 = 4 ;
	re_1 = 0 ;
	raddr1 = 3 ;
	
	#5
	we = 0 ;
	waddr = 3 ;
	wdata = 3 ;

	#10 ;
	we = 1 ;
	re_0 = 0 ;
	re_1 = 0 ;
	raddr0 = 4 ;
	raddr1 = 3 ;
	
	#10 ;
	rst = 0 ;
	
	//#10 $stop ;
end 

endmodule