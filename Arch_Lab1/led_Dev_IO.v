`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:11 07/01/2012 
// Design Name: 
// Module Name:    Device_led 
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
module led_Dev_IO(input clk,
						input rst,
						input GPIOf0000000_we,
						input [31:0] Peripheral_in,
						output reg[1:0] counter_set,
						output wire[7:0] led_out,
						output reg[21:0] GPIOf0						 
						);
	reg[7:0] LED;
	assign led_out = LED;
	always@(negedge clk or posedge rst)begin
		if(rst) begin
			LED <= 8'h2A;
			counter_set <= 2'b00;
		end
		else begin
			if(GPIOf0000000_we)
				{GPIOf0[21:0],counter_set} <= Peripheral_in;
			else begin
				LED <= LED;
				counter_set <= counter_set;
			end
		end
	end
endmodule
