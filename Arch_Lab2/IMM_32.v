`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:57:57 03/31/2016 
// Design Name: 
// Module Name:    IMM_32 
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
module IMM_32(
input [15:0] imm_16,
output [31:0] imm_32
    );

assign imm_32 = {{14{imm_16[15]}}, imm_16[15:0], 2'b00};

endmodule
