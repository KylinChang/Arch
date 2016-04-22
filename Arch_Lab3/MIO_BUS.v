`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:15:37 03/06/2016 
// Design Name: 
// Module Name:    MIO_BUS 
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
module MIO_BUS(
					input wire clk,
					input wire rst,
					input wire[3:0] BTN,
					input wire[7:0] SW,
					input wire mem_w,
					input wire[31:0] Cpu_data2bus,									//data from CPU
					input wire[31:0] addr_bus,
					input wire[31:0] ram_data_out,
					input wire[7:0] led_out,
					input wire[31:0] counter_out,
					
					output reg[31:0] Cpu_data4bus,									//write to CPU
					output reg[31:0] ram_data_in,								//from CPU write to Memory
					output reg[9:0] ram_addr,									//Memory Address signals
					output reg data_ram_we,
					output reg GPIOf0000000_we,
					output reg GPIOe0000000_we,
					output reg counter_we,
					output reg[31:0] Peripheral_in
    );

reg data_ram_rd,GPIOf0000000_rd,GPIOe0000000_rd,counter_rd;

always@* begin
	data_ram_we=0;
	data_ram_rd=0;
	counter_we=0;
	counter_rd=0;
	GPIOf0000000_we=0;
	GPIOe0000000_we=0;
	GPIOf0000000_rd=0;
	GPIOe0000000_rd=0;
	ram_addr=10'h0;
	ram_data_in=32'h0;
	Peripheral_in=32'h0;
	Cpu_data4bus =32'h0;
	
	case(addr_bus[31:28])
	4'h0:begin
		ram_addr = addr_bus[11:2];
		ram_data_in = Cpu_data2bus;
		Cpu_data4bus = ram_data_out;
		data_ram_rd = ~mem_w;
		data_ram_we = mem_w;
//		if(clk==1) begin
//			data_ram_we = mem_w;
//		end
//		else begin
//			data_ram_we = 0;
//		end
	end
	4'he:begin              //7 segments LEDs
		GPIOe0000000_we = mem_w;
		Peripheral_in = Cpu_data2bus;
		Cpu_data4bus = counter_out;
		GPIOe0000000_rd = ~mem_w;
	end
	4'hf:begin
		if(addr_bus[2])begin
			counter_we = mem_w;
			Peripheral_in = Cpu_data2bus;
			Cpu_data4bus = counter_out;
			counter_rd = ~mem_w;
		end
		else begin
			GPIOf0000000_we = mem_w;
			Peripheral_in = Cpu_data2bus;
			Cpu_data4bus = {12'h00,led_out,BTN,SW};
			GPIOf0000000_rd = ~mem_w;
		end
	end
	endcase
end

endmodule
