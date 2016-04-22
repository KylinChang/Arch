`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:03:29 04/19/2016 
// Design Name: 
// Module Name:    Reg_Font 
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
module Reg_Font(
input wire[31:0] PC,
input wire[7:0] col,
input wire[7:0] row,
output reg[7:0] vga_data,
output reg GPIO_VGA_WE,
input[31:0] reg1,
input[31:0] reg2,
input[31:0] reg3,
input[31:0] reg4,
input[31:0] reg5,
input[31:0] reg6,
input[31:0] reg7,
input[31:0] reg8,
input[31:0] reg9,
input[31:0] reg10,
input[31:0] reg11,
input[31:0] reg12,
input[31:0] reg13,
input[31:0] reg14,
input[31:0] reg15,
input[31:0] reg16,
input[31:0] reg17,
input[31:0] reg18,
input[31:0] reg19,
input[31:0] reg20,
input[31:0] reg21,
input[31:0] reg22,
input[31:0] reg23,
input[31:0] reg24,
input[31:0] reg25,
input[31:0] reg26,
input[31:0] reg27,
input[31:0] reg28,
input[31:0] reg29,
input[31:0] reg30,
input[31:0] reg31
);

reg[7:0] count;
reg[3:0] num;
reg[31:0] register;
reg[7:0] pos;

always@* begin
	if((col[7:0]>=10 && col[7:0]<18 && row[7:0]>=2 && row[7:0]<=33) || col[7:0]==28) begin
		if(GPIO_VGA_WE == 0) begin
		GPIO_VGA_WE = 1;
		pos[7:0] = PC[9:2] + 2;
		count[7:0] = row[7:0]-2;
		
		if(col[7:0] == 28) begin
			if(pos[7:0] == row[7:0])begin
			vga_data[7:0] = 8'h7f;
			end
			else begin
			vga_data[7:0] = 8'h20;
			end
		end
		else begin
		
		case(count[7:0])
		0:register[31:0] = 32'h0;
		1:register[31:0] = reg1[31:0];
		2:register[31:0] = reg2[31:0];
		3:register[31:0] = reg3[31:0];
		4:register[31:0] = reg4[31:0];
		5:register[31:0] = reg5[31:0];
		6:register[31:0] = reg6[31:0];
		7:register[31:0] = reg7[31:0];
		8:register[31:0] = reg8[31:0];
		9:register[31:0] = reg9[31:0];
		10:register[31:0] = reg10[31:0];
		11:register[31:0] = reg11[31:0];
		12:register[31:0] = reg12[31:0];
		13:register[31:0] = reg13[31:0];
		14:register[31:0] = reg14[31:0];
		15:register[31:0] = reg15[31:0];
		16:register[31:0] = reg16[31:0];
		17:register[31:0] = reg17[31:0];
		18:register[31:0] = reg18[31:0];
		19:register[31:0] = reg19[31:0];
		20:register[31:0] = reg20[31:0];
		21:register[31:0] = reg21[31:0];
		22:register[31:0] = reg22[31:0];
		23:register[31:0] = reg23[31:0];
		24:register[31:0] = reg24[31:0];
		25:register[31:0] = reg25[31:0];
		26:register[31:0] = reg26[31:0];
		27:register[31:0] = reg27[31:0];
		28:register[31:0] = reg28[31:0];
		29:register[31:0] = reg29[31:0];
		30:register[31:0] = reg30[31:0];
		31:register[31:0] = reg31[31:0];
		default:register[31:0] = 32'h20202020;
		endcase
		
		case(col[7:0])
		10: num[3:0] = register[31:28];
		11: num[3:0] = register[27:24];
		12: num[3:0] = register[23:20];
		13: num[3:0] = register[19:16];
		14: num[3:0] = register[15:12];
		15: num[3:0] = register[11:8];
		16: num[3:0] = register[7:4];
		17: num[3:0] = register[3:0];
		endcase
		
		case(num[3:0])
		0: vga_data[7:0] = 8'h30;
		1: vga_data[7:0] = 8'h31;
		2: vga_data[7:0] = 8'h32;
		3: vga_data[7:0] = 8'h33;
		4: vga_data[7:0] = 8'h34;
		5: vga_data[7:0] = 8'h35;
		6: vga_data[7:0] = 8'h36;
		7: vga_data[7:0] = 8'h37;
		8: vga_data[7:0] = 8'h38;
		9: vga_data[7:0] = 8'h39;
		10: vga_data[7:0] = 8'h41;
		11: vga_data[7:0] = 8'h42;
		12: vga_data[7:0] = 8'h43;
		13: vga_data[7:0] = 8'h44;
		14: vga_data[7:0] = 8'h45;
		15: vga_data[7:0] = 8'h46;
		endcase
		end
		end
	end
	else begin
		GPIO_VGA_WE = 0;
	end
end

endmodule
