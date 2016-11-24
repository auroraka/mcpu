--------------------------------------------------------------------------------
-- Company: 
-- Engineer:Evelyn Wang
--
-- Create Date:   16:06:19 11/19/2016
-- Design Name:   
-- Module Name:   F:/2016FALL/JY/cpu/mcpu/src/testbench/mem_tb.vhd
-- Project Name:  mcpu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mem
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL ;
USE WORK.PACK.ALL ;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY mem_tb IS
END mem_tb;
 
ARCHITECTURE behavior OF mem_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mem
    PORT(
		rst : 		in STD_LOGIC ;
		--寄存
		we_i : 		in STD_LOGIC ;
		waddr_i : 	in RegAddrBus ;
		wdata_i : 	in DataBus ;
		--ram
		memdata_i : in DataBus ;
		memrw_i : 	in MemRWBus ; 
		memaddr_i : in DataAddrBus ;

		we_o : 		out STD_LOGIC ;
		waddr_o : 	out RegAddrBus ;
		wdata_o : 	out DataBus ;
		
		--ram 1 
		ram1_data_i:	in 	DataBus ;
		ram1_data_o : 	out DataBus ;
		ram1_addr_o : 	out DataAddrBus ;
		ram1_re_o :		out STD_LOGIC ;
		ram1_we_o :		out STD_LOGIC ;
		ram1_ce_o :		out STD_LOGIC; -- ce = ChipEnable -> 
		
		--ram 2 
		ram2_data_i:	in 	DataBus ;
		ram2_data_o : 	out DataBus ;
		ram2_addr_o : 	out DataAddrBus ;
		ram2_re_o :		out STD_LOGIC ;
		ram2_we_o :		out STD_LOGIC ;
		ram2_ce_o :		out STD_LOGIC; -- ce = RamChipEnable -> Ram Read    &    ce = RamChipDisable ->  PC Read

		--stall_reg
		stall_req : out STD_LOGIC 
        );
    END COMPONENT;
    
   --Inputs
   signal we_i : std_logic := '0';
   signal wdata_i : std_logic_vector(15 downto 0) := (others => '0');
   signal waddr_i : std_logic_vector(3 downto 0) := (others => '0');
   signal memaddr_i : std_logic_vector(15 downto 0) := (others => '0');
   signal memrw_i : std_logic_vector(1 downto 0) := (others => '0');
   signal memdata_i : std_logic_vector(15 downto 0) := (others => '0');
   signal ram1_data_i : std_logic_vector(15 downto 0) := (others=>'0');
   signal ram2_data_i : std_logic_vector(15 downto 0) := (others=>'0');
   signal rst : std_logic := RstDisable;

 	--Outputs
   signal we_o : std_logic;
   signal waddr_o : std_logic_vector(3 downto 0);
   signal wdata_o : std_logic_vector(15 downto 0);
   signal ram1_re_o : std_logic:='0';
   signal ram1_we_o : std_logic:='0';
   signal ram1_addr_o : std_logic_vector(15 downto 0);
   signal ram1_data_o : std_logic_vector(15 downto 0);
   signal ram1_ce_o : std_logic:='0';
   signal ram2_re_o : std_logic:='0';
   signal ram2_we_o : std_logic:='0';
   signal ram2_addr_o : std_logic_vector(15 downto 0);
   signal ram2_data_o : std_logic_vector(15 downto 0);
   signal ram2_ce_o : std_logic:='0';
   signal stall_req : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mem PORT MAP (
          we_i => we_i,
          wdata_i => wdata_i,
          waddr_i => waddr_i,
          memaddr_i => memaddr_i,
          memrw_i => memrw_i,
          memdata_i => memdata_i,
          rst => rst,
          we_o => we_o,
          waddr_o => waddr_o,
          wdata_o => wdata_o,
          ram1_re_o => ram1_re_o,
          ram1_we_o => ram1_we_o,
          ram1_addr_o => ram1_addr_o,
          ram1_data_o => ram1_data_o,
          ram1_data_i => ram1_data_i,
          ram1_ce_o => ram1_ce_o,
          ram2_re_o => ram2_re_o,
          ram2_we_o => ram2_we_o,
          ram2_addr_o => ram2_addr_o,
          ram2_data_o => ram2_data_o,
          ram2_data_i => ram2_data_i,
          ram2_ce_o => ram2_ce_o,
          stall_req => stall_req
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      wait for 10 ns;	
	--write ram
	we_i<='1';
	memrw_i <= MemRW_Write;
	memaddr_i <= "0010001000100010";--2222
	memdata_i <= "0100010001000100";--4444
      wait for 100 ns;	
	--write reg
	we_i <= '0';
	wdata_i <= "0001000100010001";--1111
	waddr_i <= "0010";--2
	memrw_i <= MemRW_Idle;
      wait for 100 ns;	
	--read ram
	memrw_i <= MemRW_Read;
	memaddr_i <= "0001000100010001";--1111
	waddr_i <= "0100";--4
	  wait for 10 ns;
	ram1_data_i<="0000000000000001";
	ram2_data_i<="0000000000000010";
      wait for 90 ns;	
	rst <= RstEnable;
	wait;
   end process;

END;
