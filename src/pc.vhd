library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.all;
library WORK;
use WORK.PACK.ALL ;

entity pc is port(
	stall:		in		std_logic;
	clk:		in 		std_logic;
	rst:		in 		std_logic;
	branch_flag_o:	in	std_logic;
	branch_addr_o:	in	InstAddrBus;
	pc:				out InstAddrBus;
	ce:				out std_logic
);
end pc;

architecture Behavioral of pc is
	signal pc_v: InstAddrBus := ZeroInstAddr;
begin
	process(clk)
	begin
		if falling_edge(clk)	then	
			if stall = StallNo then
				if branch_flag_o = BranchFlagUp then
					pc_v <= branch_addr_o;
				else
					pc_v <= pc_v + 1;
				end if;
			end if;
			if rst = RstEnable then
				ce <= ChipDisable;
				pc_v <= ZeroInstAddr;
			else
				ce <= ChipEnable;
			end if;
		end if;
	end process;
	pc <= pc_v;
end Behavioral;