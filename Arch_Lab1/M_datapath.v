`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:45 06/04/2015 
// Design Name: 
// Module Name:    M_datapath 
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
module M_datapath(
input wire clk,
input wire reset,
input wire MIO_ready,
input wire IorD,
input wire IRWrite,
input wire RegWrite,
input wire ALUSrcA,
input wire PCWrite,
input wire PCWriteCond,
input wire Branch,
input wire[1:0] RegDst,
input wire[1:0] MemtoReg,
input wire[1:0] ALUSrcB,
input wire[1:0] PCSource,
input wire[2:0] ALU_operation,
input wire[31:0] data2CPU,

output wire zero,
output wire overflow,
output wire[31:0] PC_Current,
output wire[31:0] inst_in,
output wire[31:0] data_out,
output wire[31:0] M_addr,
output wire[31:0] Inst
    );

wire PC_CE;
wire[4:0] ra;
wire[4:0] mux_Wt_addr;
wire[31:0] IR,MDR,lui,rdata_A,rdata_B,mux_Wt_data;
wire[31:0] SrcA_out,SrcB_out,res,ALUOut,Imm_32,o_PC;
wire o_xora,o_and,o_or;

assign Data_out=rdata_B[31:0];
assign Inst=IR[31:0];

assign o_xora=~(zero^Branch);
assign o_and=o_xora&PCWriteCond;
assign o_or=o_and|PCWrite;
assign PC_CE=o_or&MIO_ready;
assign lui[31:0]=res[31:0];

ALU U1(
.ALU_operation(ALU_operation[2:0]),
.A(SrcA_out[31:0]),
.B(SrcB_out[31:0]),
.zero(zero),
.res(res[31:0]),
.overflow(overflow)
);

Regs U2(
.clk(clk),
.rst(rst),
.R_addr_A(IR[25:21]),
.R_addr_B(IR[20:16]),
.Wt_addr(mux_Wt_addr[4:0]),
.Wt_data(mux_Wt_data[31:0]),
.L_S(RegWrite),
.rdata_A(rdata_A[31:0]),
.rdata_B(rdata_B[31:0])
);

REG32 REG32_IR(
.clk(clk),
.rst(1'b0),
.CE(IRWrite),
.D(data2CPU[31:0]),
.Q(IR[31:0])
);

REG32 REG32_MDR(
.clk(clk),
.rst(1'b0),
.CE(1'b1),
.D(data2CPU[31:0]),
.Q(MDR[31:0])
);

REG32 ALUOUT(
.clk(clk),
.rst(1'b0),
.CE(1'b1),
.D(res[31:0]),
.Q(ALUOut[31:0])
);

REG32 PC(
.clk(clk),
.rst(rst),
.CE(PC_CE),
.D(o_PC[31:0]),
.Q(PC_Current[31:0])
);

Ext_32(
.imm_16(IR[15:0]),
.imm_32(Imm_32[31:0])
);

//+++++++++++++++++++++++++++++++++++++++++ MUX +++++++++++++++++++++++++++//

mux4to1_5 MUX_Wt_addr(
.sel(RegDst[1:0]),
.a(IR[20:16]),
.b(IR[15:11]),
.c(ra[4:0]),
.d(5'b00000),
.o(mux_Wt_addr[4:0])
);

mux4to1_32 MUX_Wt_data(
.sel(MemtoReg[1:0]),
.a(ALUOut[31:0]),
.b(MDR[31:0]),
.c(lui[31:0]),
.d(PC_Current[31:0]),
.o(mux_Wt_data[31:0])
);

mux2to1_32 MUX_SrcA_out(
.sel(ALUSrcA),
.a(rdata_A[31:0]),
.b(PC_Current[31:0]),
.o(SrcA_out[31:0])
);

mux4to1_32 MUX_SrcB_out(
.sel(ALUSrcB[1:0]),
.a(rdata_B[31:0]),
.b(32'h0000_0004),
.c(Imm_32[31:0]),
.d({Imm_32[29:0],2'b00}),
.o(SrcB_out[31:0])
);

mux2to1_32 MUX_M_addr(
.sel(IorD),
.a(PC_Current[31:0]),
.b(ALUOut[31:0]),
.o(M_addr[31:0])
);

mux4to1_32 MUX_PC_sel(
.sel(PCSource[1:0]),
.a(res[31:0]),
.b(ALUOut[31:0]),
.c({PC_Current[31:28],IR[25:0],2'b00}),
.d(ALUOut[31:0]),
.o(o_PC[31:0])
);

//+++++++++++++++++++++++++++++++++++++++++ MUX +++++++++++++++++++++++++++//

endmodule
