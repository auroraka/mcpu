`include "defines.v"

module mem(
	input wire rst,

	input wire[`RegAddrBus] waddr_i,
	input wire[`DataBus] wdata_i,
	input wire we_i,
	
	output reg[`RegAddrBus] waddr_o,
	output reg[`DataBus] wdata_o,
	output reg we_o
);

always @ (*) begin
	if (rst == `RstEnable) begin
		waddr_o<=`ZeroDataAddr;
		wdata_o<=`ZeroData;
		we_o<=`WriteDisable;
	end else begin
		waddr_o<=waddr_i;
		wdata_o<=waddr_o;
		we_o<=we_i;
	end

end

endmodule