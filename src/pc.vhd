library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.PACK.ALL ;

entity pc is port(
	stall:		in		std_logic;
	clk:		in 		std_logic;
	rst:		in 		std_logic;
	branch_flag_o:	in	std_logic;
	branch_addr_o:	in	InstAddrBus;
	pc:				out InstAddrBus;
	ce:				out std_logic;
);
end pc;

architecture Behavioral of pc is
begin
	process(clk)
	begin
		if(rst)
		if(stall)
		if(branch_flag_o)
		else if rising_edge(clk)
		
	end
end Behavioral;