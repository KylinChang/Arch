`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:43 04/28/2012 
// Design Name: 
// Module Name:    single_cycle_Cpu_9 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Muliti_CPU(input clk,							//muliti_CPU
						input reset,
						input MIO_ready,
								
						output[31:0] PC_out,		   	//TEST
						output[31:0] inst_out,			//TEST
						output mem_w,
						output[31:0] Addr_out,
						output[31:0] Data_out, 
						input [31:0] Data_in,
						output CPU_MIO,
						input INT,
						output[4:0]state,					//Test
						
						output[31:0] register0,
	output[31:0] register1,
	output[31:0] register2,
	output[31:0] register3,
	output[31:0] register4,
	output[31:0] register5,
	output[31:0] register6,
	output[31:0] register7,
	output[31:0] register8,
	output[31:0] register9,
	output[31:0] register10,
	output[31:0] register11,
	output[31:0] register12,
	output[31:0] register13,
	output[31:0] register14,
	output[31:0] register15,
	output[31:0] register16,
	output[31:0] register17,
	output[31:0] register18,
	output[31:0] register19,
	output[31:0] register20,
	output[31:0] register21,
	output[31:0] register22,
	output[31:0] register23,
	output[31:0] register24,
	output[31:0] register25,
	output[31:0] register26,
	output[31:0] register27,
	output[31:0] register28,
	output[31:0] register29,
	output[31:0] register30,
	output[31:0] register31
					  );

wire zero,overflow,MemRead,MemReada,MemWrite;
wire IorD,IRWrite,RegWrite,ALUSrcA,PCWrite,PCWriteCond;
wire Branch;
wire[1:0] RegDst,MemtoReg,PCSource,ALUSrcB;
wire[2:0] ALU_operation;
//wire[31:0] inst_in;

assign MemReada=~MemRead;
assign mem_w=MemReada&MemWrite;

ctrl U11(
.clk(clk),
.reset(reset),
.zero(zero),
.overflow(overflow),
.MIO_ready(MIO_ready),
.Inst_in(inst_out[31:0]),

.MemRead(MemRead),
.MemWrite(MemWrite),
.CPU_MIO(CPU_MIO),
.IorD(IorD),
.IRWrite(IRWrite),
.RegWrite(RegWrite),
.ALUSrcA(ALUSrcA),
.PCWrite(PCWrite),
.PCWriteCond(PCWriteCond),
.Branch(Branch),
.RegDst(RegDst[1:0]),
.MemtoReg(MemtoReg[1:0]),
.ALUSrcB(ALUSrcB[1:0]),
.PCSource(PCSource[1:0]),
.ALU_operation(ALU_operation[2:0]),
.state_out(state[4:0])
);
								  

data_path U1_2(
.clk(clk),
.reset(reset),
.MIO_ready(MIO_ready),
.IorD(IorD),
.IRWrite(IRWrite),
.RegWrite(RegWrite),
.ALUSrcA(ALUSrcA),
.PCWrite(PCWrite),
.PCWriteCond(PCWriteCond),
.Branch(Branch),
.RegDst(RegDst[1:0]),
.MemtoReg(MemtoReg[1:0]),
.ALUSrcB(ALUSrcB[1:0]),
.PCSource(PCSource[1:0]),
.ALU_operation(ALU_operation[2:0]),
.data2CPU(Data_in[31:0]),

.zero(zero),
.overflow(overflow),
.PC_Current(PC_out[31:0]),
.Inst_R(inst_out[31:0]),
.data_out(Data_out[31:0]),
.M_addr(Addr_out[31:0]),
.register0(register0),
.register1(register1),
.register2(register2),
.register3(register3),
.register4(register4),
.register5(register5),
.register6(register6),
.register7(register7),
.register8(register8),
.register9(register9),
.register10(register10),
.register11(register11),
.register12(register12),
.register13(register13),
.register14(register14),
.register15(register15),
.register16(register16),
.register17(register17),
.register18(register18),
.register19(register19),
.register20(register20),
.register21(register21),
.register22(register22),
.register23(register23),
.register24(register24),
.register25(register25),
.register26(register26),
.register27(register27),
.register28(register28),
.register29(register29),
.register30(register30),
.register31(register31)
);

endmodule




