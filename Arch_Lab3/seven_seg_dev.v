`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:59 03/06/2016 
// Design Name: 
// Module Name:    sevem_seg_dev 
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
module seven_seg_dev(
input rst,
input clk,
input wire[1:0] scanning,
input GPIOe0000000_we,				//EN

input[1:0] SW,							//SW_OK[1:0]
input[2:0] sel,						//SW_OK[7:5]
input[31:0] disp_cpudata,			//disp_cpudata
input[31:0] Test_data1,
input[31:0] Test_data2,
input[31:0] Test_data3,
input[31:0] Test_data4,
input[31:0] Test_data5,
input[31:0] Test_data6,
input[31:0] Test_data7,

output reg[3:0] AN,
output reg[7:0] SEGMENT
    );

parameter default_num = 32'hAA5555AA;

reg[31:0] Disp_num;
reg[3:0]  num;
reg[7:0]  seg_out;

always@(negedge clk or posedge rst) begin
	if(rst) begin
		Disp_num[31:0] = default_num;
	end
	else begin
		case(sel[2:0])
		0: begin
//			if(GPIOe0000000_we) Disp_num[31:0] = disp_cpudata[31:0];
//			else Disp_num[31:0] = Disp_num[31:0];
Disp_num[31:0] = disp_cpudata[31:0];
		end
		1: Disp_num = Test_data1; //pc[31:2]
		2: Disp_num = Test_data2; //counter[31:0] 
		3: Disp_num = Test_data3; //Inst
		4: Disp_num = Test_data4; //addr_bus
		5: Disp_num = Test_data5; //Cpu_data2bus
		6: Disp_num = Test_data6; //Cpu_data4bus
		7: Disp_num = Test_data7; //pc
		endcase
		
		case(scanning[1:0])
		0: AN[3:0] = 4'b1110;
		1: AN[3:0] = 4'b1101;
		2: AN[3:0] = 4'b1011;
		3: AN[3:0] = 4'b0111;
		endcase
			
		if(SW[0]==1'b0) begin	//Graph mode of the seven segment
			case(scanning[1:0])
			0: SEGMENT[7:0] = Disp_num[7:0];
			1: SEGMENT[7:0] = Disp_num[15:8];
			2: SEGMENT[7:0] = Disp_num[23:16];
			3: SEGMENT[7:0] = Disp_num[31:24];
			endcase
		end
		else begin		//text mode of the seven segment
			case({SW[1],scanning[1:0]})
			0: num[3:0] = Disp_num[3:0];
			1: num[3:0] = Disp_num[7:4];
			2: num[3:0] = Disp_num[11:8];
			3: num[3:0] = Disp_num[15:12];
			4: num[3:0] = Disp_num[19:16];
			5: num[3:0] = Disp_num[23:20];
			6: num[3:0] = Disp_num[27:24];
			default: num[3:0] = Disp_num[31:28];
			endcase
			
			case(num[3:0])
			0: SEGMENT[7:0] = 8'b11000000;
			1: SEGMENT[7:0] = 8'b11111001;
			2: SEGMENT[7:0] = 8'b10100100;
			3: SEGMENT[7:0] = 8'b10110000;
			4: SEGMENT[7:0] = 8'b10011001;
			5: SEGMENT[7:0] = 8'b10010010;
			6: SEGMENT[7:0] = 8'b10000010;
			7: SEGMENT[7:0] = 8'b11111000;
			8: SEGMENT[7:0] = 8'b10000000;
			9: SEGMENT[7:0] = 8'b10010000;
			10: SEGMENT[7:0] = 8'b10001000;
			11: SEGMENT[7:0] = 8'b10000011;
			12: SEGMENT[7:0] = 8'b11000110;
			13: SEGMENT[7:0] = 8'b10100001;
			14: SEGMENT[7:0] = 8'b10000110;
			default: SEGMENT[7:0] = 8'b10001110;
			endcase
		end
		
	end
end

endmodule
