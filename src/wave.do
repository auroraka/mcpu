onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group mcpu /mcpu_tb/mcpu0/rst
add wave -noupdate -expand -group mcpu /mcpu_tb/mcpu0/clk
add wave -noupdate -expand -group mcpu -radix hexadecimal /mcpu_tb/mcpu0/pc
add wave -noupdate -expand -group mcpu /mcpu_tb/mcpu0/pc_data
add wave -noupdate -expand -group mcpu /mcpu_tb/mcpu0/alusel_ex_i
add wave -noupdate -expand -group mcpu /mcpu_tb/mcpu0/aluop_ex_i
add wave -noupdate -expand -group mcpu /mcpu_tb/mcpu0/we_ex_o
add wave -noupdate -expand -group mcpu /mcpu_tb/mcpu0/waddr_ex_o
add wave -noupdate -expand -group mcpu -radix hexadecimal /mcpu_tb/mcpu0/wdata_ex_o
add wave -noupdate -group pc /mcpu_tb/mcpu0/pc0/stall
add wave -noupdate -group pc /mcpu_tb/mcpu0/pc0/clk
add wave -noupdate -group pc /mcpu_tb/mcpu0/pc0/rst
add wave -noupdate -group pc /mcpu_tb/mcpu0/pc0/branch_flag_o
add wave -noupdate -group pc /mcpu_tb/mcpu0/pc0/branch_addr_o
add wave -noupdate -group pc /mcpu_tb/mcpu0/pc0/pc
add wave -noupdate -group pc /mcpu_tb/mcpu0/pc0/pc_v
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/rst
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/pc_i
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/inst_i
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg0_data_i
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg1_data_i
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/ex_we_i
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/ex_waddr_i
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/ex_wdata_i
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/mem_we_i
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/mem_waddr_i
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/mem_wdata_i
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/alusel_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/aluop_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg0_data_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg1_data_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg0_re_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg1_re_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg0_addr_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg1_addr_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/we_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/waddr_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/stall_req
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/branch_flag_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/branch_addr_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg0_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg1_o
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/op
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/op1
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/op2
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/op3
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/op4
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/rx
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/ry
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/rz
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/immlu
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/imml
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/immsu
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/imms
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/immb
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg0_eq_zero
add wave -noupdate -group id /mcpu_tb/mcpu0/id0/reg1_eq_zero
add wave -noupdate -expand -group regfile /mcpu_tb/mcpu0/regfile0/re_0
add wave -noupdate -expand -group regfile /mcpu_tb/mcpu0/regfile0/re_1
add wave -noupdate -expand -group regfile -radix octal /mcpu_tb/mcpu0/regfile0/raddr0
add wave -noupdate -expand -group regfile /mcpu_tb/mcpu0/regfile0/raddr1
add wave -noupdate -expand -group regfile /mcpu_tb/mcpu0/regfile0/we
add wave -noupdate -expand -group regfile -radix octal /mcpu_tb/mcpu0/regfile0/waddr
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/wdata
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/rdata0
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/rdata1
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/R0
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/R1
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/R2
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/R3
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/R4
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/R5
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/R6
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/R7
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/SP
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/IH
add wave -noupdate -expand -group regfile -radix hexadecimal /mcpu_tb/mcpu0/regfile0/T
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/aluop_i
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/alusel_i
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/reg0_i
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/reg1_i
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/waddr_i
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/we_i
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/rst
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/memrw_o
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/memaddr_o
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/memdata_o
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/we_o
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/waddr_o
add wave -noupdate -group ex /mcpu_tb/mcpu0/ex0/wdata_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/rst
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/we_i
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/waddr_i
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/wdata_i
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/memdata_i
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/memrw_i
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/memaddr_i
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/we_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/waddr_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/wdata_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram1_data_i
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram1_data_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram1_addr_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram1_re_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram1_we_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram1_ce_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram2_data_i
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram2_data_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram2_addr_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram2_re_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram2_we_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/ram2_ce_o
add wave -noupdate -group mem /mcpu_tb/mcpu0/mem0/stall_req
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {251 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
configure wave -valuecolwidth 111
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {215 ns} {309 ns}
