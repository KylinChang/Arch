`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:09:39 03/31/2016 
// Design Name: 
// Module Name:    Address 
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
module Address(
input wire[3:0] addr_head,
input wire[25:0] addr,

output reg[31:0] addr_out
    );

always@* begin
	addr_out[31:0] <= {addr_head[3:0], addr[25:0], 2'b00};
end

endmodule
