`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:36:39 03/30/2016 
// Design Name: 
// Module Name:    Ctrl 
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
module Ctrl(
input wire clk,
input wire reset,
input wire[5:0] op,
input wire[5:0] func,
input wire[4:0] rs,
input wire[4:0] rt,
input wire RS_EQU_RT,

output reg JAL,
output reg WREG,
output reg M2REG,
output reg WMEM,
output reg[2:0] ALUC,
output reg ALUIMM,
output reg SHIFT,
output reg REGRT,
output reg[1:0] FWDB,
output reg[1:0] FWDA,
output reg JR,
output reg JUMP,

output reg BRANCH,
output reg WPCIR
);

reg[35:0] HEAP;

parameter AND=3'B000,OR=3'B001,ADD=3'B010;
parameter XOR=3'B011,NOR=3'B100,SRL=3'B101;
parameter SUB=3'B110,SLT=3'B111;

parameter VEX_R=10'b10000_10000;
parameter VEX_J=10'b00000_00011;

`define cpu_ctr_signals{WREG, M2REG, WMEM, ALUIMM, SHIFT,      REGRT, JAL, JR, JUMP, BRANCH}
//WPCIR, FWDA, FWDB, ALUC needs to be configured

always@(posedge clk or posedge reset) begin
	if(reset == 1) begin
		`cpu_ctr_signals <= 10'h0;
		WPCIR <= 0;
		FWDA[1:0] <= 2'b0;
		FWDB[1:0] <= 2'b0;
		ALUC[2:0] <= 3'b0;
	end
	else begin
		HEAP[35:0] <= {HEAP[23:0], op[5:0], func[5:0]};
		case(op[5:0])
		6'b00_0000: begin
			case(func[5:0])
			6'b100000: begin //ADD
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[2:0] <= ADD[2:0];
			end
			6'b100010: begin //SUB
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[2:0] <= SUB[2:0];
			end
			6'b100100: begin //AND
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[2:0] <= AND[2:0];
			end
			6'b100101: begin //OR
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[2:0] <= OR[2:0];
			end
			6'b100110: begin //XOR
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[2:0] <= XOR[2:0];
			end
			6'b100111: begin //NOR
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[2:0] <= NOR[2:0];
			end
			endcase	
		end
		6'b00_0010:begin
			`cpu_ctr_signals <= VEX_J[9:0];
			WPCIR<=1;
		end
		endcase
		
		if(WPCIR==1 && HEAP[11:6]!=6'b00_0010) begin
			WPCIR <= 0;
		end
		
	end
end

endmodule
