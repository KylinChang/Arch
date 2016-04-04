`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:36:05 03/31/2016 
// Design Name: 
// Module Name:    EXE_REG 
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
module EXE_REG(
input wire clk,
input wire rst,
input wire WREG,
input wire M2REG,
input wire WMEM,
input wire[2:0] ALUC,
input wire ALUIMM,
input wire SHIFT,

input wire[31:0] ID_SrcA,
input wire[31:0] ID_SrcB,
input wire[31:0] SE,
input wire[4:0] REG_ADDR,

output reg EWREG,
output reg EM2REG,
output reg EWMEM,
output reg[2:0] EALUC,
output reg EALUIMM,
output reg ESHIFT,

output reg[31:0] EXE_SrcA,
output reg[31:0] EXE_SrcB,
output reg[31:0] SA,
output reg[4:0] EXE_REG_ADDR
    );

always@(posedge clk or posedge rst) begin
	if(rst==1) begin
	EWREG <= 0;
	EM2REG <= 0;
	EWMEM <= 0;
	EALUC[2:0] <= 3'b000;
	EALUIMM <= 0;
	ESHIFT <= 0;
	
	EXE_SrcA[31:0] <= 32'h0000_0000;
	EXE_SrcB[31:0] <= 32'h0000_0000;
	SA[31:0] <= 32'h0000_0000;
	EXE_REG_ADDR[4:0] <= 5'h0;
	end
	else begin
	EWREG <= WREG;
	EM2REG <= M2REG;
	EWMEM <= WMEM;
	EALUC[2:0] <= ALUC[2:0];
	EALUIMM <= ALUIMM;
	ESHIFT <= SHIFT;
	
	EXE_SrcA[31:0] <= ID_SrcA[31:0];
	EXE_SrcB[31:0] <= ID_SrcB[31:0];
	SA[31:0] <= SE[31:0];
	EXE_REG_ADDR[4:0] <= REG_ADDR[4:0];
	end
	
end

endmodule
