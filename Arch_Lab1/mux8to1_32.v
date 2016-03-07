`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:22:32 05/30/2015 
// Design Name: 
// Module Name:    mux8to1_32 
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
module mux8to1_32(
input wire[2:0] sel,
input wire[31:0] x0,
input wire[31:0] x1,
input wire[31:0] x2,
input wire[31:0] x3,
input wire[31:0] x4,
input wire[31:0] x5,
input wire[31:0] x6,
input wire[31:0] x7,

output reg[31:0] o
    );

always@* begin
	case(sel[2:0])
	0: o <= x0;
	1: o <= x1;
	2: o <= x2;
	3: o <= x3;
	4: o <= x4;
	5: o <= x5;
	6: o <= x6;
	default: o <= x7;
	endcase
end

endmodule
