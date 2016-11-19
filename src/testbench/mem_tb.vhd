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
         we_i : IN  std_logic;
         wdata_i : IN  std_logic_vector(15 downto 0);
         waddr_i : IN  std_logic_vector(3 downto 0);
         memaddr_i : IN  std_logic_vector(15 downto 0);
         memrw_i : IN  std_logic_vector(1 downto 0);
         ram_data_i : IN  std_logic_vector(15 downto 0);
         rst : IN  std_logic;
         we_o : OUT  std_logic;
         waddr_o : OUT  std_logic_vector(3 downto 0);
         wdata_o : OUT  std_logic_vector(15 downto 0);
         ram_re_o : OUT  std_logic;
         ram_we_o : OUT  std_logic;
         ram_addr_o : OUT  std_logic_vector(15 downto 0);
         ram_data_o : OUT  std_logic_vector(15 downto 0);
         ram_ce_o : OUT  std_logic;
         stall_req : OUT  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal we_i : std_logic := '0';
   signal wdata_i : std_logic_vector(15 downto 0) := (others => '0');
   signal waddr_i : std_logic_vector(3 downto 0) := (others => '0');
   signal memaddr_i : std_logic_vector(15 downto 0) := (others => '0');
   signal memrw_i : std_logic_vector(1 downto 0) := (others => '0');
   signal ram_data_i : std_logic_vector(15 downto 0) := "1111111100000000";
   signal rst : std_logic := RstDisable;

 	--Outputs
   signal we_o : std_logic;
   signal waddr_o : std_logic_vector(3 downto 0);
   signal wdata_o : std_logic_vector(15 downto 0);
   signal ram_re_o : std_logic;
   signal ram_we_o : std_logic;
   signal ram_addr_o : std_logic_vector(15 downto 0);
   signal ram_data_o : std_logic_vector(15 downto 0);
   signal ram_ce_o : std_logic;
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
          ram_data_i => ram_data_i,
          rst => rst,
          we_o => we_o,
          waddr_o => waddr_o,
          wdata_o => wdata_o,
          ram_re_o => ram_re_o,
          ram_we_o => ram_we_o,
          ram_addr_o => ram_addr_o,
          ram_data_o => ram_data_o,
          ram_ce_o => ram_ce_o,
          stall_req => stall_req
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      wait for 10 ns;	
	--write ram
	memrw_i <= MemRW_Write;
	memaddr_i <= "0010001000100010";--2222
	wdata_i <= "0100010001000100";--4444
      wait for 100 ns;	
	--write reg
	we_i <= '1';
	wdata_i <= "0001000100010001";--1111
	waddr_i <= "0010";--2
	memrw_i <= MemRW_Idle;
      wait for 100 ns;	
	--read ram
	memrw_i <= MemRW_Read;
	memaddr_i <= "0001000100010001";--1111
	waddr_i <= "0100";--4
      wait for 100 ns;	
	rst <= RstEnable;
	wait;
   end process;

END;
