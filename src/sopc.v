`include "defines.v"

module sopc(
	input wire clk,
	input wire rst
);

wire[`InstAddrBus] rom_addr;
wire[`InstBus] rom_inst;
wire rom_ce;

mcpu mcpu0(
	.clk(clk),
	.rst(rst),
	.rom_inst_i(rom_inst),
	.rom_ce_o(rom_ce),
	.rom_addr_o(rom_addr)
);

inst_rom inst_rom0(
	.ce(rom_ce),
	.addr(rom_addr),
	.inst(rom_inst)
);

endmodule;