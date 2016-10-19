`include "defines.v"

module id_id(
	input wire rst,
	input wire clk,
	
	input wire[`InstAddrBus] ip_pc,
	input wire[`InstBus] if_inst,
	output reg[`InstAddrBus] id_pc,
	output reg[`InstBus] id_inst
);

always @ (posedge clk) begin
	if (rst == `RstEnable) begin
		id_pc<=`ZeroWord;
		id_inst<=`ZeroWord;
		
	end else begin
	
	end
end