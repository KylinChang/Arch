`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:44:05 03/31/2016 
// Design Name: 
// Module Name:    EQU 
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
module EQU(
input wire[31:0] a,
input wire[31:0] b,
output reg equ
    );

always@* begin
	if(a[31:0] == b[31:0]) equ <= 1;
	else equ <= 0;
end

endmodule
