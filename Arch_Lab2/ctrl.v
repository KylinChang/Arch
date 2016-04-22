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
input wire[4:0] rd,
input wire RS_EQU_RT,

output reg JAL,
output reg WREG,
output reg M2REG,
output reg WMEM,
output reg[3:0] ALUC,
output reg ALUIMM,
output reg SHIFT,
output reg REGRT,
output reg SEXT,
output reg[1:0] FWDB,
output reg[1:0] FWDA,
output reg JR,
output reg JUMP,

output reg BRANCH,
output reg WPCIR,
output reg WMEMW,
output wire[2:0] ALUOP
);

reg[17:0] OP_HEAP;
reg[14:0] REG_HEAP;
reg[2:0] state;

parameter STATE_EXE=3'B000, STATE_STALL=3'B001, STATE_LW_STALL=3'B010;

parameter AND=4'B0000,OR=4'B0001,ADD=4'B0010;
parameter XOR=4'B0011,NOR=4'B0100,SRL=4'B0101;
parameter SUB=4'B0110,SLT=4'B0111;
parameter SLL=4'B1000, SRA=4'B1001;
parameter LUI=4'B1010, SLLV=4'B1011, SRLV=4'B1100, SRAV=4'B1101;
parameter SLTU=4'B1110;

parameter VEX_R=10'b10000_10000;
parameter VEX_J=10'b00000_00011;
parameter VEX_JAL=10'b10000_01011;
parameter VEX_JR=10'b00000_00101;
parameter VEX_IMM=10'b10010_00000;
parameter VEX_LW=10'b11010_00000;
parameter VEX_SW=10'b00110_00000;
parameter VEX_LUI=10'b10010_00000;

assign ALUOP[2:0] = ALUC[2:0];

`define cpu_ctr_signals{WREG, M2REG, WMEM, ALUIMM, SHIFT,      REGRT, JAL, JR, JUMP, BRANCH}
//WPCIR, FWDA, FWDB, ALUC needs to be configured

initial begin
	state[2:0] = 0;
	WPCIR = 0;
	WMEMW = 0;
	FWDA[1:0] = 0;
	FWDB[1:0] = 0;
	`cpu_ctr_signals <= 10'h0;
	ALUC[3:0] <= 4'b0;
	OP_HEAP[17:0] <= 18'B0;
	REG_HEAP[14:0] <= 15'b0;
end

always@(posedge clk or posedge reset) begin
	if(reset==1) begin
		OP_HEAP[17:0] <= 18'B0;
		REG_HEAP[14:0] <= 15'b0;
	end
	else begin
	case(state[2:0])
		STATE_EXE:  begin
			OP_HEAP[17:0] <= {OP_HEAP[11:0], op[5:0]};
			case(op[5:0])
			6'b00_0010:REG_HEAP[14:0] <= {REG_HEAP[9:0], 5'b0};//J
			6'b00_0010:REG_HEAP[14:0] <= {REG_HEAP[9:0], 5'b11111};//JAL
			6'b00_0100:REG_HEAP[14:0] <= {REG_HEAP[9:0], 5'b0};//BEQ
			6'b00_0101:REG_HEAP[14:0] <= {REG_HEAP[9:0], 5'b0};//BNE
			6'b00_1000:REG_HEAP[14:0] <= {REG_HEAP[9:0], rt[4:0]};//ADDI
			6'b00_1001:REG_HEAP[14:0] <= {REG_HEAP[9:0], rt[4:0]};//ADDIU
			6'b00_1100:REG_HEAP[14:0] <= {REG_HEAP[9:0], rt[4:0]};//ANDI
			6'b00_1101:REG_HEAP[14:0] <= {REG_HEAP[9:0], rt[4:0]};//ORI
			6'b00_1110:REG_HEAP[14:0] <= {REG_HEAP[9:0], rt[4:0]};//XORI
			6'b00_1010:REG_HEAP[14:0] <= {REG_HEAP[9:0], rt[4:0]};//SLTI
			6'b00_1111:REG_HEAP[14:0] <= {REG_HEAP[9:0], rt[4:0]};//LUI
			6'b00_1010:REG_HEAP[14:0] <= {REG_HEAP[9:0], rt[4:0]};//SLTIU
			6'b10_0011:REG_HEAP[14:0] <= {REG_HEAP[9:0], rt[4:0]};//LW
			6'b00_0000: begin
				if(func[5:0]==6'b00_1000) REG_HEAP[14:0] <= {REG_HEAP[9:0], 5'b0};//JR
				REG_HEAP[14:0] <= {REG_HEAP[9:0], rd[4:0]};
			end
			default: REG_HEAP[14:0] <= {REG_HEAP[9:0], 5'b0};
			endcase
		end
		STATE_STALL: begin
			REG_HEAP[14:0] <= {REG_HEAP[9:0], 5'b0};
			OP_HEAP[17:0] <= {OP_HEAP[11:0], 6'b0};
		end
		STATE_LW_STALL:begin
			REG_HEAP[14:0] <= {REG_HEAP[9:0], 5'b0};
			OP_HEAP[17:0] <= {OP_HEAP[11:0], 6'b0};
		end
	endcase
	end
end

always@(negedge clk or posedge reset) begin
	if(reset==1) begin
		state[2:0]=0;
		WPCIR = 0;
		WMEMW = 0;
		FWDA[1:0] = 0;
		FWDB[1:0] = 0;
	end
	else begin
		case(state[2:0])
		STATE_EXE: begin
			case(op[5:0])
			6'b00_0010:begin //J
			WPCIR = 1;
			WMEMW = 0;
			state[2:0]=STATE_STALL[2:0];
			FWDA[1:0] = 2'b00;
			FWDB[1:0] = 2'b00;
			end
			6'b00_0011:begin //JAL
			WPCIR = 1;
			WMEMW = 0;
			state[2:0]=STATE_STALL[2:0];
			FWDA[1:0] = 2'b00;
			FWDB[1:0] = 2'b00;
			end
			6'b00_0100:begin //beq
			if(RS_EQU_RT==1) begin 
				WPCIR = 1;
				WMEMW = 0;
				state[2:0]=STATE_STALL[2:0];
			end
			FWDA[1:0] = 2'b00;
			FWDB[1:0] = 2'b00;
			end
			6'b00_0101:begin //bne
			if(RS_EQU_RT==0) begin
				WPCIR = 1;
				WMEMW = 0;
				state[2:0]=STATE_STALL[2:0];
			end
			FWDA[1:0] = 2'b00;
			FWDB[1:0] = 2'b00;
			end
			default: begin
			if(op[5:0]==6'b00_0000 && func[5:0]==6'b00_1000) begin //JR
				WPCIR = 1;
				WMEMW = 0;
				state[2:0]=STATE_STALL[2:0];
				FWDA[1:0] = 2'b00;
				FWDB[1:0] = 2'b00;
			end
			else begin
					WPCIR = 0;
					if(REG_HEAP[4:0] == rs[4:0] && rs[4:0]!=5'b0) begin
						if(OP_HEAP[5:0] == 6'B10_0011 && op[5:0]!=6'b10_0011) begin
							WPCIR = 1;
							WMEMW = 1;
							FWDA[1:0] = 2'b11;
							state[2:0] = STATE_LW_STALL[2:0];
						end
						else FWDA[1:0] = 2'b01;
					end
					else if(REG_HEAP[9:5] == rs[4:0]  && rs[4:0]!=5'b0)
						if(OP_HEAP[11:6] == 6'B10_0011 && op[5:0]!=6'b10_0011) FWDA[1:0] = 2'b11;
						else FWDA[1:0] = 2'b10;
					else
						FWDA[1:0] = 2'b00;
						
					if(REG_HEAP[4:0] == rt[4:0] && rt[4:0]!=5'b0) begin
						if(OP_HEAP[5:0] == 6'B10_0011 && op[5:0]!=6'b10_0011) begin
							WPCIR = 1;
							WMEMW = 1;
							FWDB[1:0] = 2'b11;
							state[2:0] = STATE_LW_STALL[2:0];
						end
						else FWDB[1:0] = 2'b01;
					end
					else if(REG_HEAP[9:5] == rt[4:0] && rt[4:0]!=5'b0)
						if(OP_HEAP[11:6] == 6'B10_0011 && op[5:0]!=6'b10_0011) FWDB[1:0] = 2'b11;
						else FWDB[1:0] = 2'b10;
					else
						FWDB[1:0] = 2'b00;
			end
			end
			endcase
		end
		STATE_STALL: begin
			WPCIR = 0;
			FWDA[1:0] = 0;
			FWDB[1:0] = 0;
			state[2:0]=STATE_EXE[2:0];
		end
		STATE_LW_STALL:begin
			WPCIR=0;
			WMEMW=0;
			state[2:0]=STATE_EXE[2:0];
		end
		endcase
	end
end

always@* begin
	if(reset == 1) begin
		`cpu_ctr_signals <= 10'h0;
		ALUC[3:0] <= 4'b0;
	end
	else begin
		case(op[5:0])
		6'b00_0000: begin
			case(func[5:0])
			6'b100000: begin //ADD
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= ADD[3:0];
			end
			6'b100001: begin //ADDU
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= ADD[3:0];
			end
			6'b100010: begin //SUB
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= SUB[3:0];
			end
			6'b100011: begin //SUBU
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= SUB[3:0];
			end
			6'b100100: begin //AND
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= AND[3:0];
			end
			6'b100101: begin //OR
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= OR[3:0];
			end
			6'b100110: begin //XOR
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= XOR[3:0];
			end
			6'b100111: begin //NOR
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= NOR[3:0];
			end
			6'b101010:begin  //SLT
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= SLT[3:0];
			end
			6'b101011:begin  //SLTU
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= SLTU[3:0];
			end
			6'b000000:begin  //SLL
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= SLL[3:0];
			end
			6'b000010:begin	//SRL
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= SRL[3:0];
			end
			6'b000011:begin	//SRA
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= SRA[3:0];
			end
			6'b00_0100:begin	//SLLV
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= SLLV[3:0];
			end
			6'b00_0110:begin	//SRLV
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= SRLV[3:0];
			end
			6'b00_0111:begin	//SRAV
				`cpu_ctr_signals <= VEX_R[9:0];
				ALUC[3:0] <= SRAV[3:0];
			end
			6'b00_1000:begin	//JR
				`cpu_ctr_signals <= VEX_JR[9:0];
			end
			endcase	
		end
		6'b10_0011:begin	//LW
			`cpu_ctr_signals <= VEX_LW[9:0];
			ALUC[3:0] <= ADD[3:0];
			SEXT <= 1;
		end
		6'b10_1011:begin	//SW
			`cpu_ctr_signals <= VEX_SW[9:0];
			ALUC[3:0] <= ADD[3:0];
			SEXT <= 1;
		end
		6'b00_0011:begin //JAL
			`cpu_ctr_signals <= VEX_JAL[9:0];
		end
		6'b00_0010:begin //J
			`cpu_ctr_signals <= VEX_J[9:0];
		end
		6'b00_0100:begin //beq
			`cpu_ctr_signals <= {VEX_J[9:1], RS_EQU_RT};
		end
		6'b00_0101:begin //beq
			`cpu_ctr_signals <= {VEX_J[9:1], ~RS_EQU_RT};
		end
		6'b00_1000:begin //addi
			`cpu_ctr_signals <= VEX_IMM[9:0];
			ALUC[3:0] <= ADD[3:0];
			SEXT <= 1;
		end
		6'b00_1001:begin //addiu
			`cpu_ctr_signals <= VEX_IMM[9:0];
			ALUC[3:0] <= ADD[3:0];
			SEXT <= 1;
		end
		6'b00_1100:begin //andi
			`cpu_ctr_signals <= VEX_IMM[9:0];
			ALUC[3:0] <= AND[3:0];
			SEXT <= 0;
		end
		6'b00_1101:begin //ori
			`cpu_ctr_signals <= VEX_IMM[9:0];
			ALUC[3:0] <= OR[3:0];
			SEXT <= 0;
		end
		6'b00_1110:begin //xori
			`cpu_ctr_signals <= VEX_IMM[9:0];
			ALUC[3:0] <= XOR[3:0];
			SEXT <= 0;
		end
		6'b00_1111:begin	//lui
			`cpu_ctr_signals <= VEX_LUI[9:0];
			ALUC[3:0] <= LUI[3:0];
		end
		6'b00_1010:begin	//slti
			`cpu_ctr_signals <= VEX_IMM[9:0];
			ALUC[3:0] <= SLT[3:0];
			SEXT <= 1;
		end
		6'b00_1011:begin	//sltiu
			`cpu_ctr_signals <= VEX_IMM[9:0];
			ALUC[3:0] <= SLT[3:0];
			SEXT <= 0;
		end
		endcase
	end
end

endmodule
