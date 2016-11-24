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

	always @ (pc, mem_data_i, mem_addr_i, mem_re, mem_ce, mem_we) 
	begin
		if (mem_ce == `RamChipDisable) 
		begin //mem rw
			mem_data_o <= `ZeroWord;
			inst <= ram[pc] ;
	  	end 
		else 
		begin// pc rw
	  		if (mem_re == `RamReadEnable) 
			begin
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
		ram[0] <= 16'b0000100000000000;
ram[1] <= 16'b0010000100000101;
ram[2] <= 16'b0000100000000000;
ram[3] <= 16'b0110100100000011;
ram[4] <= 16'b1110100101001010;
ram[5] <= 16'b0110000000000010;
ram[6] <= 16'b0000100000000000;
ram[7] <= 16'b1110100101001010;
ram[8] <= 16'b0110000011111001;
ram[9] <= 16'b0000100000000000;
ram[10] <= 16'b1110100100000000;
ram[11] <= 16'b0000100000000000;




	end

endmodule