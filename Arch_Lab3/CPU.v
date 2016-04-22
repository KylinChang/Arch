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
output[31:0] Inst_out,			//TEST
output mem_w,
output[31:0] Addr_out,
output[31:0] Data_out,
output[31:0] res, 
input [31:0] Inst_in,
input [31:0] Data_in,
output CPU_MIO,
input INT,
output wire[1:0] FWA,
output wire[1:0] FWB,
output wire[31:0] TESTA,
output wire[31:0] TESTB,
output wire[2:0] ALUOP,
output wire BRANCH,
output wire[31:0]Imm_Addr,

	output[31:0] reg1,
	output[31:0] reg2,
	output[31:0] reg3,
	output[31:0] reg4,
	output[31:0] reg5,
	output[31:0] reg6,
	output[31:0] reg7,
	output[31:0] reg8,
	output[31:0] reg9,
	output[31:0] reg10,
	output[31:0] reg11,
	output[31:0] reg12,
	output[31:0] reg13,
	output[31:0] reg14,
	output[31:0] reg15,
	output[31:0] reg16,
	output[31:0] reg17,
	output[31:0] reg18,
	output[31:0] reg19,
	output[31:0] reg20,
	output[31:0] reg21,
	output[31:0] reg22,
	output[31:0] reg23,
	output[31:0] reg24,
	output[31:0] reg25,
	output[31:0] reg26,
	output[31:0] reg27,
	output[31:0] reg28,
	output[31:0] reg29,
	output[31:0] reg30,
	output[31:0] reg31
);

wire JAL, WREG, M2REG, WMEM, ALUIMM, SHIFT, REGRT, JR, JUMP, RS_EQU_RT, SEXT, WPCIR, overflow,WMEMW;
wire[1:0] FWDA, FWDB;
wire[3:0] ALU_OP; 
wire[31:0] Inst_R;

assign FWA[1:0] = FWDA[1:0];
assign FWB[1:0] = FWDB[1:0];
assign Inst_out[31:0] = Inst_R[31:0];
assign ALUOP[2:0] = ALU_OP[2:0];
Ctrl ctrl(
.clk(clk),
.reset(reset),
.op(Inst_R[31:26]),
.func(Inst_R[5:0]),
.rs(Inst_R[25:21]),
.rt(Inst_R[20:16]),
.rd(Inst_R[15:11]),
.RS_EQU_RT(RS_EQU_RT),

.JAL(JAL),
.WREG(WREG),
.M2REG(M2REG),
.WMEM(WMEM),
.ALUC(ALU_OP[3:0]),
.ALUIMM(ALUIMM),
.SHIFT(SHIFT),
.REGRT(REGRT),
.FWDB(FWDB[1:0]),
.FWDA(FWDA[1:0]),
.JR(JR),
.JUMP(JUMP),
.SEXT(SEXT),

.BRANCH(BRANCH),
.WPCIR(WPCIR),
.WMEMW(WMEMW)
);


DataPath datapath(
.clk(clk),
.reset(reset),
.MIO_ready(MIO_ready),
					  
.JAL(JAL),
.WREG(WREG),
.M2REG(M2REG),
.WMEM(WMEM),
.ALUC(ALU_OP[3:0]),
.ALUIMM(ALUIMM),
.SHIFT(SHIFT),
.REGRT(REGRT),
.FWDB(FWDB[1:0]),
.FWDA(FWDA[1:0]),
.JR(JR),
.JUMP(JUMP),
.SEXT(SEXT),

.BRANCH(BRANCH),
.WPCIR(WPCIR),
.WMEMW(WMEMW),
.MWMEM(mem_w),
					  
.PC_Current(PC_out[31:0]),
.inst2CPU(Inst_in[31:0]), 
.data2CPU(Data_in[31:0]),
					  
.Inst_R(Inst_R[31:0]),
.data_out(Addr_out[31:0]),
.M_addr(Data_out[31:0]),
.Imm_Addr(Imm_Addr[31:0]),

.RS_EQU_RT(RS_EQU_RT),
.TESTA(TESTA),
.TESTB(TESTB),
.res(res[31:0]),

.reg1(reg1[31:0]),
.reg2(reg2[31:0]),
.reg3(reg3[31:0]),
.reg4(reg4[31:0]),
.reg5(reg5[31:0]),
.reg6(reg6[31:0]),
.reg7(reg7[31:0]),
.reg8(reg8[31:0]),
.reg9(reg9[31:0]),
.reg10(reg10[31:0]),
.reg11(reg11[31:0]),
.reg12(reg12[31:0]),
.reg13(reg13[31:0]),
.reg14(reg14[31:0]),
.reg15(reg15[31:0]),
.reg16(reg16[31:0]),
.reg17(reg17[31:0]),
.reg18(reg18[31:0]),
.reg19(reg19[31:0]),
.reg20(reg20[31:0]),
.reg21(reg21[31:0]),
.reg22(reg22[31:0]),
.reg23(reg23[31:0]),
.reg24(reg24[31:0]),
.reg25(reg25[31:0]),
.reg26(reg26[31:0]),
.reg27(reg27[31:0]),
.reg28(reg28[31:0]),
.reg29(reg29[31:0]),
.reg30(reg30[31:0]),
.reg31(reg31[31:0])
);

endmodule
