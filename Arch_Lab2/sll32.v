`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:58:24 04/07/2016 
// Design Name: 
// Module Name:    sll32 
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
module sll32(
input wire[31:0] A,
input wire[31:0] B,
output wire[31:0] o,
output wire[31:0] o1
    );

assign o = A[31:0] << B[10:6];
assign o1 = A[31:0] << B[31:0];

endmodule
