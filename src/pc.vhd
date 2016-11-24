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
	pc_inst:		out InstAddrBus ;
	pc : out InstAddrBus 
);
end pc;

architecture Behavioral of pc is
	--signal pc_v: InstAddrBus := "1111111111111111";
begin
	process(clk, rst)
	variable pc_v : InstAddrBus := ZeroInstAddr ;
	begin
		if(rst = RstEnable) then
			--pc_v := ZeroInstAddr ;
			pc_inst <= "1111111111111111" ;
			pc_v := ZeroInstAddr ;
			pc <= pc_v ;
		elsif (clk'event and clk = '1') then
			--pc <= pc_v ; -- update pc
			if (stall = StallNo) then 
				if branch_flag_o = BranchFlagUp then -- jump into new pc ;
					pc_inst <= branch_addr_o ;
					pc_v := branch_addr_o;
				else 
					pc_inst <= pc_v ;
				end if;
				-- prepare pc_v for next pc 
				pc_v := pc_v + 1;
				pc <= pc_v ;
			else --pc hold and pc_v store the next pc, branch_addr_o or pc+1
				-- stall 时是否可以跳转 @comment By tl,是记录跳转信号的，否则可能遇到bug 
				if branch_flag_o = BranchFlagUp then
					pc_v := branch_addr_o ;
				else
					null ;
				end if ;
			end if ;
		end if ;
	end process;
end Behavioral;