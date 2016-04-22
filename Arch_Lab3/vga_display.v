`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:23 04/19/2016 
// Design Name: 
// Module Name:    vga_display 
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
module vga_display(
input wire vidon,
input wire[9:0] hc,
input wire[9:0] vc,

input wire font_data,
input wire[7:0] M,

output reg[2:0] red,
output reg[2:0] green,
output reg[1:0] blue,

output wire[10:0] row,
output wire[10:0] col,
output wire[15:0] font_addr
    );

parameter hbp=144;
parameter vbp=31;
parameter width=640;
parameter height=480;

wire[10:0] x,y;
reg R,G,B,enable;

assign x=hc-hbp;
assign y=vc-vbp;
assign col=hc-hbp;
assign row=vc-vbp;

assign font_addr[15:0]={2'b00,row[10:3],6'b00_0000}+{4'b0000,row[10:3],4'b0000}+{8'b0000_0000,col[10:3]};

always@* begin
	if(hc >= hbp && hc < hbp + width && vc >= vbp && vc < vbp + height)
		enable <= 1;
	else 
		enable <= 0;
end

always@* begin
	if(enable == 1 && vidon == 1) begin
		if(font_data == 1) begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end
		else begin
			red = 3'b000;
			green = 3'b000;
			blue = 2'b00;
		end
	end
end

endmodule

