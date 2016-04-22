`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:48:08 03/30/2016 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
input wire[31:0] A,
input wire[31:0] B,
input wire[3:0] ALU_operation,

output wire zero,
output wire[31:0] res,
output wire overflow
    );

wire[31:0] o_and32,o_or32,o_xor32,o_nor32,o_srl32,o_SrcB,B_Ctrl, o_sll32, o_sra32, o_lui32;
wire[31:0] o_sllv32, o_srlv32, o_srav32;
wire[32:0] S;
wire SLTU;

assign overflow=S[32];

and32(
.A(A[31:0]),
.B(B[31:0]),
.res(o_and32[31:0])
);

or32(
.A(A[31:0]),
.B(B[31:0]),
.res(o_or32[31:0])
);

ADC32(
.C0(ALU_operation[2]),
.A(A[31:0]),
.B(o_SrcB[31:0]),
.S(S[32:0])
);

xor32 X(
.A(A[31:0]),
.B(B[31:0]),
.res(o_xor32[31:0])
);

nor32(
.A(A[31:0]),
.B(B[31:0]),
.res(o_nor32[31:0])
);

srl32(
.A(B[31:0]),
.B(A[31:0]),
.o(o_srl32[31:0]),
.o1(o_srlv32[31:0])
);

Ext1to32(
.S(ALU_operation[2]),
.So(B_Ctrl[31:0])
);

xor32 SrcB(
.A(B_Ctrl[31:0]),
.B(B[31:0]),
.res(o_SrcB[31:0])
);

or_bit_32(
.A(res[31:0]),
.o(zero)
);

sll32(
.A(B[31:0]),
.B(A[31:0]),
.o(o_sll32[31:0]),
.o1(o_sllv32[31:0])
);

sra32(
.A(B[31:0]),
.B(A[31:0]),
.o(o_sra32[31:0]),
.o1(o_srav32[31:0])
);

sltu32(
.A(A[31:0]),
.B(B[31:0]),
.o(SLTU)
);

lui32(
.imm(B[31:0]),
.o(o_lui32[31:0])
);
//++++++++++++++++++++++++++++++ mux8to1_32 ++++++++++++++++++++++++++++++//
//mux8to1_32 MUX(
//.sel(ALU_operation[2:0]),
//.x0(o_and32[31:0]),
//.x1(o_or32[31:0]),
//.x2(S[31:0]),
//.x3(o_xor32[31:0]),
//.x4(o_nor32[31:0]),
//.x5(o_srl32[31:0]),
//.x6(S[31:0]),
//.x7({31'b0000_0000_0000_0000_0000_0000_0000_000,S[32]}),
//.o(res[31:0])
//);

mux16to1_32 MUX(
.sel(ALU_operation[3:0]),
.x0(o_and32[31:0]),
.x1(o_or32[31:0]),
.x2(S[31:0]),
.x3(o_xor32[31:0]),
.x4(o_nor32[31:0]),
.x5(o_srl32[31:0]),
.x6(S[31:0]),
.x7({31'b0000_0000_0000_0000_0000_0000_0000_000,S[32]}),
.x8(o_sll32[31:0]),
.x9(o_sra32[31:0]),
.x10(o_lui32[31:0]),
.x11(o_sllv32[31:0]),
.x12(o_srlv32[31:0]),
.x13(o_srav32[31:0]),
.x14({31'b0000_0000_0000_0000_0000_0000_0000_000,SLTU}),
.x15(0),
.o(res[31:0])
);
//++++++++++++++++++++++++++++++ mux8to1_32 ++++++++++++++++++++++++++++++//

endmodule

