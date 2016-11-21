library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
library WORK;
use WORK.PACK.ALL ;

entity pc is port(
	stall:		in		std_logic;
	clk:		in 		std_logic;
	rst:		in 		std_logic;
	branch_flag_o:	in	std_logic;
	branch_addr_o:	in	InstAddrBus;
	pc:				out InstAddrBus
);
end pc;

architecture Behavioral of pc is
	--signal pc_v: InstAddrBus := ZeroInstAddr;
begin
	process(clk, rst)
	variable pc_v : InstAddrBus := ZeroInstAddr ;
	begin
		if(rst = RstEnable) then
			pc_v := ZeroInstAddr ;
			pc <= pc_v ;
		elsif (clk'event and clk = '1') then
			--pc <= pc_v ; -- update pc
			if (stall = StallNo) then 
				if branch_flag_o = BranchFlagUp then -- jump into new pc ;
					pc <= branch_addr_o ;
					pc_v := branch_addr_o;
				else 
					pc <= pc_v ;
				end if;
				
				-- prepare pc_v for next pc 
				pc_v := pc_v + 1;
			else
				null ; --pc and pc_v hold ;
			end if ;
		end if ;
	end process;
end Behavioral;