`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:17:04 03/30/2016 
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

	output[31:0] reg1,
	output[31:0] reg2,
	output[31:0] reg3,
	output[31:0] reg4,
	output[31:0] reg5,
	output[31:0] reg6,
	output[31:0] reg7,
	output[31:0] reg8,
	output[31:0] reg9,
	output[31:0] reg10,
	output[31:0] reg11,
	output[31:0] reg12,
	output[31:0] reg13,
	output[31:0] reg14,
	output[31:0] reg15,
	output[31:0] reg16,
	output[31:0] reg17,
	output[31:0] reg18,
	output[31:0] reg19,
	output[31:0] reg20,
	output[31:0] reg21,
	output[31:0] reg22,
	output[31:0] reg23,
	output[31:0] reg24,
	output[31:0] reg25,
	output[31:0] reg26,
	output[31:0] reg27,
	output[31:0] reg28,
	output[31:0] reg29,
	output[31:0] reg30,
	output[31:0] reg31
    );
	integer i;
	reg[31:0] register[1:31];
	
	assign rdata_A = (R_addr_A == 0)? 0: register[R_addr_A];
	assign rdata_B = (R_addr_B == 0)? 0: register[R_addr_B];
	
	always @ (negedge clk or posedge rst) begin
		if(rst == 1)
			for(i = 1; i < 32; i = i+1)
				register[i] <= 0;
		else if((Wt_addr != 0) && (L_S == 1))
			register[Wt_addr] <= Wt_data;
	end
	
	assign reg1 = register[1];
	assign reg2 = register[2];
	assign reg3 = register[3];
	assign reg4 = register[4];
	assign reg5 = register[5];
	assign reg6 = register[6];
	assign reg7 = register[7];
	assign reg8 = register[8];
	assign reg9 = register[9];
	assign reg10 = register[10];
	assign reg11 = register[11];
	assign reg12 = register[12];
	assign reg13 = register[13];
	assign reg14 = register[14];
	assign reg15 = register[15];
	assign reg16 = register[16];
	assign reg17 = register[17];
	assign reg18 = register[18];
	assign reg19 = register[19];
	assign reg20 = register[20];
	assign reg21 = register[21];
	assign reg22 = register[22];
	assign reg23 = register[23];
	assign reg24 = register[24];
	assign reg25 = register[25];
	assign reg26 = register[26];
	assign reg27 = register[27];
	assign reg28 = register[28];
	assign reg29 = register[29];
	assign reg30 = register[30];
	assign reg31 = register[31];

endmodule
