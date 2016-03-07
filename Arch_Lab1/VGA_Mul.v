`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:21:12:53 03/03/2016 
// Design Name: 
// Module Name:VGA_Mul 
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
module Font_Mul(
input wire[7:0] col,
input wire[7:0] row,
input[31:0] register1,
input[31:0] register2,
input[31:0] register3,
input[31:0] register4,
input[31:0] register5,
input[31:0] register6,
input[31:0] register7,
input[31:0] register8,
input[31:0] register9,
input[31:0] register10,
input[31:0] register11,
input[31:0] register12,
input[31:0] register13,
input[31:0] register14,
input[31:0] register15,
input[31:0] register16,
input[31:0] register17,
input[31:0] register18,
input[31:0] register19,
input[31:0] register20,
input[31:0] register21,
input[31:0] register22,
input[31:0] register23,
input[31:0] register24,
input[31:0] register25,
input[31:0] register26,
input[31:0] register27,
input[31:0] register28,
input[31:0] register29,
input[31:0] register30,
input[31:0] register31,

output reg[7:0] vga_data,
output reg GPIO_VGA_WE
);

reg temp_we;
reg[7:0] count;
reg[3:0] num;
reg[31:0] register;

initial begin
temp_we = 0;
end

always@* begin
	if(col[7:0]>=10 && col[7:0]<18 && row[7:0]>=3 && row[7:0]<=33) begin
	if(temp_we == 0) begin
		temp_we = 1;
		GPIO_VGA_WE = 1;

		count[7:0] = row[7:0]-3;
		case(count[7:0])
		1:register[31:0] = register1[31:0];
		2:register[31:0] = register2[31:0];
		3:register[31:0] = register3[31:0];
		4:register[31:0] = register4[31:0];
		5:register[31:0] = register5[31:0];
		6:register[31:0] = register6[31:0];
		7:register[31:0] = register7[31:0];
		8:register[31:0] = register8[31:0];
		9:register[31:0] = register9[31:0];
		10:register[31:0] = register10[31:0];
		11:register[31:0] = register11[31:0];
		12:register[31:0] = register12[31:0];
		13:register[31:0] = register13[31:0];
		14:register[31:0] = register14[31:0];
		15:register[31:0] = register15[31:0];
		16:register[31:0] = register16[31:0];
		17:register[31:0] = register17[31:0];
		18:register[31:0] = register18[31:0];
		19:register[31:0] = register19[31:0];
		20:register[31:0] = register20[31:0];
		21:register[31:0] = register21[31:0];
		22:register[31:0] = register22[31:0];
		23:register[31:0] = register23[31:0];
		24:register[31:0] = register24[31:0];
		25:register[31:0] = register25[31:0];
		26:register[31:0] = register26[31:0];
		27:register[31:0] = register27[31:0];
		28:register[31:0] = register28[31:0];
		29:register[31:0] = register29[31:0];
		30:register[31:0] = register30[31:0];
		31:register[31:0] = register31[31:0];
		default:register[31:0] = 32'b0;
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
	else begin
		GPIO_VGA_WE = 0;
		temp_we = 0;
	end
end

endmodule
