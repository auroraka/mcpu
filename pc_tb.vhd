--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:45:56 11/17/2016
-- Design Name:   
-- Module Name:   F:/2016FALL/JY/cpu/mcpu/pc_tb.vhd
-- Project Name:  mcpu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pc
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
USE work.PACK.ALl;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY pc_tb IS
END pc_tb;
 
ARCHITECTURE behavior OF pc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pc
    PORT(
         stall : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         branch_flag_o : IN  std_logic;
         branch_addr_o : IN  std_logic_vector(15 downto 0);
         pc : OUT  std_logic_vector(15 downto 0);
         ce : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal stall : std_logic := StallNo;
   signal clk : std_logic := '0';
   signal rst : std_logic := RstEnable;
   signal branch_flag_o : std_logic := BranchFlagDown;
   signal branch_addr_o : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal pcc : std_logic_vector(15 downto 0);
   signal ce : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pc PORT MAP (
          stall => stall,
          clk => clk,
          rst => rst,
          branch_flag_o => branch_flag_o,
          branch_addr_o => branch_addr_o,
          pc => pcc,
          ce => ce
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			rst <= RstDisable;

      wait for clk_period*10;
			stall <= StallYes;
		wait for clk_period;
			stall <= StallNo;

      wait for clk_period*10;
			branch_flag_o <= BranchFlagUp;
		wait for clk_period;
			branch_flag_o <= BranchFlagDown;
      -- insert stimulus here 

      wait;
   end process;

END;
