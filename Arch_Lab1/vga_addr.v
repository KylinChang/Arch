`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:02 07/13/2015 
// Design Name: 
// Module Name:    vga_addr 
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
module vga_addr(
input wire[9:0] xc,
input wire[9:0] yc,
input wire GPIOvga_we,
input wire[15:0] vram_waddr,
input wire[15:0] graph_addr,
output reg[9:0] C,
output reg[9:0] R,
output reg[15:0] vram_addr
    );

always@* begin
	if(GPIOvga_we)
		vram_addr[15:0] = vram_waddr[15:0];
	else
		vram_addr[15:0] = graph_addr[15:0];
	C=xc;
	R=yc;
end

endmodule
