`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:15 03/30/2016 
// Design Name: 
// Module Name:    DataPath 
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
module DataPath(
input clk,
input reset,
input MIO_ready,
					  
input wire JAL,
input wire WREG,
input wire M2REG,
input wire WMEM,
input wire[3:0] ALUC,
input wire ALUIMM,
input wire SHIFT,
input wire REGRT,
input wire[1:0] FWDB,
input wire[1:0] FWDA,
input wire JR,
input wire JUMP,

input wire BRANCH,
input wire WPCIR,
					  
output[31:0]PC_Current,
input[31:0]data2CPU,
					  
output[31:0]Inst_R,
output[31:0]data_out,
output[31:0]M_addr,

output RS_EQU_RT
    );

wire PC_CE;
wire[31:0] o_PC, IF_PC, ID_PC, mux_Wt_data, rdata_A, rdata_B;
wire[31:0] Imm_32, Imm_Ext, Imm_Addr;
wire[31:0] JAddr, JMUX_Addr, JRMUX_Addr;
wire[31:0] Data_A, Data_B;

/*************************  IF STAGE  *****************************/
REG32 PC(
.clk(clk),
.rst(reset),
.CE(PC_CE),
.D(o_PC[31:0]),
.Q(PC_Current[31:0])
);

Adder NPC(
.A(PC_Current[31:0]),
.B(32'h4),
.O(IF_PC[31:0])
);

mux2to1_32(
.sel(BRANCH),
.a(JRMUX_Addr[31:0]),
.b(IF_PC[31:0]),
.o(o_PC[31:0])
);

/*************************  ID STAGE  *****************************/
REG32 REG32_IR(
.clk(clk),
.rst(1'b0),
.CE(IRWrite),
.D(data2CPU[31:0]),
.Q(Inst_R[31:0]),
.IF_PC(IF_PC[31:0]),
.ID_PC(ID_PC[31:0])
);

IMM_32(
.imm_16(Inst_R[15:0]),
.imm_32(Imm_Ext[31:0])
);

Adder Imm_Addr(
.A(ID_PC[31:0]),
.B(Imm_Ext[31:0]),
.O(Imm_Addr[31:0])
);

Address(
.addr_head(ID_PC[31:28]),
.addr(Inst_R[25:0]),
.addr_out(JAddr[31:0])
);

mux2to1_32 JUMP_MUX(
.sel(JUMP),
.a(JAddr[31:0]),
.b(Imm_Addr[31:0]),
.o(JMUX_Addr[31:0])
);

mux2to1_32 JR_MUX(
.sel(JAL),
.a(Data_A[31:0]),
.b(JMUX_Addr[31:0]),
.o(JRMUX_Addr[31:0])
);

Regs(
.clk(clk),
.rst(reset),
.R_addr_A(Inst_R[25:21]),
.R_addr_B(Inst_R[20:16]),
.Wt_addr(mux_Wt_addr[4:0]),
.Wt_data(mux_Wt_data[31:0]),
.L_S(RegWrite),
.rdata_A(rdata_A[31:0]),
.rdata_B(rdata_B[31:0])
);

mux4to1_32 rdata_A(
.sel(FWDA[1:0]),
.A(rdata_A[31:0]),
.B(32'b0),
.C(32'b0),
.D(32'b0),
.O(Data_A[31:0])
);

mux4to1_32 rdata_B(
.sel(FWDB[1:0]),
.A(rdata_B[31:0]),
.B(32'b0),
.C(32'b0),
.D(32'b0),
.O(Data_B[31:0])
);

Ext_32(
.imm_16(Inst_R[15:0]),
.imm_32(Imm_32[31:0])
);

/*************************  EXE STAGE  *****************************/

ALU(
);


/*************************  MEM STAGE  *****************************/



/*************************  WB STAGE  *****************************/
endmodule
