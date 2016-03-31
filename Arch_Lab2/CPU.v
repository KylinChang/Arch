`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:52 03/06/2016 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
input clk,							//CLK_CPU
input reset,
input MIO_ready,
								
output[31:0] PC_out,		   	//TEST
output[31:0] inst_out,			//TEST
output mem_w,
output[31:0] Addr_out,
output[31:0] Data_out, 
input [31:0] Data_in,
output CPU_MIO,
input INT
);


Ctrl(

);

DataPath(

);

endmodule
