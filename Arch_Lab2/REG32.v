`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:54 03/30/2016 
// Design Name: 
// Module Name:    REG32 
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
module REG32(
input wire clk,
input wire rst,
input wire CE,
input wire[31:0] D,

output reg[31:0] Q
    );

always@(posedge clk or posedge rst) begin
	if(rst==1) Q[31:0] <= 32'h0000_0000;
	else begin
		if(CE==1) Q[31:0] <= D[31:0];
		else Q[31:0] <= Q[31:0];
	end
end

endmodule
