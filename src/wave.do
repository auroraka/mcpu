onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/rst
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/clk
add wave -noupdate -expand -group mcpu -radix hexadecimal /mcpu_tb/uut/id_pc_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/id_inst_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/branch_flag_o
add wave -noupdate -expand -group mcpu -radix hexadecimal /mcpu_tb/uut/branch_addr_o
add wave -noupdate -expand -group mcpu -radix hexadecimal /mcpu_tb/uut/pc
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/pc_data
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/stall_pc
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/stall_id
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/stall_ex
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/stallreq_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/stallreq_mem_o
add wave -noupdate -expand -group mcpu -radix hexadecimal /mcpu_tb/uut/pc_id_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/inst_id_i
add wave -noupdate -expand -group mcpu -radix hexadecimal /mcpu_tb/uut/reg0_data_id_i
add wave -noupdate -expand -group mcpu -radix hexadecimal /mcpu_tb/uut/reg1_data_id_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/mem_waddr_id_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/mem_wdata_id_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/mem_we_id_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/alusel_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/alusel_ex_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/aluop_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/aluop_ex_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/reg0_data_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/reg1_data_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/reg0_data_ex_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/reg1_data_ex_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/reg0_addr_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/reg1_addr_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/reg0_re_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/reg1_re_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/we_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/we_wb_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/we_ex_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/we_ex_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/we_mem_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/we_mem_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/waddr_id_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/waddr_wb_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/waddr_ex_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/waddr_ex_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/waddr_mem_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/waddr_mem_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/wdata_wb_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/wdata_ex_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/wdata_mem_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/wdata_mem_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/memrw_ex_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/memrw_mem_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/memaddr_ex_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/memaddr_mem_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/memdata_ex_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/memdata_mem_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram2_data_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram2_data_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram2_addr_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram2_ce_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram2_we_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram2_re_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram1_addr_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram1_data_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram1_data_o
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram1_ce_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram1_we_i
add wave -noupdate -expand -group mcpu /mcpu_tb/uut/ram1_re_i
add wave -noupdate -expand -group if_id /mcpu_tb/uut/mif_id/rst
add wave -noupdate -expand -group if_id /mcpu_tb/uut/mif_id/clk
add wave -noupdate -expand -group if_id /mcpu_tb/uut/mif_id/stall_pc
add wave -noupdate -expand -group if_id /mcpu_tb/uut/mif_id/stall_id
add wave -noupdate -expand -group if_id /mcpu_tb/uut/mif_id/stall_ex
add wave -noupdate -expand -group if_id -radix hexadecimal /mcpu_tb/uut/mif_id/if_pc
add wave -noupdate -expand -group if_id -radix hexadecimal /mcpu_tb/uut/mif_id/if_inst
add wave -noupdate -expand -group if_id -radix hexadecimal /mcpu_tb/uut/mif_id/id_pc
add wave -noupdate -expand -group if_id -radix hexadecimal /mcpu_tb/uut/mif_id/id_inst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {36 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 224
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {40 ns}
