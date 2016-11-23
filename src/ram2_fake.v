`include "defines.v"

module ram2_fake(
	input wire clk,
	input wire[`DataAddrBus] pc,
	output reg[`InstBus] inst,
	input wire[`DataBus] mem_data_i,
	output reg[`DataBus] mem_data_o,
	input wire[`DataAddrBus] mem_addr_i,
	input wire mem_re,
	input wire mem_we,
	input wire mem_ce
);

	reg[`InstBus]  ram[0:16383];

	//initial $readmemb ( "ram2.data", ram );

	always @ (pc, mem_data_i, mem_addr_i, mem_re, mem_ce, mem_we) begin
		if (mem_ce == `RamChipDisable) begin //mem rw
			mem_data_o <= `ZeroWord;
			inst <= ram[pc] ;
	  	end else begin// pc rw
	  		if (mem_re == `RamReadEnable) begin
	  			$display("ram2 read addr %h",mem_addr_i);
	  			mem_data_o <= ram[mem_addr_i[13:0]];
			end else begin
				mem_data_o <= `ZeroWord;
			end
	  	end
	end

	
	// initial begin
	// 	ram[0]<=16'b0110100100010001;
	// 	ram[1]<=16'b0110101000100010;
	// 	ram[2]<=16'b0110101100110011;
	// 	ram[3]<=16'b1110000101010001;	
	// end
	
	initial begin
		ram[0] <= 16'b0110100100000001;
ram[1] <= 16'b0110101000000001;
ram[2] <= 16'b0110101110000101;
ram[3] <= 16'b0011001101100000;
ram[4] <= 16'b0110110000001001;
ram[5] <= 16'b1101101100100000;
ram[6] <= 16'b1101101101000001;
ram[7] <= 16'b1110000101000101;
ram[8] <= 16'b1110000101001001;
ram[9] <= 16'b0100101100000010;
ram[10] <= 16'b0100110011111111;
ram[11] <= 16'b0010110011111001;
ram[12] <= 16'b0000100000000000;


	end

endmodule