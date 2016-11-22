//`include "defines.v"
`include "D:\\CPU\\mcpu\\src\\defines.v"

module ex_mem(
	input wire clk,
	input wire rst,
	input wire[`MemRWBus] ex_memrw,
	input wire[`DataAddrBus] ex_memaddr,
	input wire[`DataBus] ex_memdata,
	input wire[`DataBus] ex_wdata,
	input wire[`RegAddrBus] ex_waddr,
	input wire ex_we,
	
	output reg[`DataBus] mem_wdata,
	output reg[`RegAddrBus] mem_waddr,
	output reg[`MemRWBus] mem_memrw,
	output reg[`DataAddrBus] mem_memaddr,
	output reg[`DataBus] mem_memdata ,
	output reg mem_we
);

always @ (posedge clk or negedge rst) begin
	if (rst == `RstEnable) 
	begin
		mem_wdata<=`ZeroData;
		mem_waddr<= `ZeroRegAddr ;
		mem_we<=`WriteDisable;
		mem_memrw <= `MemRW_Idle ;
		mem_memaddr <= `ZeroDataAddr ;
		mem_memdata <= `ZeroData ;
	end
	else
	begin
		mem_waddr<=ex_waddr;
		mem_wdata<=ex_wdata;
		mem_we<=ex_we;
		mem_memrw <= ex_memrw ;
		mem_memaddr <= ex_memaddr ;
		mem_memdata <= ex_memdata ;
	end
end

endmodule