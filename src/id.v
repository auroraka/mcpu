`include "defines.v"

module id(
	input rst,
	
	input wire[`InstAddrBus] pc_i,
	input wire[`InstBus] inst_i,
	
	input wire[`DataBus] reg0_data_i,
	input wire[`DataBus] reg1_data_i,
	
	//inst_type
	output reg[`AluSelBus] alusel_o,
	output reg[`AluOpBus] aluop_o,
	//read reg0 enable
	output reg reg0_re_o,
	output reg[`RegAddrBus] reg0_addr_o,
	//read reg1 enable
	output reg reg1_re_o,
	output reg[`RegAddrBus] reg1_addr_o
	//alu input 0,1
	output reg[`DataBus] reg0_o,
	output reg[`DataBus] reg1_o,
	//write_enable
	output reg we_o,
	output reg[`RegAddrBus] waddr_o,	
);

//more details see inst_list_types.pptx
wire[4:0] op=inst_i[15:11];
wire[2:0] op1=inst_i[10:8];
wire[2:0] op2=inst_i[7:5];
wire[4:0] op3=inst_i[4:0];
wire[1:0] op4=inst_i[1:0];
wire[2:0] rx=op1;
wire[2:0] ry=op2;
wire[2:0] rz=inst_i[4:2];
wire[15:0] immlu = {8'b0 , inst_i[7:0]};                                 //inst[7:0] -> unsigned extended imm
wire[15:0] imml = inst_i[7]? {8{1'b1}, inst_i[7:0]}:{8'b0 , inst_i[7:0]};//inst[7:0] ->   signed extended imm
wire[15:0] immsu={11'b0 , op3};                                          //inst[4:0] -> unsigned extended imm
wire[15:0] imms=op3[4]? {11{1'b1}, op3}:{11'b0 , op3};                   //inst[4:0] ->   signed extended imm

always @ (*) begin
	if (rst == `RstEnable) begin
		//默认为nop,不从reg读数据,不写数据
		alusel_o<=`EXE_SEL_SPECIAL;
		aluop_o<=`EXE_OP_NOP;
		reg0_re_o<=`ReadDisable;
		reg0_addr_o<=`ZeroRegAddr;
		reg1_re_o<=`ReadDisable;
		reg1_addr_o<=`ZeroRegAddr;
		reg0_o<=`ZeroData;
		reg1_o<=`ZeroData;
		we_o<=`WriteDisable;
		waddr_o<=`ZeroDataAddr;
	end else begin
		case (op)
			`OP_ADDSP3:begin
			
			end
			`OP_NOP:begin
				//default nop	
			end
			`OP_B:begin
			end
			`OP_BEQZ:begin
			end
			`OP_BNEZ:begin
			end
			`OP_SLL:begin
				case (op4)
					`OP4_SLL:begin
					end
					`OP4_SRL:begin
					end
					`OP4_SRA:begin
						
					end
				endcase
			end
			`OP_ADDIU3:begin 
			end
			`OP_ADDIU:begin
			end
			`OP_SLTI:begin
			end
			`OP_SLTUI:begin
			end
			`OP_BTEQZ:begin
				case (op1)
					`OP1_BTEQZ:begin
					end
					`OP1_BTNEZ:begin
					end
					`OP1_SW_RS:begin
					end
					`OP1_ADDSP:begin
					end
					`OP1_MTSP:begin
					end
				endcase
			end
			`OP_LI:begin
				alusel_o<=`EXE_SEL_REG;
				aluop_o<=`EXE_OP_LI;
				reg0_o<=immlu;
				we_o<=`WriteEnable;
				waddr_o<=rx;
			end
			`OP_CMPI:begin
			end
			`OP_MOVE:begin
			end
			`OP_LW_SP:begin
			end
			`OP_LW:begin
			end
			`OP_SW_SP:begin
			end
			`OP_SW:begin
			end
			`OP_ADDU:begin
				case (op4)
					`OP4_ADDU:begin
					end
					`OP4_SUBU:begin
					end
				endcase	
			end
			`OP_JR:begin
				case (op3)
					`OP3_JR:begin
						case (op2)
							`OP2_JR:begin
							end
							`OP2_JRRA:begin
							end
							`OP2_MFPC:begin
							end
							`OP2_JALR:begin
							end
						endcase
					end
					`OP3_SLT:begin
					end
					`OP3_SLTU:begin
					end
					`OP3_SLLV:begin
					end
					`OP3_SRLV:begin
					end
					`OP3_SRAV:begin
					end
					`OP3_CMP:begin
					end
					`OP3_NEG:begin
					end
					`OP3_AND:begin
					end
					`OP3_OR:begin
						
					end
					`OP3_NOT:begin
						
					end
					`OP3_XOR:begin
						
					end
				endcase
			end
			`OP_MFIH:begin
				case (op3)
					`OP3_MFIH:begin
						
					end
					`OP3_MTIH:begin
						
					end
				endcase	
			end	
			`OP_INT:begin
				
			end
		endcase
	end

end

endmodule