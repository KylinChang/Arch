`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:00:01 04/07/2016 
// Design Name: 
// Module Name:    sra32 
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
module sra32(
input wire[31:0] A,
input wire[31:0] B,
output reg[31:0] o,
output reg[31:0] o1
    );

always@*begin
	o[31:0] = $signed(A[31:0]) >>> B[10:6];
	o1[31:0] = $signed(A[31:0]) >>> B[31:0];
end

endmodule
