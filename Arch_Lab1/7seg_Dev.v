`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// CompANy: 
// Engineer: 
// 
// Create Date:    23:15:49 09/30/2011 
// Design Name: 
// Module Name:    x7seg 
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
module seven_seg_dev(input[31:0] disp_num,
					input [1:0] SW,
					input flash_clk,
					input [1:0] Scanning,
					input [3:0] pointing,
					input [3:0] blinking,
					output[3:0] AN,
					output [7:0] SEGMENT
					);
					
endmodule

