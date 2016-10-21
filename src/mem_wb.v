`include "defines.v"

module mem_wb(
	input wire clk,
	input wire rst,
	input wire[`DataBus] mem_wdata,
	input wire[`RegAddrBus] mem_waddr,
	input wire mem_we,
	
	output reg[`DataBus] wb_wdata,
	output reg[`RegAddrBus] wb_waddr,
	output reg wb_we
);

always @ (posedge clk) begin
	if (rst == `RstEnable) begin
		wb_wdata<=`ZeroData;
		wb_waddr<=`ZeroDataAddr;
		wb_we<=`WriteDisable;
	end else begin
		wb_waddr<=mem_waddr;
		wb_wdata<=mem_wdata;
		wb_we<=mem_we;
	end

end

endmodule