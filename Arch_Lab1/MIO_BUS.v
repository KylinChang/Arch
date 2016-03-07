`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:04:14 06/30/2012 
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
module MIO_BUS(clk,
					rst,
					BTN,
					SW,
					mem_w,
					Cpu_data2bus,									//data from CPU
					addr_bus,
					ram_data_out,
					led_out,
					counter_out,
					counter0_out,
					counter1_out,
					counter2_out,
					xkey,
					
					Cpu_data4bus,									//write to CPU
					ram_data_in,								//from CPU write to Memory
					ram_addr,									//Memory Address signals
					data_ram_we,
					GPIOf0000000_we,
					GPIOe0000000_we,
					counter_we,
					Peripheral_in,
					vram_addr,
					GPIOvga_we
					);
					
parameter VRAM=32'h000C0000;
		
input clk,rst,mem_w;
input counter0_out,counter1_out,counter2_out;
input [3:0]BTN;
input [7:0]SW,led_out;
input [15:0] xkey;
input [31:0] Cpu_data2bus,ram_data_out,addr_bus,counter_out;					
output data_ram_we,GPIOe0000000_we,GPIOf0000000_we,counter_we;
output [31:0]Cpu_data4bus,ram_data_in,Peripheral_in;	
output [9:0] ram_addr;

output vram_addr;
output GPIOvga_we;

reg data_ram_we,GPIOf0000000_we,GPIOe0000000_we,GPIOd0000000_we,counter_we;
reg data_ram_rd,GPIOf0000000_rd,GPIOe0000000_rd,GPIOd0000000_rd,counter_rd;
reg[9:0] ram_addr;
reg[31:0] Cpu_data4bus,ram_data_in,Peripheral_in;
reg[7:0] led_in;
wire[7:0] led_out;
wire counter_over;

reg[15:0] vram_addr;
reg GPIOvga_we;

always@* begin
	data_ram_we=0;
	data_ram_rd=0;
	counter_we=0;
	counter_rd=0;
	GPIOf0000000_we=0;
	GPIOe0000000_we=0;
	GPIOd0000000_we=0;
	GPIOf0000000_rd=0;
	GPIOe0000000_rd=0;
	GPIOd0000000_rd=0;
	ram_addr=10'h0;
	ram_data_in=32'h0;
	Peripheral_in=32'h0;
	Cpu_data4bus =32'h0;
	
	vram_addr=16'h0;
	GPIOvga_we=0;
	
	case(addr_bus[31:28])
	4'h0:begin
		ram_addr = addr_bus[11:2];
		ram_data_in = Cpu_data2bus;
		Cpu_data4bus = ram_data_out;
		data_ram_rd = ~mem_w;
		vram_addr[15:0] = addr_bus[31:0] - VRAM[31:0];
		if(addr_bus[31:16]==16'h000C) begin
			GPIOvga_we = mem_w;
		end
		else begin
			data_ram_we = mem_w;
		end
	end
	4'hd:begin
		if(addr_bus[2])begin
			counter_we = mem_w;
			Peripheral_in = Cpu_data2bus;
			Cpu_data4bus = counter_out;
			counter_rd = ~mem_w;
		end
		else begin
			GPIOd0000000_we = mem_w;
			Peripheral_in = Cpu_data2bus;
			Cpu_data4bus = {xkey[15:0],16'h0};
			GPIOd0000000_rd = ~mem_w;
		end
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
			Cpu_data4bus = {counter0_out,counter1_out,counter2_out,9'h00,led_out,BTN,SW};
			GPIOf0000000_rd = ~mem_w;
		end
	end
	endcase
	casex({data_ram_rd,GPIOe0000000_rd,counter_rd,GPIOf0000000_rd})
		4'b1xxx:Cpu_data4bus = ram_data_out; //read from RAM
		4'bx1xx:Cpu_data4bus = counter_out;  //read from Counter
		4'bxx1x:Cpu_data4bus = counter_out;  //read from Counter
		4'bxxx1:Cpu_data4bus = {counter0_out,counter1_out,counter2_out,9'h00,led_out,BTN,SW}; //read from SW & BTN
	endcase
end

endmodule