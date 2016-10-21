`include "defines.v"

module regfile(
	input wire clk,
	input wire rst,
	
	//read1
	input wire re0,
	input wire[`RegAddrBus] raddr0,
	output reg[`DataBus] rdata0,
	
	//read2
	input wire re1,
	input wire[`RegAddrBus] raddr1,
	output reg[`DataBus] rdata1,
	
	//write
	input wire we,
	input wire[`RegAddrBus] waddr,
	input wire[`DataBus] wdata
);

reg[`RegAddrBus] regs[`RegNum-1:0];

//write
always @ (posedge clk) begin
	if (rst == `RstEnable) begin
	end else begin
		if (we == `WriteEnable) begin
			regs[waddr]<=wdata;
		end
	end

end

//read0
always @ (*) begin
	if (we == `WriteEnable) begin
		if (re0 == `ReadEnable && we == `WriteEnable && waddr == raddr0) begin
			rdata0<=wdata;
		end else if (re0 == `ReadEnable) begin
			rdata0<=regs[raddr0];
		end
	end
end

//read1
always @ (*) begin
	if (we == `WriteEnable) begin
		if (re1 == `ReadEnable && we == `WriteEnable && waddr == raddr1) begin
			rdata1<=wdata;
		end else if (re1 == `ReadEnable) begin
			rdata1<=regs[raddr1];
		end
	end
end

endmodule