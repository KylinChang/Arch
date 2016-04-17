`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:47:29 04/07/2016 
// Design Name: 
// Module Name:    mux16to1_32 
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
module mux16to1_32(
input wire[3:0] sel,
input wire[31:0] x0,
input wire[31:0] x1,
input wire[31:0] x2,
input wire[31:0] x3,
input wire[31:0] x4,
input wire[31:0] x5,
input wire[31:0] x6,
input wire[31:0] x7,
input wire[31:0] x8,
input wire[31:0] x9,
input wire[31:0] x10,
input wire[31:0] x11,
input wire[31:0] x12,
input wire[31:0] x13,
input wire[31:0] x14,
input wire[31:0] x15,

output reg[31:0] o
    );

always@* begin
	case(sel[3:0])
	0: o[31:0] <= x0[31:0];
	1: o[31:0] <= x1[31:0];
	2: o[31:0] <= x2[31:0];
	3: o[31:0] <= x3[31:0];
	4: o[31:0] <= x4[31:0];
	5: o[31:0] <= x5[31:0];
	6: o[31:0] <= x6[31:0];
	7: o[31:0] <= x7[31:0];
	8: o[31:0] <= x8[31:0];
	9: o[31:0] <= x9[31:0];
	10: o[31:0] <= x10[31:0];
	11: o[31:0] <= x11[31:0];
	12: o[31:0] <= x12[31:0];
	13: o[31:0] <= x13[31:0];
	14: o[31:0] <= x14[31:0];
	15: o[31:0] <= x15[31:0];
	endcase
end

endmodule
