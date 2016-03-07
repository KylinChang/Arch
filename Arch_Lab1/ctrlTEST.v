`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:28:50 06/12/2015
// Design Name:   ctrl
// Module Name:   C:/Xilinx/Org_Lab11/ctrlTEST.v
// Project Name:  Org_Lab9
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ctrl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ctrlTEST;

	// Inputs
	reg clk;
	reg reset;
	reg [31:0] Inst_in;
	reg zero;
	reg overflow;
	reg MIO_ready;

	// Outputs
	wire MemRead;
	wire MemWrite;
	wire [2:0] ALU_operation;
	wire [4:0] state_out;
	wire CPU_MIO;
	wire IorD;
	wire IRWrite;
	wire [1:0] RegDst;
	wire RegWrite;
	wire [1:0] MemtoReg;
	wire ALUSrcA;
	wire [1:0] ALUSrcB;
	wire [1:0] PCSource;
	wire PCWrite;
	wire PCWriteCond;
	wire Branch;

	// Instantiate the Unit Under Test (UUT)
	ctrl uut (
		.clk(clk), 
		.reset(reset), 
		.Inst_in(Inst_in), 
		.zero(zero), 
		.overflow(overflow), 
		.MIO_ready(MIO_ready), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.ALU_operation(ALU_operation), 
		.state_out(state_out), 
		.CPU_MIO(CPU_MIO), 
		.IorD(IorD), 
		.IRWrite(IRWrite), 
		.RegDst(RegDst), 
		.RegWrite(RegWrite), 
		.MemtoReg(MemtoReg), 
		.ALUSrcA(ALUSrcA), 
		.ALUSrcB(ALUSrcB), 
		.PCSource(PCSource), 
		.PCWrite(PCWrite), 
		.PCWriteCond(PCWriteCond), 
		.Branch(Branch)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		Inst_in = 0;
		zero = 0;
		overflow = 0;
		MIO_ready = 0;
     
		// Wait 100 ns for global reset to finish
		#20;
		reset=1;
		#80;
		reset=0;
		MIO_ready = 1;
		clk = 1;
      Inst_in[31:0]  =  32'h3c03f000;
		#20;
		clk=0;
		#20;
		clk=1;
		#20;
		clk=0;
		#20;
		clk=1;
		#20;
		clk=0;
		#20;
		clk=1;
		
		#20;
		clk=0;
		#20;
		clk=1;
		Inst_in[31:0] = 32'h2014003f;
		#20;
		clk=0;
		#20;
		clk=1;
		#20;
		clk=0;
		#20;
		clk=1;
		#20;
		clk=0;
		#20;
		clk=1;
		
		#20;
		clk=0;
		#20;
		clk=1;
		Inst_in[31:0] = 32'h11600005;
		#20;
		clk=0;
		#20;
		clk=1;
		#20;
		clk=0;
		#20;
		clk=1;
		#20;
		clk=0;
		#20;
		clk=1;
		// Add stimulus here

	end
      
endmodule

