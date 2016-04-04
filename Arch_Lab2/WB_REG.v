`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:58:22 04/04/2016 
// Design Name: 
// Module Name:    WB_REG 
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
module WB_REG(
input wire clk,
input wire rst,

input wire MWREG,
input wire MM2REG,

input wire[31:0] data_in,
input wire[31:0] DATA_MEM_A,
input wire[4:0] MEM_REG_ADDR,

output reg WWREG,
output reg WM2REG,
output reg[31:0] WB_DATA,
output reg[31:0] WB_MEM_A,
output reg[4:0] WB_REG_ADDR
    );

always@(posedge clk or posedge rst)begin
	if(rst == 1) begin
		WWREG <= 0;
		WM2REG <= 0;
		WB_DATA[31:0] <= 32'h0;
		WB_MEM_A[31:0] <= 32'h0;
		WB_REG_ADDR[4:0] <= 5'h0;
	end
	else begin
		WWREG <= MWREG;
		WM2REG <= MM2REG;
		WB_DATA[31:0] <= data_in[31:0];
		WB_MEM_A[31:0] <= DATA_MEM_A[31:0];
		WB_REG_ADDR[4:0] <= MEM_REG_ADDR[4:0];
	end
end

endmodule
