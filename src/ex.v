`include "defines.v"

module ex(
	input wire rst,

	input wire[`AluOpBus] aluop_i,
	input wire[`AluSelBus] alusel_i,
	input wire[`DataBus] reg0_i,
	input wire[`DataBus] reg1_i,
	input wire[`RegAddrBus] waddr_i,
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
		wdata_o<=16'h233;
		we_o<=we_i;
	end

end

endmodule