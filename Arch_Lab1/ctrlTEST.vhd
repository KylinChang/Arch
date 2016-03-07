--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:28:08 06/12/2015
-- Design Name:   
-- Module Name:   C:/Xilinx/Org_Lab11/ctrlTEST.vhd
-- Project Name:  Org_Lab9
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ctrl
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
 
ENTITY ctrlTEST IS
END ctrlTEST;
 
ARCHITECTURE behavior OF ctrlTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ctrl
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         Inst_in : IN  std_logic_vector(31 downto 0);
         zero : IN  std_logic;
         overflow : IN  std_logic;
         MIO_ready : IN  std_logic;
         MemRead : OUT  std_logic;
         MemWrite : OUT  std_logic;
         ALU_operation : OUT  std_logic_vector(2 downto 0);
         state_out : OUT  std_logic_vector(4 downto 0);
         CPU_MIO : OUT  std_logic;
         IorD : OUT  std_logic;
         IRWrite : OUT  std_logic;
         RegDst : OUT  std_logic_vector(1 downto 0);
         RegWrite : OUT  std_logic;
         MemtoReg : OUT  std_logic_vector(1 downto 0);
         ALUSrcA : OUT  std_logic;
         ALUSrcB : OUT  std_logic_vector(1 downto 0);
         PCSource : OUT  std_logic_vector(1 downto 0);
         PCWrite : OUT  std_logic;
         PCWriteCond : OUT  std_logic;
         Branch : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal Inst_in : std_logic_vector(31 downto 0) := (others => '0');
   signal zero : std_logic := '0';
   signal overflow : std_logic := '0';
   signal MIO_ready : std_logic := '0';

 	--Outputs
   signal MemRead : std_logic;
   signal MemWrite : std_logic;
   signal ALU_operation : std_logic_vector(2 downto 0);
   signal state_out : std_logic_vector(4 downto 0);
   signal CPU_MIO : std_logic;
   signal IorD : std_logic;
   signal IRWrite : std_logic;
   signal RegDst : std_logic_vector(1 downto 0);
   signal RegWrite : std_logic;
   signal MemtoReg : std_logic_vector(1 downto 0);
   signal ALUSrcA : std_logic;
   signal ALUSrcB : std_logic_vector(1 downto 0);
   signal PCSource : std_logic_vector(1 downto 0);
   signal PCWrite : std_logic;
   signal PCWriteCond : std_logic;
   signal Branch : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ctrl PORT MAP (
          clk => clk,
          reset => reset,
          Inst_in => Inst_in,
          zero => zero,
          overflow => overflow,
          MIO_ready => MIO_ready,
          MemRead => MemRead,
          MemWrite => MemWrite,
          ALU_operation => ALU_operation,
          state_out => state_out,
          CPU_MIO => CPU_MIO,
          IorD => IorD,
          IRWrite => IRWrite,
          RegDst => RegDst,
          RegWrite => RegWrite,
          MemtoReg => MemtoReg,
          ALUSrcA => ALUSrcA,
          ALUSrcB => ALUSrcB,
          PCSource => PCSource,
          PCWrite => PCWrite,
          PCWriteCond => PCWriteCond,
          Branch => Branch
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
