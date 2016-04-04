`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:16:51 03/30/2016 
// Design Name: 
// Module Name:    mux2to1_32 
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
module mux2to1_32(
input wire sel,
input wire[31:0] a,
input wire[31:0] b,
output reg[31:0] o
    );

always@* begin
	if(sel == 1'b1)
		o[31:0] <= a[31:0];
	else
		o[31:0] <= b[31:0];
end

endmodule
