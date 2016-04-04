`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:52 03/06/2016 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
input clk,							//CLK_CPU
input reset,
input MIO_ready,
								
output[31:0] PC_out,		   	//TEST
output[31:0] inst_out,			//TEST
output mem_w,
output[31:0] Addr_out,
output[31:0] Data_out, 
input [31:0] Inst_in,
input [31:0] Data_in,
output CPU_MIO,
input INT
);

wire JAL, WREG, M2REG, WMEM, ALUIMM, SHIFT, REGRT, JR, JUMP, RS_EQU_RT, overflow;
wire BRANCH, WPCIR;
wire[1:0] FWDA, FWDB;
wire[2:0] ALU_OP; 
wire[31:0] Inst_R;


Ctrl(
.clk(clk),
.reset(reset),
.op(Inst_R[31:26]),
.func(Inst_R[5:0]),
.rs(Inst_R[25:21]),
.rt(Inst_R[20:16]),
.RS_EQU_RT(RS_EQU_RT),

.JAL(JAL),
.WREG(WREG),
.M2REG(M2REG),
.WMEM(WMEM),
.ALUC(ALU_OP[2:0]),
.ALUIMM(ALUIMM),
.SHIFT(SHIFT),
.REGRT(REGRT),
.FWDB(FWDB[1:0]),
.FWDA(FWDA[1:0]),
.JR(JR),
.JUMP(JUMP),

.BRANCH(BRANCH),
.WPCIR(WPCIR)
);


DataPath(
.clk(clk),
.reset(reset),
.MIO_ready(MIO_ready),
					  
.JAL(JAL),
.WREG(WREG),
.M2REG(M2REG),
.WMEM(WMEM),
.ALUC(ALU_OP[2:0]),
.ALUIMM(ALUIMM),
.SHIFT(SHIFT),
.REGRT(REGRT),
.FWDB(FWDB[1:0]),
.FWDA(FWDA[1:0]),
.JR(JR),
.JUMP(JUMP),

.BRANCH(BRANCH),
.WPCIR(WPCIR),
					  
.PC_Current(PC_out[31:0]),
.inst2CPU(Inst_in[31:0]), 
.data2CPU(Data_in[31:0]),
					  
.Inst_R(Inst_R[31:0]),
.data_out(Data_out[31:0]),
.M_addr(Addr_out[31:0]),

.RS_EQU_RT(RS_EQU_RT)
);

endmodule
