`include "defines.v"
//`include "D:\\CPU\\mcpu\\src\\defines.v"

module if_id(
	input wire rst,
	input wire clk,
	input wire stall,
	input wire[`InstAddrBus] if_pc,
	input wire[`InstBus] if_inst,

	output reg[`InstAddrBus] id_pc,
	output reg[`InstBus] id_inst
);

always @ (posedge clk) begin
	if (rst == `RstEnable) 
	begin
		id_pc<=`ZeroInstAddr;
		id_inst<=`ZeroInst;
	end
	else if (stall == `StallNo)
	begin
		id_pc<=if_pc;
		id_inst<=if_inst;
	end
end

endmodule