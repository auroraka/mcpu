`include "defines.v"

module ram2_fake(
	input wire clk,
	input wire[`DataBus] mem_data_i,
	output reg[`DataBus] mem_data_o,
	input wire[`DataAddrBus] mem_addr_i,
	input wire mem_re,
	input wire mem_we,
	input wire mem_ce
);

	reg[`InstBus]  ram[0:4095];

	initial $readmemh ( "ram2.data", ram );

	always @ (*) begin
		if (mem_ce == `RamChipDisable) begin
			mem_data_o <= `ZeroWord;
	  	end else begin
	  		if (mem_re == `ReadEnable) begin
	  			mem_data_o <= ram[mem_addr_i[11:0]];
			end else if (mem_we == `WriteEnable) begin
				ram[mem_addr_i[11:0]]<=mem_data_i;
			end else begin
				mem_data_o <= `ZeroWord;
			end
	  	end
	end

endmodule