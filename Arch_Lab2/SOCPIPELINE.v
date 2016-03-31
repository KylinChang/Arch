`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:43:30 03/06/2016 
// Design Name: 
// Module Name:    SOCPIPELINE 
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
module SOCPIPELINE(
input wire clk_100mhz,
input wire[4:0] BTN,
input wire[7:0] SW,

input wire PS2C,
input wire PS2D,

output wire[7:0] LED,
output wire[7:0] SEGMENT,
output wire[3:0] AN

//output wire hsync,
//output wire vsync,
//output wire[2:0] RED,
//output wire[2:0] GREEN,
//output wire[1:0] BLUE
    );

wire[31:0] clkdiv;
wire CLK_CPU, clk25;
wire MIO_ready;
wire rst;

wire[4:0] button_out, button_pulse;
wire[7:0] SW_OK;

wire[31:0] PC_out, inst_out, Addr_out, Inst_out, Data_out, Data_in, douta, counter_out;
wire[31:0] Cpu_data4bus, Peripheral_in, ram_data_in;
wire[9:0] ram_addr;
wire mem_w, CPU_MIO, INT;
wire GPIOf0000000_we, GPIOe0000000_we, counter_we, data_ram_we;

//+++++++++++++++++++++++++ clk_div ++++++++++++++++++++++++++++//
clk_div(
.clk_100mhz(clk_100mhz),
.rst(rst),
.SW2(SW_OK[2]),
.clkdiv(clkdiv[31:0]),
.Clk_CPU(CLK_CPU),
.clk25(clk25)
);
//+++++++++++++++++++++++++ clk_div ++++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ CPU ++++++++++++++++++++++++++++//
CPU(
.clk(CLK_CPU),							//CLK_CPU
.reset(rst),
.MIO_ready(MIO_ready),
								
.PC_out(PC_out[31:0]),		   	//TEST
.inst_out(inst_out[31:0]),			//TEST
.mem_w(mem_w),
.Addr_out(Addr_out[31:0]),
.Data_out(Data_out[31:0]), 
.Data_in(Data_in[31:0]),
.CPU_MIO(CPU_MIO),
.INT(INT)
);
//+++++++++++++++++++++++++ CPU ++++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ MIO_BUS +++++++++++++++++++++++++++//
MIO_BUS MIO_BUS(
.clk(clk_100mhz),
.rst(rst),
.mem_w(mem_w),

.BTN(button_out[3:0]),
.SW(SW_OK[7:0]),
.addr_bus(Addr_out[31:0]),
.Cpu_data2bus(Data_out[31:0]),
.ram_data_out(douta[31:0]),
.led_out(LED[7:0]),
.counter_out(counter_out[31:0]),
.GPIOf0000000_we(GPIOf0000000_we),
.GPIOe0000000_we(GPIOe0000000_we),
.counter_we(counter_we),
.Cpu_data4bus(Cpu_data4bus[31:0]),
.Peripheral_in(Peripheral_in[31:0]),
.ram_data_in(ram_data_in[31:0]),
.ram_addr(ram_addr[9:0]),
.data_ram_we(data_ram_we)
);
//+++++++++++++++++++++++++ MIO_BUS +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ Anti_Jitter ++++++++++++++++++++++++++++//
Anti_Jitter(
.clk_100mhz(clk_100mhz), 
.button(BTN[4:0]),
.SW(SW[7:0]), 
.button_out(button_out[4:0]),
.button_pulse(button_pulse[4:0]),
.SW_OK(SW_OK[7:0]),
.rst(rst)
);
//+++++++++++++++++++++++++ Anti_Jitter ++++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ seven_seg_dev ++++++++++++++++++++++++++++//
seven_seg_dev(
.rst(rst),
.clk(CLK_CPU),
.scanning(clkdiv[19:18]),
.GPIOe0000000_we(GPIOe0000000_we),				//EN

.SW(SW_OK[1:0]),							//SW_OK[1:0]
.sel(SW_OK[7:5]),						//SW_OK[7:5]
.disp_cpudata(Peripheral_in[31:0]),			//disp_cpudata
.Test_data1({2'b00,PC_out[31:2]}),
.Test_data2(counter_out[31:0]),
.Test_data3(Inst_out[31:0]),
.Test_data4(Addr_out[31:0]),
.Test_data5(Data_out[31:0]),
.Test_data6(Cpu_data4bus[31:0]),
.Test_data7(PC_out[31:0]),

.AN(AN[3:0]),
.SEGMENT(SEGMENT[7:0])
);
//+++++++++++++++++++++++++ seven_seg_dev ++++++++++++++++++++++++++++//
endmodule