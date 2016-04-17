`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:50 04/17/2016 
// Design Name: 
// Module Name:    sltu32 
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
module sltu32(
input wire[31:0] A,
input wire[31:0] B,
output wire o
    );

assign o = A<B?1:0;

endmodule
