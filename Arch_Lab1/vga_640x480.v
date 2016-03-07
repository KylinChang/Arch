`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:27:16 06/20/2015 
// Design Name: 
// Module Name:    vga_640x480 
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
module vga_640x480(
input wire clk,
input wire clr,
output reg hsync,
output reg vsync,
output reg[9:0] hc,
output reg[9:0] vc,
output reg vidon
    );

reg vsenable;


parameter hpixels = 	10'b1100100000;
parameter vlines = 	10'b1000001001;
parameter hbp = 		10'b0010010000;
parameter hfp = 		10'b1100010000;
parameter vbp = 		10'b0000011111;
parameter vfp = 		10'b0111111111;

always@(posedge clk) begin
	     if(hc == hpixels - 1) begin
		      hc <= 0;
				vsenable <= 1;
		  end
		  else begin
		      hc <= hc + 1;
				vsenable <= 0;
		  end
end

always@* begin
    if(hc < 96) hsync <= 0;
	 else hsync <= 1;
end

always@(posedge clk) begin

	 if(vsenable == 1) begin
	     if(vc == vlines - 1) vc <= 0;
		  else vc <= vc + 1;
	 end
end

always@* begin
    if(vc < 2) vsync <= 0;
	 else vsync <= 1;
end

always@* begin
    if((hc<hfp) && (hc>hbp) && (vc<vfp) && (vc>vbp)) vidon <= 1;
	 else vidon <= 0;
end

endmodule
