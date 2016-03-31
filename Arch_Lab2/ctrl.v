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
input wire[5:0] op,
input wire[5:0] func,
input wire[4:0] rs,
input wire[4:0] rt,
input wire RS_EQU_RT,

output wire JAL,
output wire WREG,
output wire M2REG,
output wire WMEM,
output wire[2:0] ALUC,
output wire ALUIMM,
output wire SHIFT,
output wire REGRT,
output wire[1:0] FWDB,
output wire[1:0] FWDA,
output wire JR,
output wire JUMP,

output wire BRANCH,
output wire WPCIR
);

parameter AND=3'B000,OR=3'B001,ADD=4'B010;
parameter XOR=3'B011,NOR=3'B100,SRL=3'B101;
parameter SUB=3'B110,SLT=3'B111;

`define cpu_ctr_signals{JAL, WREG, M2REG, WMEM, ALUIMM, SHIFT, REGRT, FWDB[1:0], FWDA[1:0], JR, JUMP, BRANCH, WPCIR}

always@* begin
	
end

endmodule
