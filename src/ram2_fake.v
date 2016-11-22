`include "defines.v"
//`include "D:\\CPU\\mcpu\\src\\defines.v"
module ram2_fake(
	input wire clk,
	input wire[`DataAddrBus] pc,
	output wire[`InstBus] inst,
	input wire[`DataBus] mem_data_i,
	output reg[`DataBus] mem_data_o,
	input wire[`DataAddrBus] mem_addr_i,
	input wire mem_re,
	input wire mem_we,
	input wire mem_ce
);

	reg[`InstBus]  ram[0:4095];

	initial $readmemh ( "D:\\CPU\\mcpu\\src\\ram2.data", ram );

	always @ (*) begin
		if (mem_ce == `RamChipEnable) begin //mem rw
			mem_data_o <= `ZeroWord;
	  	end else begin// pc rw
	  		if (mem_re == `RamReadEnable) begin
	  			mem_data_o <= ram[mem_addr_i[11:0]];
			end else begin
				mem_data_o <= `ZeroWord;
			end
	  	end
	end

endmodule