`include "defines.v"
//`include "D:\\CPU\\mcpu\\src\\defines.v"
`timescale 1ns / 1ns
module exe_test ;

//input 
reg rst,
	
reg[`InstAddrBus] pc_i,
reg[`InstBus] inst_i,
	
reg[`DataBus] reg0_data_i,
reg[`DataBus] reg1_data_i,
	
reg[`RegAddrBus] ex_waddr_i,
reg ex_we_i,
reg[`DataBus] ex_wdata_i,

reg[`RegAddrBus] mem_waddr_i,
reg mem_we_i,
reg[`DataBus] mem_wdata_i,

reg[`DataBus] reg0_data_i,
reg[`DataBus] reg1_data_i,
