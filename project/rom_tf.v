`timescale 1ns / 1ps
`include "defines.v"
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:19:14 11/17/2016
// Design Name:   inst_rom
// Module Name:   F:/2016FALL/JY/cpu/mcpu/rom_tf.v
// Project Name:  mcpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: inst_rom
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rom_tf;

	// Inputs
	reg ce;
	reg [`InstAddrBus] addr;
	//outputs
	reg [`InstBus] inst;
	// Instantiate the Unit Under Test (UUT)
	inst_rom uut (
		.ce(ce),
		.addr(addr),
		.inst(inst)
	);

	initial begin
		// Initialize Inputs
		ce = `ChipDisable;
		addr = 16'b0;
		// Wait 100 ns for global reset to finish
		#100;
		ce = `ChipEnable;
		#10
		addr = addr + 1;
		#10
		addr = addr + 1;
		#10
		addr = addr + 1;
		#10
		addr = addr + 1;
		#10
		addr = addr + 1;
		// Add stimulus here
	end
      
endmodule
