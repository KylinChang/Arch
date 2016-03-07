`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:34:44 05/30/2015 
// Design Name: 
// Module Name:    Regs 
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
module Regs(
	input clk,
	input rst,
	input L_S,
	input[4:0] R_addr_A,
	input[4:0] R_addr_B,
	input[4:0] Wt_addr,
	input[31:0] Wt_data,
	output[31:0] rdata_A,
	output[31:0] rdata_B,
	
	output[31:0] register0,
	output[31:0] register1,
	output[31:0] register2,
	output[31:0] register3,
	output[31:0] register4,
	output[31:0] register5,
	output[31:0] register6,
	output[31:0] register7,
	output[31:0] register8,
	output[31:0] register9,
	output[31:0] register10,
	output[31:0] register11,
	output[31:0] register12,
	output[31:0] register13,
	output[31:0] register14,
	output[31:0] register15,
	output[31:0] register16,
	output[31:0] register17,
	output[31:0] register18,
	output[31:0] register19,
	output[31:0] register20,
	output[31:0] register21,
	output[31:0] register22,
	output[31:0] register23,
	output[31:0] register24,
	output[31:0] register25,
	output[31:0] register26,
	output[31:0] register27,
	output[31:0] register28,
	output[31:0] register29,
	output[31:0] register30,
	output[31:0] register31
    );
	 reg [31:0] register [1:31];
	integer i;
	
	assign rdata_A = (R_addr_A == 0)? 0: register[R_addr_A];
	assign rdata_B = (R_addr_B == 0)? 0: register[R_addr_B];
	
	assign register0 = 32'b0;
	assign register1 = register[1];
	assign register2 = register[2];
	assign register3 = register[3];
	assign register4 = register[4];
	assign register5 = register[5];
	assign register6 = register[6];
	assign register7 = register[7];
	assign register8 = register[8];
	assign register9 = register[9];
	assign register10 = register[10];
	assign register11 = register[11];
	assign register12 = register[12];
	assign register13 = register[13];
	assign register14 = register[14];
	assign register15 = register[15];
	assign register16 = register[16];
	assign register17 = register[17];
	assign register18 = register[18];
	assign register19 = register[19];
	assign register20 = register[20];
	assign register21 = register[21];
	assign register22 = register[22];
	assign register23 = register[23];
	assign register24 = register[24];
	assign register25 = register[25];
	assign register26 = register[26];
	assign register27 = register[27];
	assign register28 = register[28];
	assign register29 = register[29];
	assign register30 = register[30];
	assign register31 = register[31];
	
	always @ (posedge clk or posedge rst) begin
		if(rst == 1)
			for(i = 1; i < 32; i = i+1)
				register[i] <= 0;
		else if((Wt_addr != 0) && (L_S == 1))
			register[Wt_addr] <= Wt_data;
	end

endmodule
