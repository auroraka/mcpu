`include "defines.v"

module if_id(
	input wire rst,
	input wire clk,

	input wire[`InstAddrBus] if_pc,
	input wire[`InstBus] if_inst,

	output reg[`InstAddrBus] id_pc,
	output reg[`InstBus] id_inst
);

always @ (posedge clk) begin
	if (rst == `RstEnable) begin
		id_pc<=`ZeroInstAddr;
		id_inst<=`ZeroInst;
	end else begin
		id_pc<=if_pc;
		id_inst<=if_inst;
	end
end

endmodule