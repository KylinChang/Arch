`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:03:38 04/29/2014 
// Design Name: 
// Module Name:    Anti_jitter 
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
module Anti_jitter(input wire clk, 
						 input wire [3:0] button,
						 input wire [7:0] SW, 
						 output reg [3:0]button_out,
						 output reg [3:0]button_pulse,
						 output reg [7:0] SW_OK,
						 output reg rst
						);
//	 reg[31:0] counter;
//	 reg[3:0] btn_temp;
//	 reg[7:0] sw_temp;
//	 reg pluse;
//	 
//	 always@(posedge clk) begin
//		
//		btn_temp<=button;
//		sw_temp<=SW;
//		if(btn_temp != button || sw_temp!=SW) begin
//			counter<=32'h00000000;
//			pluse<=0;
//		end
//		
//		else if(counter<100000)
//			counter<=counter+1;
//		
//		else begin
//			button_out<=button;
//			pluse<=1;
//			if(!pluse) 
//				button_pulse<=button;
//			else button_pulse<=0;
//			SW_OK<=SW;
//		end
//		
//		if(button_out[0]==1) rst <= 1'b1;
//		
//	 end
endmodule
