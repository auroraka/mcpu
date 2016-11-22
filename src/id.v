`include "defines.v"
//`include "D:\\CPU\\mcpu\\src\\defines.v"
module id(
	input rst,
	
	input wire[`InstAddrBus] pc_i,
	input wire[`InstBus] inst_i,
	
	input wire[`DataBus] reg0_data_i,
	input wire[`DataBus] reg1_data_i,
	
	input wire ex_we_i,
	input wire[`RegAddrBus] ex_waddr_i,
	input wire[`DataBus] ex_wdata_i,

	input wire mem_we_i,
	input wire[`RegAddrBus] mem_waddr_i,
	input wire[`DataBus] mem_wdata_i,

	//input wire[`DataBus] reg0_data_i,
	//input wire[`DataBus] reg1_data_i,


	output reg[`AluSelBus] alusel_o,
	output reg[`AluOpBus] aluop_o,
	output reg[`DataBus] reg0_data_o,
	output reg[`DataBus] reg1_data_o,
	output reg reg0_re_o,
	output reg reg1_re_o,
	output reg[`RegAddrBus] reg0_addr_o,
	output reg[`RegAddrBus] reg1_addr_o,
	output reg we_o,
	output reg[`RegAddrBus] waddr_o,	

	output reg stall_req,
	output reg branch_flag_o,
	output reg[`InstAddrBus] branch_addr_o
);

reg[`DataBus] reg0_o;
reg[`DataBus] reg1_o;

//more details see inst_list_types.pptx
wire[4:0] op=inst_i[15:11];
wire[2:0] op1=inst_i[10:8];
wire[2:0] op2=inst_i[7:5];
wire[4:0] op3=inst_i[4:0];
wire[1:0] op4=inst_i[1:0];
wire[2:0] rx=op1;
wire[2:0] ry=op2;
wire[2:0] rz=inst_i[4:2];

//inst[7:0] -> unsigned extended imm
wire[15:0] immlu = {8'b0 , inst_i[7:0]};                                 

//inst[7:0] ->   signed extended imm
wire[15:0] imml = inst_i[7]? {8'b11111111, inst_i[7:0]}:{8'b0 , inst_i[7:0]};

//inst[4:0] -> unsigned extended imm
wire[15:0] immsu={11'b0 , op3};                                         

//inst[4:0] ->   signed extended imm
wire[15:0] imms=op3[4]? {11'b11111111111, op3}:{11'b0 , op3};                   

//inst[10:0] -> b imm
wire[15:0] immb = inst_i[10]? {5'b11111, inst_i[10:0]}:{5'b0 , inst_i[10:0]};
wire reg0_eq_zero = (reg0_data_i == 0);
wire reg1_eq_zero = (reg1_data_i == 0);

always @ (*) begin
	if (rst == `RstEnable) begin
		//默认为nop,不从reg读数据,不写数据
		alusel_o<=`EXE_SEL_SPECIAL;
		aluop_o<=`EXE_OP_NOP;
		we_o<=`WriteDisable;
		waddr_o<=`ZeroDataAddr;
		reg0_o<=`ZeroData;
		reg1_o<=`ZeroData;
		reg0_re_o<=`ReadDisable;
		reg1_re_o<=`ReadDisable;
		reg0_addr_o<=`ZeroRegAddr;
		reg1_addr_o<=`ZeroRegAddr;
		
		stall_req<=`StallNo;
		branch_flag_o<=`BranchFlagDown;
		branch_addr_o<=`ZeroInstAddr;

	end else begin
		//默认为nop,不从reg读数据,不写数据
		alusel_o<=`EXE_SEL_SPECIAL;
		aluop_o<=`EXE_OP_NOP;
		we_o<=`WriteDisable;
		waddr_o<=`ZeroDataAddr;
		reg0_o<=`ZeroData;
		reg1_o<=`ZeroData;
		reg0_re_o<=`ReadDisable;
		reg1_re_o<=`ReadDisable;
		reg0_addr_o<=`ZeroRegAddr;
		reg1_addr_o<=`ZeroRegAddr;
		
		stall_req<=`StallNo;
		branch_flag_o<=`BranchFlagDown;
		branch_addr_o<=`ZeroInstAddr;
		case (op)
			`OP_ADDSP3:begin
					
			end
			`OP_NOP:begin
				//default nop	
			end
			`OP_B:begin
				alusel_o<=`EXE_SEL_JUMP;
				aluop_o<=`EXE_OP_B;
				branch_addr_o<=pc_i+immb;
				branch_flag_o<=`BranchFlagUp;	
			end
			`OP_BEQZ:begin
				alusel_o<=`EXE_SEL_JUMP;
				aluop_o<=`EXE_OP_BEQZ;
				reg0_re_o<=`ReadEnable;
				reg0_addr_o<=rx;
				branch_addr_o<=pc_i+imml;
				branch_flag_o<=reg0_eq_zero;	
			end
			`OP_BNEZ:begin
				alusel_o<=`EXE_SEL_JUMP;
				aluop_o<=`EXE_OP_BNEZ;
				reg0_re_o<=`ReadEnable;
				reg0_addr_o<=rx;
				branch_addr_o<=pc_i+imml;
				branch_flag_o<=~reg0_eq_zero;	
			end
			`OP_SLL:begin
				case (op4)
					`OP4_SLL:begin
						alusel_o<=`EXE_SEL_SHIFT;
						aluop_o<=`EXE_OP_SLL;
						we_o<=`WriteEnable;
						waddr_o<=rx;
						reg0_o<=reg0_data_i;
						reg1_o<=immsu;
						reg0_re_o<=`ReadEnable;
						reg0_addr_o<=ry;
					end
					`OP4_SRL:begin
						alusel_o<=`EXE_SEL_SHIFT;
						aluop_o<=`EXE_OP_SRL;
						we_o<=`WriteEnable;
						waddr_o<=rx;
						reg0_o<=reg0_data_i;
						reg1_o<=immsu;
						reg0_re_o<=`ReadEnable;
						reg0_addr_o<=ry;
					end
					`OP4_SRA:begin
						alusel_o<=`EXE_SEL_SHIFT;
						aluop_o<=`EXE_OP_SRA;
						we_o<=`WriteEnable;
						waddr_o<=rx;
						reg0_o<=reg0_data_i;
						reg1_o<=immsu;
						reg0_re_o<=`ReadEnable;
						reg0_addr_o<=ry;
					end
				endcase
			end
			`OP_ADDIU3:begin 
				alusel_o<=`EXE_SEL_ARITH;
				aluop_o<=`EXE_OP_ADDIU3;
				we_o<=`WriteEnable;
				waddr_o<=ry;						
				reg0_o<=reg0_data_i;
				reg1_o<=imms;
				reg0_re_o<=`ReadEnable;
				reg0_addr_o<=rx;
			end
			`OP_ADDIU:begin
				alusel_o<=`EXE_SEL_ARITH;
				aluop_o<=`EXE_OP_ADDIU;
				we_o<=`WriteEnable;
				waddr_o<=rx;						
				reg0_o<=reg0_data_i;
				reg1_o<=imml;
				reg0_re_o<=`ReadEnable;
				reg0_addr_o<=rx;
			end
			`OP_SLTI:begin
			end
			`OP_SLTUI:begin
			end
			`OP_BTEQZ:begin
				case (op1)
					`OP1_BTEQZ:begin
						alusel_o<=`EXE_SEL_JUMP;
						aluop_o<=`EXE_OP_BTEQZ;
						reg0_re_o<=`ReadEnable;
						reg0_addr_o<=`T_Addr;
						branch_addr_o<=pc_i+imml;
						branch_flag_o<=reg0_eq_zero;	
					end
					`OP1_BTNEZ:begin
					end
					`OP1_SW_RS:begin
					end
					`OP1_ADDSP:begin
						alusel_o<=`EXE_SEL_ARITH;
						aluop_o<=`EXE_OP_ADDSP;
						we_o<=`WriteEnable;
						waddr_o<=rx;						
						reg0_o<=reg0_data_i;
						reg1_o<=imml;
						reg0_re_o<=`ReadEnable;
						reg0_addr_o<=`SP_Addr;
					end
					`OP1_MTSP:begin
						alusel_o<=`EXE_SEL_REG;
						aluop_o<=`EXE_OP_MTSP;
						we_o<=`WriteEnable;
						waddr_o<=`SP_Addr;
						reg0_re_o<=`ReadEnable;
						reg0_addr_o<=rx;
					end
				endcase
			end
			`OP_LI:begin
				alusel_o<=`EXE_SEL_REG;
				aluop_o<=`EXE_OP_LI;
				we_o<=`WriteEnable;
				waddr_o<=rx;
				reg0_re_o<=`ReadEnable;
				reg0_o<=immlu;
			end
			`OP_CMPI:begin
				alusel_o<=`EXE_SEL_CMP;
				aluop_o<=`EXE_OP_CMPI;
				we_o<=`WriteEnable;
				waddr_o<=`T_Addr;
				reg0_o<=reg0_data_i;
				reg1_o<=imml;
				reg0_re_o<=`ReadEnable;
				reg0_addr_o<=rx;
			end
			`OP_MOVE:begin
				alusel_o<=`EXE_SEL_REG;
				aluop_o<=`EXE_OP_MOVE;
				we_o<=`WriteEnable;
				waddr_o<=rx;
				reg0_re_o<=`ReadEnable;
				reg0_addr_o<=ry;
			end
			`OP_LW_SP:begin
				alusel_o<=`EXE_SEL_LW;
				aluop_o<=`EXE_OP_LW_SP;
				we_o<=`WriteEnable;
				waddr_o<=rx;
				reg0_o<=pc_i;
				reg1_o<=imml;
			end
			`OP_LW:begin
				alusel_o<=`EXE_SEL_LW;
				aluop_o<=`EXE_OP_LW;
				we_o<=`WriteEnable;
				waddr_o<=ry;
				reg0_o<=reg0_data_i;
				reg1_o<=imms;
				reg0_re_o<=`ReadEnable;
				reg0_addr_o<=rx;
			end
			`OP_SW_SP:begin
				alusel_o<=`EXE_SEL_LW;
				aluop_o<=`EXE_OP_SW_SP;
				reg0_o<=reg0_data_i+imml;
				reg1_o<=reg1_data_i;
				reg0_re_o<=`ReadEnable;
				reg1_re_o<=`ReadEnable;
				reg0_addr_o<=`SP_Addr;
				reg1_addr_o<=rx;
			end
			`OP_SW:begin
				alusel_o<=`EXE_SEL_LW;
				aluop_o<=`EXE_OP_SW;
				reg0_o<=reg0_data_i+imms;
				reg1_o<=reg1_data_i;
				reg0_re_o<=`ReadEnable;
				reg1_re_o<=`ReadEnable;
				reg0_addr_o<=rx;
				reg1_addr_o<=ry;
			end
			`OP_ADDU:begin
				case (op4)
					`OP4_ADDU:begin
						alusel_o<=`EXE_SEL_ARITH;
						aluop_o<=`EXE_OP_SUBU;
						we_o<=`WriteEnable;
						waddr_o<=rz;						
						reg0_o<=reg0_data_i;
						reg1_o<=reg1_data_i;
						reg0_re_o<=`ReadEnable;
						reg1_re_o<=`ReadEnable;
						reg0_addr_o<=rx;
						reg0_addr_o<=ry;
					end
					`OP4_SUBU:begin
						alusel_o<=`EXE_SEL_ARITH;
						aluop_o<=`EXE_OP_SUBU;
						we_o<=`WriteEnable;
						waddr_o<=rz;						
						reg0_o<=reg0_data_i;
						reg1_o<=reg1_data_i;
						reg0_re_o<=`ReadEnable;
						reg1_re_o<=`ReadEnable;
						reg0_addr_o<=rx;
						reg0_addr_o<=ry;
					end
				endcase	
			end
			`OP_JR:begin
				case (op3)
					`OP3_JR:begin
						case (op2)
							`OP2_JR:begin
								alusel_o<=`EXE_SEL_JUMP;
								aluop_o<=`EXE_OP_JR;
								reg0_re_o<=`ReadEnable;
								reg0_addr_o<=rx;
								branch_addr_o<=reg0_data_i;
								branch_flag_o<=`BranchFlagUp;	
							end
							`OP2_JRRA:begin
							end
							`OP2_MFPC:begin
								alusel_o<=`EXE_SEL_REG;
								aluop_o<=`EXE_OP_MFPC;
								we_o<=`WriteEnable;
								waddr_o<=rx;
								reg0_o<=pc_i;	
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
						alusel_o<=`EXE_SEL_SHIFT;
						aluop_o<=`EXE_OP_SLLV;
						we_o<=`WriteEnable;
						waddr_o<=ry;						
						reg0_o<=reg0_data_i;
						reg1_o<=reg1_data_i;
						reg0_re_o<=`ReadEnable;
						reg1_re_o<=`ReadEnable;
						reg0_addr_o<=rx;
						reg0_addr_o<=ry;
					end
					`OP3_SRLV:begin
					end
					`OP3_SRAV:begin
					end
					`OP3_CMP:begin
						alusel_o<=`EXE_SEL_CMP;
						aluop_o<=`EXE_OP_CMP;
						we_o<=`WriteEnable;
						waddr_o<=`T_Addr;
						reg0_o<=reg0_data_i;
						reg1_o<=reg1_data_i;
						reg0_re_o<=`ReadEnable;
						reg1_re_o<=`ReadEnable;
						reg0_addr_o<=rx;
						reg1_addr_o<=ry;
					end
					`OP3_NEG:begin
						alusel_o<=`EXE_SEL_LOGIC;
						aluop_o<=`EXE_OP_NEG;
						we_o<=`WriteEnable;
						waddr_o<=rx;
						reg0_o<=reg0_data_i;
						reg0_re_o<=`ReadEnable;
						reg0_addr_o<=ry;
					end
					`OP3_AND:begin
						alusel_o<=`EXE_SEL_LOGIC;
						aluop_o<=`EXE_OP_AND;
						we_o<=`WriteEnable;
						waddr_o<=rx;
						reg0_o<=reg0_data_i;
						reg1_o<=reg1_data_i;
						reg0_re_o<=`ReadEnable;
						reg1_re_o<=`ReadEnable;
						reg0_addr_o<=rx;
						reg1_addr_o<=ry;
					end
					`OP3_OR:begin
						alusel_o<=`EXE_SEL_LOGIC;
						aluop_o<=`EXE_OP_OR;
						we_o<=`WriteEnable;
						waddr_o<=rx;	
						reg0_o<=reg0_data_i;
						reg1_o<=reg1_data_i;
						reg0_re_o<=`ReadEnable;
						reg1_re_o<=`ReadEnable;
						reg0_addr_o<=rx;
						reg1_addr_o<=ry;
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
						alusel_o<=`EXE_SEL_REG;
						aluop_o<=`EXE_OP_MFIH;
						we_o<=`WriteEnable;
						waddr_o<=rx;
						reg0_re_o<=`ReadEnable;
						reg0_addr_o<=`IH_Addr;	
					end
					`OP3_MTIH:begin
						alusel_o<=`EXE_SEL_REG;
						aluop_o<=`EXE_OP_MTIH;
						we_o<=`WriteEnable;
						waddr_o<=`IH_Addr;
						reg0_re_o<=`ReadEnable;
						reg0_addr_o<=rx;	
					end
				endcase	
			end	
			`OP_INT:begin
				//not finished
			end
		endcase
	end
end

//some thing need to thin more with mem_wdata & ex_wdata

always @ (*) begin
	if (rst ==`RstEnable) begin
		reg0_data_o<=`ZeroWord;
	end else if (reg0_re_o==`ReadEnable && ex_we_i == `WriteEnable && reg0_addr_o == ex_waddr_i) begin
		reg0_data_o<=ex_wdata_i;
	end else if (reg0_re_o==`ReadEnable && mem_we_i == `WriteEnable && reg0_addr_o == mem_waddr_i) begin
		reg0_data_o<=mem_wdata_i;
	end else begin
		reg0_data_o<=reg0_o;
	end
	// end else if (reg0_re_o==`ReadEnable) begin
	// 	reg0_data_o<=reg0_data_i;
	// end else if (reg0_re_o==`ReadDisable) begin
	// 	reg0_data_o<=imm_num;
	// end else begin
	// 	reg0_data_o<=`ZeroWord;
	// end
end

always @ (*) begin
	if (rst ==`RstEnable) begin
		reg1_data_o<=`ZeroWord;
	end else if (reg1_re_o==`ReadEnable && ex_we_i == `WriteEnable && reg1_addr_o == ex_waddr_i) begin
		reg1_data_o<=ex_wdata_i;
	end else if (reg1_re_o==`ReadEnable && mem_we_i == `WriteEnable && reg1_addr_o == mem_waddr_i) begin
		reg1_data_o<=mem_wdata_i;
	end else begin
		reg1_data_o<=reg1_o;
	end
	// end else if (reg1_re_o==`ReadEnable) begin
	// 	reg1_data_o<=reg1_data_i;
	// end else if (reg1_re_o==`ReadDisable) begin
	// 	reg1_data_o<=imm_num;
	// end else begin
	// 	reg1_data_o<=`ZeroWord;
	// end
end

endmodule