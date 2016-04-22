`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:15 03/30/2016 
// Design Name: 
// Module Name:    DataPath 
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
module DataPath(
input clk,
input reset,
input MIO_ready,
					  
input wire JAL,
input wire WREG,
input wire M2REG,
input wire WMEM,
input wire[3:0] ALUC,
input wire ALUIMM,
input wire SHIFT,
input wire REGRT,
input wire SEXT,
input wire[1:0] FWDB,
input wire[1:0] FWDA,
input wire JR,
input wire JUMP,

input wire BRANCH,
input wire WPCIR,
input wire WMEMW,
output wire MWMEM,
					  
output wire[31:0]PC_Current,//current PC 
input wire[31:0]inst2CPU,  //instructions from Inst_MEM to CPU
input wire[31:0]data2CPU,  //data from Data_MEM to CPU
					  
output wire[31:0]Inst_R,
output wire[31:0]data_out,
output wire[31:0]M_addr,
output wire[31:0]Imm_Addr,
 
output wire RS_EQU_RT,

output wire[31:0] TESTA,
output wire[31:0] TESTB,
output wire[31:0] res,

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

wire[31:0] o_PC, IF_PC, ID_PC, mux_Wt_data, rdata_A, rdata_B;
wire[31:0] Imm_32, Imm_Ext;
wire[31:0] JAddr, JMUX_Addr, JRMUX_Addr;
wire[31:0] Data_A, Data_B, ID_SrcA, ID_SrcB;
wire[4:0] RD_RT, REG_ADDR;

wire EWREG, EM2REG, EWMEM, EAUIMM, ESHIFT;
wire[3:0] EALUC;
wire[31:0] SA, EXE_SrcA, EXE_SrcB, EXE_REG_ADDR, ALU_SrcA, ALU_SrcB;
wire zero, overflow;

wire MWREG, MM2REG;
wire[4:0] MEM_REG_ADDR;

wire WWREG,WM2REG;
wire[31:0] WB_DATA,WB_MEM_A,WB_data_out;
wire[4:0] WB_REG_ADDR;

assign TESTA = Data_A;
assign TESTB = Data_B;
/*************************  IF STAGE  *****************************/
REG32 PC(
.clk(clk),
.rst(reset),
.CE(WPCIR),
.BRANCH(BRANCH),
.D(o_PC[31:0]),
.Q(PC_Current[31:0])
);

Adder NPC(
.A(PC_Current[31:0]),
.B(32'h4),
.O(IF_PC[31:0])
);

mux2to1_32(
.sel(BRANCH),
.a(JRMUX_Addr[31:0]),
.b(IF_PC[31:0]),
.o(o_PC[31:0])
);

/*************************  ID STAGE  *****************************/
IR_REG REG32_IR(
.clk(clk),
.rst(reset),
.CE(WPCIR),
.D(inst2CPU[31:0]),
.Q(Inst_R[31:0]),
.IF_PC(IF_PC[31:0]),
.ID_PC(ID_PC[31:0])
);

IMM_32 imm_32(
.imm_16(Inst_R[15:0]),
.imm_32(Imm_Ext[31:0])
);

Adder Imm_Adder(
.A(ID_PC[31:0]),
.B(Imm_Ext[31:0]),
.O(Imm_Addr[31:0])
);

mux2to1_32 JUMP_MUX(
.sel(JUMP),
.a({ID_PC[31:28], Inst_R[25:0],2'b00}),
.b(Imm_Addr[31:0]),
.o(JMUX_Addr[31:0])
);

mux2to1_32 JR_MUX(
.sel(JAL),
.a(Data_A[31:0]),
.b(JMUX_Addr[31:0]),
.o(JRMUX_Addr[31:0])
);

Regs regs(
.clk(clk),
.rst(reset),
.R_addr_A(Inst_R[25:21]),
.R_addr_B(Inst_R[20:16]),
.Wt_addr(WB_REG_ADDR[4:0]),
.Wt_data(WB_data_out[31:0]),
.L_S(WWREG),
.rdata_A(rdata_A[31:0]),
.rdata_B(rdata_B[31:0]),

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

mux4to1_32 rdataA(
.sel(FWDA[1:0]),
.A(rdata_A[31:0]),
.B(res[31:0]),
.C(data_out[31:0]),
.D(data2CPU[31:0]),
.O(Data_A[31:0])
);

mux4to1_32 rdataB(
.sel(FWDB[1:0]),
.A(rdata_B[31:0]),
.B(res[31:0]),
.C(data_out[31:0]),
.D(data2CPU[31:0]),
.O(Data_B[31:0])
);

EQU equ(
.a(Data_A[31:0]),
.b(Data_B[31:0]),
.equ(RS_EQU_RT)
);

Ext_32 ext_32(
.SEXT(SEXT),
.imm_16(Inst_R[15:0]),
.imm_32(Imm_32[31:0])
);

mux2to1_32 ID_SRCA(
.sel(JAL),
.a(ID_PC[31:0]),
.b(Data_A[31:0]),
.o(ID_SrcA[31:0])
);

mux2to1_32 ID_SRCB(
.sel(JAL),
.a(32'h0),
.b(Data_B[31:0]),
.o(ID_SrcB[31:0])
);

mux2to1_5 RD_MUX_RT(
.sel(REGRT),
.a(Inst_R[15:11]),
.b(Inst_R[20:16]),
.o(RD_RT[4:0])
);

mux2to1_5 REG_MUX_ADDR(
.sel(JAL),
.a(5'b11111),
.b(RD_RT[4:0]),
.o(REG_ADDR[4:0])
);
/*************************  EXE STAGE  *****************************/
EXE_REG exe_reg(
.clk(clk),
.rst(reset),
.WREG(WREG),
.M2REG(M2REG),
.WMEM(WMEM),
.ALUC(ALUC[3:0]),
.ALUIMM(ALUIMM),
.SHIFT(SHIFT),

.WMEMW(WMEMW),

.ID_SrcA(ID_SrcA[31:0]),
.ID_SrcB(ID_SrcB[31:0]),
.SE(Imm_32[31:0]),
.REG_ADDR(REG_ADDR[4:0]),

.EWREG(EWREG),
.EM2REG(EM2REG),
.EWMEM(EWMEM),
.EALUC(EALUC[3:0]),
.EALUIMM(EALUIMM),
.ESHIFT(ESHIFT),

.EXE_SrcA(EXE_SrcA[31:0]),
.EXE_SrcB(EXE_SrcB[31:0]),
.SA(SA[31:0]),
.EXE_REG_ADDR(EXE_REG_ADDR[4:0])
);

mux2to1_32 MUXA(
.sel(ESHIFT),
.a(SA[31:0]),
.b(EXE_SrcA[31:0]),
.o(ALU_SrcA[31:0])
);

mux2to1_32 MUXB(
.sel(EALUIMM),
.a(SA[31:0]),
.b(EXE_SrcB[31:0]),
.o(ALU_SrcB[31:0])
);

ALU alu(
.A(ALU_SrcA[31:0]),
.B(ALU_SrcB[31:0]),
.ALU_operation(EALUC[3:0]),

.zero(zero),
.res(res[31:0]),
.overflow(overflow)
);


/*************************  MEM STAGE  *****************************/
MEM_REG mem_reg(
.clk(clk),
.rst(reset),
.EWREG(EWREG),
.EM2REG(EM2REG),
.EWMEM(EWMEM),

.res(res[31:0]),
.EXE_SrcB(EXE_SrcB[31:0]),
.EXE_REG_ADDR(EXE_REG_ADDR[4:0]),

.MWREG(MWREG),
.MM2REG(MM2REG),
.MWMEM(MWMEM),
.DATA_MEM_A(data_out[31:0]),
.DATA_MEM_WD(M_addr[31:0]),
.MEM_REG_ADDR(MEM_REG_ADDR[4:0])
);


/*************************  WB STAGE  *****************************/
WB_REG wb_reg(
.clk(clk),
.rst(reset),

.MWREG(MWREG),
.MM2REG(MM2REG),

.data_in(data2CPU[31:0]),
.DATA_MEM_A(data_out[31:0]),
.MEM_REG_ADDR(MEM_REG_ADDR[4:0]),

.WWREG(WWREG),
.WM2REG(WM2REG),
.WB_DATA(WB_DATA[31:0]),
.WB_MEM_A(WB_MEM_A[31:0]),
.WB_REG_ADDR(WB_REG_ADDR[4:0])
);

mux2to1_32 wb_data_mem(
.sel(WM2REG),
.a(WB_DATA[31:0]),
.b(WB_MEM_A[31:0]),
.o(WB_data_out[31:0])
);

endmodule
