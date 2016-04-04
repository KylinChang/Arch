`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:03:31 04/04/2016 
// Design Name: 
// Module Name:    MEM_REG 
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
module MEM_REG(
input wire clk,
input wire rst,
input wire EWREG,
input wire EM2REG,
input wire EWMEM,

input wire[31:0] res,
input wire[31:0] EXE_SrcB,
input wire[31:0] EXE_REG_ADDR,

output reg MWREG,
output reg MM2REG,
output reg MWMEM,
output reg[31:0] DATA_MEM_A,
output reg[31:0] DATA_MEM_WD,
output reg[31:0] MEM_REG_ADDR
    );

always@(posedge clk or posedge rst)begin
	if(rst==1) begin
		MWREG <= 0;
		MM2REG <= 0;
		MWMEM <= 0;
		DATA_MEM_A[31:0] <= 32'h0;
		DATA_MEM_WD[31:0] <= 32'h0;
		MEM_REG_ADDR[31:0] <= 32'h0;
	end
	else begin
		MWREG <= EWREG;
		MM2REG <= EM2REG;
		MWMEM <= EWMEM;
		
		DATA_MEM_A[31:0] <= res[31:0];
		DATA_MEM_WD[31:0] <= EXE_SrcB[31:0];
		MEM_REG_ADDR[31:0] <= EXE_REG_ADDR[31:0];
	end
end

endmodule
