--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:08:21 04/04/2016
-- Design Name:   
-- Module Name:   D:/GitHub/Arch/Arch_Lab2/CPU_SIM.vhd
-- Project Name:  Arch_Lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CPU_SIM IS
END CPU_SIM;
 
ARCHITECTURE behavior OF CPU_SIM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         MIO_ready : IN  std_logic;
         PC_out : OUT  std_logic_vector(31 downto 0);
         inst_out : OUT  std_logic_vector(31 downto 0);
         mem_w : OUT  std_logic;
         Addr_out : OUT  std_logic_vector(31 downto 0);
         Data_out : OUT  std_logic_vector(31 downto 0);
         Inst_in : IN  std_logic_vector(31 downto 0);
         Data_in : IN  std_logic_vector(31 downto 0);
         CPU_MIO : OUT  std_logic;
         INT : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal MIO_ready : std_logic := '0';
   signal Inst_in : std_logic_vector(31 downto 0) := (others => '0');
   signal Data_in : std_logic_vector(31 downto 0) := (others => '0');
   signal INT : std_logic := '0';

 	--Outputs
   signal PC_out : std_logic_vector(31 downto 0);
   signal inst_out : std_logic_vector(31 downto 0);
   signal mem_w : std_logic;
   signal Addr_out : std_logic_vector(31 downto 0);
   signal Data_out : std_logic_vector(31 downto 0);
   signal CPU_MIO : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          clk => clk,
          reset => reset,
          MIO_ready => MIO_ready,
          PC_out => PC_out,
          inst_out => inst_out,
          mem_w => mem_w,
          Addr_out => Addr_out,
          Data_out => Data_out,
          Inst_in => Inst_in,
          Data_in => Data_in,
          CPU_MIO => CPU_MIO,
          INT => INT
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

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
