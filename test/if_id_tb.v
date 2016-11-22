

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:14:52 11/21/2016
// Design Name:   if_id
// Module Name:   D:/CPU/mcpu/test/if_id_tb.v
// Project Name:  cpu_test
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
	reg stall_pc;
	reg stall_id;
	reg stall_ex;
	reg [15:0] if_pc;
	reg [15:0] if_inst;

	// Outputs
	wire [15:0] id_pc;
	wire [15:0] id_inst;

	// Instantiate the Unit Under Test (UUT)
	if_id uut (
		.rst(rst), 
		.clk(clk), 
		.stall_pc(stall_pc), 
		.stall_id(stall_id), 
		.stall_ex(stall_ex), 
		.if_pc(if_pc), 
		.if_inst(if_inst), 
		.id_pc(id_pc), 
		.id_inst(id_inst)
	);
	
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end

	initial begin
		// Initialize Inputs
		rst = `RstEnable;
		stall_pc = `StallNo;
		stall_id = `StallNo;
		stall_ex = `StallNo;
		if_pc = 0;
		if_inst = 0;

		// Wait 100 ns for global reset to finish
		#10;
		rst = `RstDisable ;
		if_pc = 10 ;
		if_inst = 10 ;
		
		#10 ;
		stall_pc = `StallYes ;
		if_pc = 10 ;
		if_inst = 10 ;
		
		#10 ;
		stall_pc = `StallNo ;
		if_pc = 11 ;
		if_inst = 11 ;
		
		#10 ;
		stall_pc = `StallYes ;
		stall_id = `StallYes ;
		if_pc = 12 ;
		if_inst = 12 ;
		
		#10 ;
		stall_pc = `StallYes ;
		stall_id = `StallNo ;
		if_pc = 12 ;
		if_inst = 12 ;
		
		#10 ;
		stall_pc = `StallNo ;
		if_pc = 13 ;
		if_inst = 13 ;
		
		#10 ;
		rst = `RstEnable ;
		#10 ;
        
		// Add stimulus here

	end
      
endmodule

