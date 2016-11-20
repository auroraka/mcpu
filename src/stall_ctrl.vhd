library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.PACK.ALL ;

entity stall_ctrl is
	Port(
		rst : in STD_LOGIC ;
		stallreq_id: in STD_LOGIC ;
		stallreq__ex: in STD_LOGIC ;
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
end Behavioral ;