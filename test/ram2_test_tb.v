`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:39:22 11/21/2016
// Design Name:   ram2_test
// Module Name:   D:/CPU/mcpu/test/ram2_test_tb.v
// Project Name:  test_state
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram2_test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ram2_test_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [2:0] pc;
	reg [2:0] m_data;
	reg [2:0] m_addr;
	reg m_re;
	reg m_we;
	reg m_ce;

	// Outputs
	wire [1:0] state_o;
	wire [15:0] pc_addr;
	wire [15:0] mem_addr;
	wire [15:0] mem_data_i;
	wire mem_re;
	wire mem_ce;
	wire mem_we;

	// Instantiate the Unit Under Test (UUT)
	ram2_test uut (
		.clk(clk), 
		.rst(rst), 
		.pc(pc), 
		.m_data(m_data), 
		.state_o(state_o), 
		.m_addr(m_addr), 
		.m_re(m_re), 
		.m_we(m_we), 
		.m_ce(m_ce), 
		.pc_addr(pc_addr), 
		.mem_addr(mem_addr), 
		.mem_data_i(mem_data_i), 
		.mem_re(mem_re), 
		.mem_ce(mem_ce), 
		.mem_we(mem_we)
	);
	
	initial begin
		clk = 0 ;
		forever #5 clk = ~clk ;
	end 

	initial begin
		// Initialize Inputs
		rst = 0;
		pc = 0;
		m_data = 0;
		m_addr = 0;
		m_re = 1;
		m_we = 1;
		m_ce = 1;

		// Wait 100 ns for global reset to finish
		#10 ;
		rst = 1 ;
		pc = 1 ;
        
		#10 ;
		pc = 2 ;
		m_data = 3 ;
		m_addr = 3 ;
		m_re = 1 ;
		m_we = 0 ;
		m_ce = 0 ;
		
		#20 ;
		pc = 2 ;
		m_data = 0 ;
		m_addr = 4 ;
		m_re = 0 ;
		m_we = 1 ;
		
		#20 ;
		pc = 2 ;
		m_data = 0 ;
		m_re = 1 ;
		m_addr = 0 ;
		m_we = 1 ;
		m_ce =1 ;
		
		#10 ;
		// Add stimulus here

	end
      
endmodule

