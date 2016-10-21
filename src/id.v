`include "defines.v"

module id(
	input rst,
	
	input wire[`InstAddrBus] pc_i,
	input wire[`InstBus] inst_i,
	
	input wire[`DataBus] reg0_data_i,
	input wire[`DataBus] reg1_data_i,
	
	output reg[`AluOpBus] aluop_o,
	output reg[`AluSelBus] alusel_o,
	output reg[`DataBus] reg0_o,
	output reg[`DataBus] reg1_o,
	output reg[`RegAddrBus] waddr_o,
	output reg we_o,
	
	output reg reg0_re_o,
	output reg[`RegAddrBus] reg0_addr_o,
	output reg reg1_re_o,
	output reg[`RegAddrBus] reg1_addr_o
);

always @ (*) begin
	if (rst == `RstEnable) begin
		aluop_o<=`EXE_OP_NOP;
		alusel_o<=`EXE_SEL_NOP;
		waddr_o<=`ZeroDataAddr;
		we_o<=`WriteDisable;
	end else begin
		aluop_o<=`EXE_OP_ADD;
		alusel_o<=`EXE_SEL_ADD;
		waddr_o<=`ZeroDataAddr;
		we_o<=`WriteEnable;
	end

end

endmodule