`include "defines.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:09:12 10/25/2016 
// Design Name: 
// Module Name:    ram_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


module ram_controller(
	input en, re, we,
	input [15:0]data_in,
	input [17:0]addr_in,
	output reg ram_en, ram_oe, ram_we,
	inout wire [15:0] data
    );
	
initial
begin
	ram_en=RamDisenable;
	ram_oe=0;
	ram_we=1;
end

reg flag;

assign data = (flag==0)?16'bz:data_in;
assign ram_en = en ;

always @(*)
begin
	if(en==RamDisenable)
		begin
			data_out=16'b0;
		end
	else
		begin
			if(we==1)//write
				begin
					ram_oe=1;
					flag=1;
					ram_we=0;
				end
			else if(re==1)//read
				begin
					ram_oe=0;
					flag=0;
				end
			if(flag==1)
				begin
					ram_we=1;
				end
		end
end

endmodule
