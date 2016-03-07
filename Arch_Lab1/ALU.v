`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:36:33 05/30/2015 
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
input wire[2:0] ALU_operation,

output wire zero,
output wire[31:0] res,
output wire overflow
    );

wire[31:0] o_and32,o_or32,o_xor32,o_nor32,o_srl32,o_SrcB,B_Ctrl;
wire[32:0] S;

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
.A(A[31:0]),
.B(B[31:0]),
.res(o_srl32[31:0])
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

//++++++++++++++++++++++++++++++ mux8to1_32 ++++++++++++++++++++++++++++++//
mux8to1_32 MUX(
.sel(ALU_operation[2:0]),
.x0(o_and32[31:0]),
.x1(o_or32[31:0]),
.x2(S[31:0]),
.x3(o_xor32[31:0]),
.x4(o_nor32[31:0]),
.x5(o_srl32[31:0]),
.x6(S[31:0]),
.x7({31'b0000_0000_0000_0000_0000_0000_0000_000,S[32]}),
.o(res[31:0])
);
//++++++++++++++++++++++++++++++ mux8to1_32 ++++++++++++++++++++++++++++++//

endmodule
