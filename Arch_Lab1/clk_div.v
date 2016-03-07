`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:06:34 05/24/2015 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div(
input wire clk,
input wire rst,
input wire SW2,
output reg[31:0] clkdiv,
output wire Clk_CPU,
output reg clk25
    );
wire clk_out;
reg[1:0] cnt;
initial cnt = 0;

assign clk_out = (SW2)? clkdiv[23] : clkdiv[3];
BUFG cc(Clk_CPU,clk_out);

always@(posedge clk or posedge rst) begin
	if(rst) begin
		clkdiv <= 0;
		cnt[1:0] =0;
	end
	else begin
		clkdiv <= clkdiv + 1'b1;
		if(cnt[1:0]==3) begin
			clk25 = 1;
			cnt = 0;
		end
		else begin
			clk25=0;
			cnt = cnt + 1;
		end
	end
end

endmodule
