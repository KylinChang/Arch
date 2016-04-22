`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:08:46 04/04/2016
// Design Name:   CPU
// Module Name:   D:/GitHub/Arch/Arch_Lab2/CPU_SIM.v
// Project Name:  Arch_Lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CPU_SIM;

	// Inputs
	reg clk;
	reg reset;
	reg MIO_ready;
	reg [31:0] Inst_in;
	reg [31:0] Data_in;
	reg INT;

	// Outputs
	wire [31:0] PC_out;
	wire [31:0] inst_out;
	wire mem_w;
	wire [31:0] Addr_out;
	wire [31:0] Data_out;
	wire CPU_MIO;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.reset(reset), 
		.MIO_ready(MIO_ready), 
		.PC_out(PC_out), 
		.inst_out(inst_out), 
		.mem_w(mem_w), 
		.Addr_out(Addr_out), 
		.Data_out(Data_out), 
		.Inst_in(Inst_in), 
		.Data_in(Data_in), 
		.CPU_MIO(CPU_MIO), 
		.INT(INT)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		MIO_ready = 0;
		Inst_in = 0;
		Data_in = 0;
		INT = 0;

		// Wait 100 ns for global reset to finish
		#50;
      clk=1;
		Inst_in = 32'h00000826;
		#50;
		clk=0;
		#50;
      clk=1;
		Inst_in = 32'h00211020;
		#50;
		clk=0;
		#50;
      clk=1;
		Inst_in = 32'h08000000;
		#50;
		clk=0;
		#50;
		clk=1;
		#50;
		clk=0;
		#50;
		clk=1;
		#50;
		clk=0;
		#50;
		clk=1;
		// Add stimulus here

	end
      
endmodule

