`include "defines.v"
`include "pack.vhd"

module id_ex(
	input wire rst,
	input wire clk,
	input wire stall,
	input wire[`AluOpBus] id_aluop,
	input wire[`AluSelBus] id_alusel,
	input wire[`DataBus] id_reg0,
	input wire[`DataBus] id_reg1,
	input wire[`RegAddrBus] id_waddr,
	input wire id_we,
	
	output reg[`AluOpBus] ex_aluop,
	output reg[`AluSelBus] ex_alusel,
	output reg[`DataBus] ex_reg0,
	output reg[`DataBus] ex_reg1,
	output reg[`RegAddrBus] ex_waddr,
	output reg ex_we
);

always @ (posedge clk) begin
	if (stall == `StallNo)
	begin
		if (rst == `RstEnable) begin
			ex_aluop<=`EXE_OP_NOP;
			ex_alusel<=`EXE_SEL_NOP;
			ex_waddr<=`ZeroDataAddr;
			ex_we<=`WriteDisable;
		end else begin
			ex_aluop<=id_aluop;
			ex_alusel<=id_alusel;
			ex_waddr<=id_waddr;
			ex_we<=id_we;
		end
	end
end 

endmodule