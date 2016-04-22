`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:50:04 03/30/2016 
// Design Name: 
// Module Name:    srl32 
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
module srl32(
	input [31:0] A,
	input [31:0] B,
	output [31:0] o,
	output [31:0] o1
	);

	assign o = A >> B[10:6];
	assign o1 = A >> B[31:0];

endmodule
