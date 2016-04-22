`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:38 04/04/2016 
// Design Name: 
// Module Name:    mux2to1_5 
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
module mux2to1_5(
input wire sel,
input wire[4:0] a,
input wire[4:0] b,

output reg[4:0] o
    );

always@* begin
	if(sel==1) o[4:0] <= a[4:0];
	else o[4:0] <= b[4:0];
end

endmodule
