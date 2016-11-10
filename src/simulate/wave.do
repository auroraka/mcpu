onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group sopc_tb /sopc_tb/clk
add wave -noupdate -expand -group sopc_tb /sopc_tb/rst
add wave -noupdate -expand -group pc /sopc_tb/sopc0/mcpu0/pc0/pc
add wave -noupdate -expand -group pc /sopc_tb/sopc0/mcpu0/pc0/ce
add wave -noupdate -expand -group if_id -radix hexadecimal /sopc_tb/sopc0/mcpu0/if_id0/if_pc
add wave -noupdate -expand -group if_id -radix hexadecimal /sopc_tb/sopc0/mcpu0/if_id0/if_inst
add wave -noupdate -expand -group if_id -radix hexadecimal /sopc_tb/sopc0/mcpu0/if_id0/id_pc
add wave -noupdate -expand -group if_id -radix hexadecimal /sopc_tb/sopc0/mcpu0/if_id0/id_inst
add wave -noupdate -expand -group id -radix hexadecimal /sopc_tb/sopc0/mcpu0/id0/pc_i
add wave -noupdate -expand -group id -radix hexadecimal /sopc_tb/sopc0/mcpu0/id0/inst_i
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/reg0_data_i
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/reg1_data_i
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/aluop_o
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/alusel_o
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/reg0_o
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/reg1_o
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/waddr_o
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/we_o
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/reg0_re_o
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/reg0_addr_o
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/reg1_re_o
add wave -noupdate -expand -group id /sopc_tb/sopc0/mcpu0/id0/reg1_addr_o
add wave -noupdate -expand -group regfile /sopc_tb/sopc0/mcpu0/regfile0/re0
add wave -noupdate -expand -group regfile /sopc_tb/sopc0/mcpu0/regfile0/raddr0
add wave -noupdate -expand -group regfile /sopc_tb/sopc0/mcpu0/regfile0/rdata0
add wave -noupdate -expand -group regfile /sopc_tb/sopc0/mcpu0/regfile0/re1
add wave -noupdate -expand -group regfile /sopc_tb/sopc0/mcpu0/regfile0/raddr1
add wave -noupdate -expand -group regfile /sopc_tb/sopc0/mcpu0/regfile0/rdata1
add wave -noupdate -expand -group regfile /sopc_tb/sopc0/mcpu0/regfile0/we
add wave -noupdate -expand -group regfile -radix binary /sopc_tb/sopc0/mcpu0/regfile0/waddr
add wave -noupdate -expand -group regfile -radix hexadecimal /sopc_tb/sopc0/mcpu0/regfile0/wdata
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/id_aluop
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/id_alusel
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/id_reg0
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/id_reg1
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/id_waddr
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/id_we
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/ex_aluop
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/ex_alusel
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/ex_reg0
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/ex_reg1
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/ex_waddr
add wave -noupdate -expand -group id_ex /sopc_tb/sopc0/mcpu0/id_ex0/ex_we
add wave -noupdate -expand -group ex /sopc_tb/sopc0/mcpu0/ex0/aluop_i
add wave -noupdate -expand -group ex /sopc_tb/sopc0/mcpu0/ex0/alusel_i
add wave -noupdate -expand -group ex /sopc_tb/sopc0/mcpu0/ex0/reg0_i
add wave -noupdate -expand -group ex /sopc_tb/sopc0/mcpu0/ex0/reg1_i
add wave -noupdate -expand -group ex /sopc_tb/sopc0/mcpu0/ex0/waddr_i
add wave -noupdate -expand -group ex /sopc_tb/sopc0/mcpu0/ex0/we_i
add wave -noupdate -expand -group ex /sopc_tb/sopc0/mcpu0/ex0/waddr_o
add wave -noupdate -expand -group ex -radix hexadecimal /sopc_tb/sopc0/mcpu0/ex0/wdata_o
add wave -noupdate -expand -group ex /sopc_tb/sopc0/mcpu0/ex0/we_o
add wave -noupdate -expand -group ex_mem -radix hexadecimal /sopc_tb/sopc0/mcpu0/ex_mem0/ex_wdata
add wave -noupdate -expand -group ex_mem /sopc_tb/sopc0/mcpu0/ex_mem0/ex_waddr
add wave -noupdate -expand -group ex_mem /sopc_tb/sopc0/mcpu0/ex_mem0/ex_we
add wave -noupdate -expand -group ex_mem -radix hexadecimal /sopc_tb/sopc0/mcpu0/ex_mem0/mem_wdata
add wave -noupdate -expand -group ex_mem /sopc_tb/sopc0/mcpu0/ex_mem0/mem_waddr
add wave -noupdate -expand -group ex_mem /sopc_tb/sopc0/mcpu0/ex_mem0/mem_we
add wave -noupdate -expand -group mem /sopc_tb/sopc0/mcpu0/mem0/waddr_i
add wave -noupdate -expand -group mem -radix hexadecimal /sopc_tb/sopc0/mcpu0/mem0/wdata_i
add wave -noupdate -expand -group mem /sopc_tb/sopc0/mcpu0/mem0/we_i
add wave -noupdate -expand -group mem /sopc_tb/sopc0/mcpu0/mem0/waddr_o
add wave -noupdate -expand -group mem -radix hexadecimal /sopc_tb/sopc0/mcpu0/mem0/wdata_o
add wave -noupdate -expand -group mem /sopc_tb/sopc0/mcpu0/mem0/we_o
add wave -noupdate -expand -group mem_wb -radix hexadecimal /sopc_tb/sopc0/mcpu0/mem_wb0/mem_wdata
add wave -noupdate -expand -group mem_wb /sopc_tb/sopc0/mcpu0/mem_wb0/mem_waddr
add wave -noupdate -expand -group mem_wb /sopc_tb/sopc0/mcpu0/mem_wb0/mem_we
add wave -noupdate -expand -group mem_wb -radix hexadecimal /sopc_tb/sopc0/mcpu0/mem_wb0/wb_wdata
add wave -noupdate -expand -group mem_wb /sopc_tb/sopc0/mcpu0/mem_wb0/wb_waddr
add wave -noupdate -expand -group mem_wb /sopc_tb/sopc0/mcpu0/mem_wb0/wb_we
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {98344 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 294
configure wave -valuecolwidth 124
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
WaveRestoreZoom {0 ps} {411352 ps}
