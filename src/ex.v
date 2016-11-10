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

wire [`DataBus] special_data;
wire [`DataBus] reg_data;
wire [`DataBus] jump_data;
wire [`DataBus] lw_data;
wire [`DataBus] cmp_data;
wire [`DataBus] logic_data;
wire [`DataBus] shift_data;
wire [`DataBus] arith_data;

always @(*) begin
	if (alusel_i == `EXE_SEL_SPECIAL) begin
		case (aluop_i)
			`EXE_OP_NOP:begin
				special_data<=`ZeroData;
			end
			default:begin
				special_data<=`ZeroData;
			end
		endcase
	end else begin
		special_data<=`ZeroData;
	end
end

always @ (*) begin
	if (alusel_i==`EXE_SEL_REG) begin
		case (aluop_i)
			`EXE_OP_LI:begin
				reg_data<=reg0_i;
			end
			default:begin
				reg_data<=`ZeroData;
			end
		endcase	
	end else begin
		reg_data<=`ZeroData;
	end
end

always @ (*) begin
	if (rst == `RstEnable) begin
		waddr_o<=`ZeroDataAddr;
		wdata_o<=`ZeroData;
		we_o<=`WriteDisable;
	end else begin
		we_o<=we_i;
		waddr_o<=waddr_i;
		case (alusel_i)
			`EXE_SEL_SPECIAL:begin
				wdata_o<=special_data;	
			end
			`EXE_SEL_REG:begin
				wdata_o<=reg_data;
			end
			`EXE_SEL_JUMP:begin
				wdata_o<=jump_data;
			end
			`EXE_SEL_LW:begin
				wdata_o<=lw_data;
			end
			`EXE_SEL_CMP:begin
				wdata_o<=cmp_data;
			end
			`EXE_SEL_LOGIC:begin
				wdata_o<=logic_data;
			end
			`EXE_SEL_SHIFT:begin
				wdata_o<=shift_data;
			end
			`EXE_SEL_ARITH:begin
				wdata_o<=arith_data;
			end
		endcase
	end
end


endmodule