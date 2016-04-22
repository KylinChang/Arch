`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:48 03/30/2016 
// Design Name: 
// Module Name:    IR_REG 
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
module IR_REG(
input wire clk,
input wire rst,
input wire CE,

input wire[31:0] IF_PC,
input wire[31:0] D,

output reg[31:0] ID_PC,
output reg[31:0] Q
    );

always@(posedge clk or posedge rst) begin
	if(rst==1) begin 
		Q[31:0] <= 32'h0000_0000;
		ID_PC[31:0] <= 32'h0000_0000;
	end
	else begin
		if(CE==0) begin
			Q[31:0] <= D[31:0];
			ID_PC[31:0] <= IF_PC[31:0];
		end
		else begin
			Q[31:0] <= Q[31:0];
			ID_PC[31:0] <= ID_PC[31:0];
		end
	end
end

endmodule
