`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:19:31 03/31/2016 
// Design Name: 
// Module Name:    mux4to1_32 
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
module mux4to1_32(
input wire[1:0] sel,
input wire[31:0] A,
input wire[31:0] B,
input wire[31:0] C,
input wire[31:0] D,
output reg[31:0] O
    );

always@* begin
	case(sel[1:0])
	2'b00: O[31:0] <= A[31:0];
	2'b01: O[31:0] <= B[31:0];
	2'b10: O[31:0] <= C[31:0];
	2'b11: O[31:0] <= D[31:0];
	endcase
end

endmodule
