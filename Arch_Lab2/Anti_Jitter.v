`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:51:57 03/06/2016 
// Design Name: 
// Module Name:    Anti_Jitter 
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
module Anti_Jitter(
input wire clk_100mhz, 
input wire [4:0] button,
input wire [7:0] SW, 
output reg [4:0]button_out,
output reg [4:0]button_pulse,
output reg [7:0] SW_OK,
output reg rst
    );

reg[31:0] counter;
reg[4:0] btn_temp;
reg[7:0] sw_temp;
reg pulse;

always@(posedge clk_100mhz) begin
	btn_temp[4:0] <= button[4:0];
	sw_temp[7:0] <= SW[7:0];
	if(button!=btn_temp || SW!=sw_temp) begin
		counter[31:0] <= 32'b0;
		pulse <= 0;
	end
	else if(counter<100000) begin
		counter[31:0] <= counter[31:0] + 1;
	end
	else begin
		button_out <= button;
		pulse <= 1;
		if(!pulse)
			button_pulse[4:0] <= button[4:0];
		else 
			button_pulse[4:0] <= 4'b0;
		SW_OK[7:0] <= SW[7:0];
	end
	
	if(button_out[2]==1) rst <= 1'b1;
	else rst <= 1'b0;
	
end

endmodule
