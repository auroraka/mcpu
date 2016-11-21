library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.PACK.ALL ;

entity stall_ctrl is
	Port(
		rst : in STD_LOGIC ;
		stallreq_id: in STD_LOGIC ;
		stallreq_mem: in STD_LOGIC ;
		
		stall_pc: out STD_LOGIC ;
		stall_id: out STD_LOGIC ;
		stall_ex: out STD_LOGIC ;
		stall_mem: out STD_LOGIC 
	) ;
end stall_ctrl ;

architecture Behavioral of stall_ctrl is

begin
	process(rst, stallreq_id, stallreq_mem)
	variable tmp_pc : STD_LOGIC := StallNo ;
	variable tmp_id : STD_LOGIC := StallNo ;
	variable tmp_ex : STD_LOGIC := StallNo ;
	variable tmp_mem : STD_LOGIC := StallNo ;
	begin
		tmp_pc := StallNo ;
		tmp_id := StallNo ;
		tmp_ex := StallNo ;
		tmp_mem := StallNo ;
		if(rst = RstDisable) then
			if(stallreq_mem = StallYes) then
				tmp_pc := StallYes ;
			elsif (stallreq_id = StallYes) then
				tmp_id := StallYes ;
				tmp_pc := StallYes ;
			end if ;
		end if ;
		stall_pc <= tmp_pc ;
		stall_id <= tmp_id ;
		stall_ex <= tmp_ex ;
		stall_mem <= tmp_mem ;
	end process ;
end Behavioral ;