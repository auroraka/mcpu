`include "defines.v"

module ex_mem(
	input wire clk,
	input wire rst,
	input wire[`DataBus] ex_wdata,
	input wire[`RegAddrBus] ex_waddr,
	input wire ex_we,
	
	output reg[`DataBus] mem_wdata,
	output reg[`RegAddrBus] mem_waddr,
	output reg mem_we
);

always @ (posedge clk) begin
	if (rst == `RstEnable) begin
		mem_wdata<=`ZeroData;
		mem_waddr<=`ZeroDataAddr;
		mem_we<=`WriteDisable;
	end else begin
		mem_waddr<=ex_waddr;
		mem_wdata<=ex_wdata;
		mem_we<=ex_we;
	end

end

endmodule