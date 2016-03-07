`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:03 06/04/2015 
// Design Name: 
// Module Name:    ctrl 
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
module ctrl(input  clk,
				input  reset,
				input  [31:0] Inst_in,
				input  zero,
				input  overflow,
				input  MIO_ready,
				output reg MemRead,
				output reg MemWrite,
				output reg[2:0]ALU_operation,
				output reg[4:0]state_out,
				
				output reg CPU_MIO,
				output reg IorD,
				output reg IRWrite,
				output reg [1:0]RegDst,
				output reg RegWrite,
				output reg [1:0]MemtoReg,
				output reg ALUSrcA,
				output reg [1:0]ALUSrcB,
				output reg [1:0]PCSource,
				output reg PCWrite,
				output reg PCWriteCond,
				output reg Branch
				);
				
parameter IF=5'B0_0000,ID=5'B0_0001,EX_R=5'B0_0010;
parameter EX_MEM=5'B0_0011,EX_I=5'B0_0100,EX_LUI=5'B0_0101;
parameter EX_BEQ=5'B0_0110,EX_BNE=5'B0_0111,EX_JR=5'B0_1000;
parameter EX_JAL=5'B0_1001,EX_J=5'B0_1010,MEM_RD=5'B0_1011;
parameter MEM_WD=5'B0_1100,WB_R=5'B0_1101,WB_I=5'B0_1110;
parameter WB_LW=5'B0_1111,ERROR=5'B1_1111;

parameter VIF=17'H12821,VID=17'H00060,VEX_R=17'H00010;
parameter VEX_MEM=17'H00050,VEX_I=17'H00050,VEX_LUI=17'H00419;
parameter VEX_BEQ=17'H08090,VEX_BNE=17'H08090,VEX_JR=17'H10010;
parameter VEX_JAL=17'H1076C,VEX_J=17'H10160,VMEM_RD=17'H06001;
parameter VMEM_WD=17'H05001,VWB_R=17'H0001A,VWB_I=17'H00058;
parameter VWB_LW=17'H00208,VERROR=17'H00000;

parameter AND=3'B000,OR=3'B001,ADD=4'B010;
parameter XOR=3'B011,NOR=3'B100,SRL=3'B101;
parameter SUB=3'B110,SLT=3'B111;
//`define cpu_ctr_signals={PCWrite,PCWriteCond,IorD,MemRead,MemWrite,IRWrite,MemrtoReg[1:0],
//PCSource[1:0],ALUSrcB[1:0],ALUSrcA,RegWrite,RegDst[1:0],CPU_MIO};
`define cpu_ctr_signals{PCWrite,PCWriteCond,IorD,MemRead,MemWrite,IRWrite,MemtoReg[1:0],PCSource[1:0],ALUSrcB[1:0],ALUSrcA,RegWrite,RegDst[1:0],CPU_MIO}

always@(posedge clk or posedge reset)begin
	if(reset==1) begin
		state_out[4:0] <= IF[4:0];
		ALU_operation[2:0] <= ADD[2:0];
		`cpu_ctr_signals <= VIF[16:0];
		Branch <= 1'b0;
	end
	else begin
		case(state_out[4:0])
		IF[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VID[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= ID[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VIF[16:0];
				state_out[4:0] <= IF[4:0];
				ALU_operation[2:0] <= ADD[2:0];
				Branch <= 1'b0;
			end
		end
		ID[4:0]:begin
			if(MIO_ready) begin
				case(Inst_in[31:26])
				6'b000000:begin  
					`cpu_ctr_signals <= VEX_R[16:0];
					state_out[4:0] <= EX_R[4:0];
					Branch <= 1'b0;
					case(Inst_in[5:0])
					6'b100000: ALU_operation[2:0] <= ADD[2:0];//add
					6'b100010: ALU_operation[2:0] <= SUB[2:0];//sub
					6'b100100: ALU_operation[2:0] <= AND[2:0];//and
					6'b100101: ALU_operation[2:0] <= OR[2:0];//or
					6'b101010: ALU_operation[2:0] <= SLT[2:0];//slt
					6'b100111: ALU_operation[2:0] <= NOR[2:0];//nor
					6'b000010: ALU_operation[2:0] <= SRL[2:0];//srl
					6'b100110: ALU_operation[2:0] <= XOR[2:0];//xor
					6'b001000: begin
						`cpu_ctr_signals <= VEX_JR[16:0];
						ALU_operation[2:0] <= ADD[2:0];
						state_out[4:0] <= EX_JR[4:0];
						Branch <= 1'b0;
					end//jr
					endcase
				end//ALU
				6'b100011:begin  
					`cpu_ctr_signals <= VEX_MEM[16:0];
					state_out[4:0] <= EX_MEM[4:0];
					ALU_operation[2:0] <= ADD[2:0];
					Branch <= 1'b0;
				end//lw
				6'b101011:begin  
					`cpu_ctr_signals <= VEX_MEM[16:0];
					state_out[4:0] <= EX_MEM[4:0];
					ALU_operation[2:0] <= ADD[2:0];
					Branch <= 1'b0;
				end//sw
				6'b000100:begin
					`cpu_ctr_signals <= VEX_BEQ[16:0];
					state_out[4:0] <= EX_BEQ[4:0];
					ALU_operation[2:0] <= SUB[2:0];
					Branch <= 1'b1;
				end//beq 
				6'b000101:begin
					`cpu_ctr_signals <= VEX_BNE[16:0];
					state_out[4:0] <= EX_BNE[4:0];
					ALU_operation[2:0] <= SUB[2:0];
					Branch <= 1'b0;
				end//bne 
				6'b000010:begin
					`cpu_ctr_signals <= VEX_J[16:0];
					state_out[4:0] <= EX_J[4:0];
					Branch <= 1'b0;
				end//j
				6'b000011:begin 
					`cpu_ctr_signals <= VEX_JAL[16:0];
					state_out[4:0] <= EX_JAL[4:0];
					Branch <= 1'b0;
				end //jal
				6'b001010:begin 
					`cpu_ctr_signals <= VEX_I[16:0];
					state_out[4:0] <= EX_I[4:0];
					ALU_operation[2:0] <= SLT[2:0];
					Branch <= 1'b0;
				end//slti
				6'b001100:begin 
					`cpu_ctr_signals <= VEX_I[16:0];
					state_out[4:0] <= EX_I[4:0];
					ALU_operation[2:0] <= AND[2:0];
					Branch <= 1'b0;
				end //andi
				6'b001000:begin 
					`cpu_ctr_signals <= VEX_I[16:0];
					state_out[4:0] <= EX_I[4:0];
					ALU_operation[2:0] <= ADD[2:0];
					Branch <= 1'b0;
				end //addi
				6'b001101:begin
					`cpu_ctr_signals <= VEX_I[16:0];
					state_out[4:0] <= EX_I[4:0];
					ALU_operation[2:0] <= OR[2:0];
					Branch <= 1'b0;
				end //ori
				6'b001110:begin 
					`cpu_ctr_signals <= VEX_I[16:0];
					state_out[4:0] <= EX_I[4:0];
					ALU_operation[2:0] <= XOR[2:0];
					Branch <= 1'b0;
				end //xori
				6'b001111:begin 
					`cpu_ctr_signals <= VEX_LUI[16:0];
					state_out[4:0] <= EX_LUI[4:0];
					ALU_operation[2:0] <= AND[2:0];
					Branch <= 1'b0;
				end //lui
				endcase
			end
			else begin
				`cpu_ctr_signals <= VID[16:0];
				state_out[4:0] <= ID[4:0];
				ALU_operation[2:0] <= ADD[2:0];
				Branch <= 1'b0;
			end
		end
		EX_R[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VWB_R[16:0];
				state_out[4:0] <= WB_R[4:0];
				ALU_operation[2:0] <= ALU_operation[2:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VEX_R[16:0];
				state_out[4:0] <= EX_R[4:0];
				ALU_operation[2:0] <= ALU_operation[2:0];
				Branch <= 1'b0;
			end
		end
		EX_MEM[4:0]:begin
			if(MIO_ready) begin
				Branch <= 1'b0;
				case(Inst_in[31:26])
				6'b100011:begin
					`cpu_ctr_signals <= VMEM_RD[16:0];
					ALU_operation[2:0] <= ADD[2:0];
					state_out[4:0] <= MEM_RD[4:0];
				end
				6'b101011:begin
					`cpu_ctr_signals <= VMEM_WD[16:0];
					ALU_operation[2:0] <= ADD[2:0];
					state_out[4:0] <= MEM_WD[4:0];
				end
				endcase
			end
			else begin
				`cpu_ctr_signals <= VEX_MEM[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= EX_MEM[4:0];
				Branch <= 1'b0;
			end
		end
		EX_I[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VWB_I[16:0];
				ALU_operation[2:0] <= ALU_operation[2:0];
				state_out[4:0] <= WB_I[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VEX_I[16:0];
				ALU_operation[2:0] <= ALU_operation[2:0];
				state_out[4:0] <= EX_I[4:0];
				Branch <= 1'b0;
			end
		end
		EX_LUI[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VIF[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= IF[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VEX_LUI[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= EX_LUI[4:0];
				Branch <= 1'b0;
			end
		end
		EX_BEQ[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VIF[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= IF[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VEX_BEQ[16:0];
				ALU_operation[2:0] <= SUB[2:0];
				state_out[4:0] <= EX_BEQ[4:0];
				Branch <= 1'b1;
			end
		end
		EX_BNE[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VIF[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= IF[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VEX_BNE[16:0];
				ALU_operation[2:0] <= SUB[2:0];
				state_out[4:0] <= EX_BNE[4:0];
				Branch <= 1'b0;
			end
		end
		EX_JR[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VIF[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= IF[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VEX_JR[16:0];
				state_out[4:0] <= EX_JR[4:0];
				Branch <= 1'b0;
			end
		end
		EX_JAL[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VIF[16:0];
				state_out[4:0] <= IF[4:0];
				ALU_operation[2:0] <= ADD[2:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VEX_JAL[16:0];
				state_out[4:0] <= EX_JAL[4:0];
				ALU_operation[2:0] <= ADD[2:0];
				Branch <= 1'b0;
			end
		end
		EX_J[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VIF[16:0];
				state_out[4:0] <= IF[4:0];
				ALU_operation[2:0] <= ADD[2:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VEX_J[16:0];
				state_out[4:0] <= EX_J[4:0];
				ALU_operation[2:0] <= ADD[2:0];
				Branch <= 1'b0;
			end
		end
		MEM_RD[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VWB_LW[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= WB_LW[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VMEM_RD[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= MEM_RD[4:0];
				Branch <= 1'b0;
			end
		end
		MEM_WD[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VIF[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= IF[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VMEM_WD[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= MEM_WD[4:0];
				Branch <= 1'b0;
			end
		end
		WB_R[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VIF[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= IF[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VWB_R[16:0];
				ALU_operation[2:0] <= ALU_operation[2:0];
				state_out[4:0] <= WB_R[4:0];
				Branch <= 1'b0;
			end
		end
		WB_I[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VIF[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= IF[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VWB_I[16:0];
				ALU_operation[2:0] <= ALU_operation[2:0];
				state_out[4:0] <= WB_I[4:0];
				Branch <= 1'b0;
			end
		end
		WB_LW[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VIF[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= IF[4:0];
				Branch <= 1'b0;
			end
			else begin
				`cpu_ctr_signals <= VWB_LW[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= WB_LW[4:0];
				Branch <= 1'b0;
			end
		end
		ERROR[4:0]:begin
			if(MIO_ready) begin
				`cpu_ctr_signals <= VID[16:0];
				ALU_operation[2:0] <= ADD[2:0];
				state_out[4:0] <= IF[4:0];
			end
		end
		default:begin
		end
		endcase
	end
end
	
endmodule