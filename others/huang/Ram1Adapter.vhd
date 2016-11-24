----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:45:29 11/19/2016 
-- Design Name: 
-- Module Name:    Ram1Adapter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use WORK.YLib.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ram1Adapter is
    Port ( rst : in STD_LOGIC;
			  clk : in  STD_LOGIC;
			  data_ready : in STD_LOGIC;
			  tbre : in STD_LOGIC;
			  tsre : in STD_LOGIC;
			  rdn, wrn : out STD_LOGIC;
           mem_op : in  MemOperation;
			  ram1_data : inout STD_LOGIC_VECTOR (15 downto 0);
			  ram1_control : out MemControl;
			  ram1_addr : out STD_LOGIC_VECTOR (17 downto 0)
			  );
end Ram1Adapter;


architecture Behavioral of Ram1Adapter is
	type STATUS is (PORT_READ, PORT_WRITE, PORT_EN, MEM_OPERATION, NOTHING);
	signal state : STATUS := NOTHING;
	signal port_event : STD_LOGIC;
begin
	process (clk, mem_op, rst)
	begin
		port_event <= '0';
		if (rst = RstEnable) then
			state <= NOTHING;
		else
			if (mem_op.enable = MemEnable and mem_op.addr(15) = '1') then
				if (mem_op.addr = PORT1_ADDR_DATA) then
					if (mem_op.mode = MemRead) then
						state <= PORT_READ;
						port_event <= '1';
					elsif (mem_op.mode = MemWrite) then
						state <= PORT_WRITE;
						port_event <= '1';
					else
						state <= NOTHING;
					end if;
				elsif (mem_op.addr = PORT1_ADDR_EN) then
					state <= PORT_EN;	
					port_event <= '1';
				else
					state <= MEM_OPERATION;
				end if;
			else
				state <= NOTHING;
			end if;
		end if;
	end process;
	
	process (clk, state, mem_op, ram1_data, data_ready, tbre, tsre, rst)
	begin
		if (rst = RstEnable) then
			ram1_control <= MEM_CONTROL_DISABLE;
			rdn <= '1';
			wrn <= '1';
		else 
			case state is
				when PORT_READ =>
					ram1_data <= Z_16;
					ram1_addr <= "00" & ZEROS_16;
					ram1_control <= MEM_CONTROL_DISABLE;
					rdn <= clk;
					wrn <= '1';
				when PORT_WRITE =>
					ram1_data <= mem_op.data;
					ram1_addr <= "00" & ZEROS_16;
					ram1_control <= MEM_CONTROL_DISABLE;
					rdn <= '1';
					wrn <= clk;
				when PORT_EN =>
					ram1_data <= "00000000000000" & data_ready & (tbre and tsre);
					ram1_addr <= "00" & ZEROS_16;
					ram1_control <= MEM_CONTROL_DISABLE;
					rdn <= '1';
					wrn <= '1';
				when MEM_OPERATION =>
					ram1_control.CE <= clk;
					ram1_addr <= "00" & mem_op.addr;
					if (mem_op.mode = MemWrite) then
						ram1_control.OE <= MEM_CONTROL_WRITE.OE;
						ram1_control.WE <= MEM_CONTROL_WRITE.WE;
						ram1_data <= mem_op.data;
					else
						ram1_control.OE <= MEM_CONTROL_READ.OE;
						ram1_control.WE <= MEM_CONTROL_READ.WE;
						ram1_data <= Z_16;
					end if;
					rdn <= '1';
					wrn <= '1';
				when NOTHING =>
					ram1_control <= MEM_CONTROL_DISABLE;
					rdn <= '1';
					wrn <= '1';
					ram1_data <= Z_16;
					ram1_addr <= "00" & ZEROS_16;
				when others =>
					ram1_control <= MEM_CONTROL_DISABLE;
					rdn <= '1';
					wrn <= '1';
					ram1_data <= Z_16;
					ram1_addr <= "00" & ZEROS_16;
			end case;
		end if;
	end process;

end Behavioral;

