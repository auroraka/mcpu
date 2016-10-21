`include "defines.v"

module pc(
	input wire clk,
	input wire rst,
	output reg[`InstAddrBus] pc,
	output reg ce
);

always @ (posedge clk) begin
	if (rst == `RstEnable) begin
		ce<=`ChipDisable;
	end else begin
		ce<=`ChipEnable;
	end
end

always @ (posedge clk) begin
	if (ce <= `ChipDisable) begin
		pc<=`ZeroInst;
	end else begin
		pc<=pc+4'h2;
	end
end

endmodule