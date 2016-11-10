
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
