library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.PACK.ALL ;

entity stall_ctrl is
	Port(
		rst : in STD_LOGIC ;
		stallreq_id: in STD_LOGIC ;
		stallreq_ex: in STD_LOGIC ;
		stallreq_mem: in STD_LOGIC ;
		
		stall_pc: out STD_LOGIC ;
		stall_if_id: out STD_LOGIC ;
		stall_id_ex: out STD_LOGIC ;
		stall_ex_mem: out STD_LOGIC ;
		stall_mem_wb: out STD_LOGIC 
	) ;
end stall_ctrl ;

architecture Behavioral of stall_ctrl is

begin
	process(rst, stallreq_id, stallreq_ex, stallreq_mem)
	variable tmp_pc : STD_LOGIC := StallNo ;
	variable tmp_if_id : STD_LOGIC := StallNo ;
	variable tmp_id_ex : STD_LOGIC := StallNo ;
	variable tmp_ex_mem : STD_LOGIC := StallNo ;
	variable tmp_mem_wb: STD_LOGIC := StallNo ;
	begin
		tmp_pc := StallNo ;
		tmp_if_id := StallNo ;
		tmp_id_ex := StallNo ;
		tmp_ex_mem := StallNo ;
		tmp_mem_wb := StallNo ;
		if(rst = RstDisable) then
			if(stallreq_mem = StallYes) then
				tmp_ex_mem := StallYes ;
				tmp_id_ex := StallYes ;
				tmp_if_id := StallYes ;
				tmp_pc := StallYes ;
			elsif (stallreq_ex = StallYes) then
				tmp_id_ex := StallYes ;
				tmp_if_id := StallYes ;
				tmp_pc := StallYes ;
			elsif (stallreq_id = StallYes) then
				tmp_if_id := StallYes ;
				tmp_pc := StallYes ;
			end if ;
		end if ;
		stall_pc <= tmp_pc ;
		stall_if_id <= tmp_if_id ;
		stall_id_ex <= tmp_id_ex ;
		stall_ex_mem <= tmp_ex_mem ;
		stall_mem_wb <= tmp_mem_wb ;
	end process ;
end Behavioral ;