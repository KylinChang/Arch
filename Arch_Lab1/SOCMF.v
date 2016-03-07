`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:33 05/24/2015 
// Design Name: 
// Module Name:    SOCMF 
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
module SOCMF(
input wire clk_100mhz,
input wire PS2C,
input wire PS2D,
input wire[3:0] BTN,
input wire[7:0] SW,
output wire[7:0] LED,
output wire[7:0] SEGMENT,
output wire[3:0] AN,
output wire hsync,
output wire vsync,
output wire[2:0] RED,
output wire[2:0] GREEN,
output wire[1:0] BLUE
    );

wire clk25,vidon;
wire clka,rst,Clk_CPU,Clk_CPUa,mem_w,counter0_OUT,counter1_OUT,counter2_OUT;
wire CPU_MIO,data_ram_we,counter_we,GPIOe0000000_we,GPIOf0000000_we;
wire[1:0] counter_set;
wire[3:0] button_pulse,button_out,point_out,blink_out;
wire[4:0] state;
wire[7:0] SW_OK,vga_in,vga_out;
wire[9:0] ram_addr,hc,vc,xc,yc,C,R;
wire[10:0] x,y;
wire[15:0] vram_addr,xkey;
wire[21:0] GPIOf0;
wire[31:0] clkdiv,Inst_out,PC_out,Addr_out,Data_out,Disp_num;
wire[31:0] ram_data_in,douta,counter_out,Cpu_data4bus,Peripheral_in,vga_databus;
wire[31:0] register0,
register1,
register2,
register3,
register4,
register5,
register6,
register7,
register8,
register9,
register10,
register11,
register12,
register13,
register14,
register15,
register16,
register17,
register18,
register19,
register20,
register21,
register22,
register23,
register24,
register25,
register26,
register27,
register28,
register29,
register30,
register31;

wire GPIOvga_we;
wire[15:0] vram_waddr;

wire[10:0] row, col;
wire[15:0] font_addr;
wire font_data;
wire[7:0] vga_data;
wire GPIO_VGA_WE;

wire[31:0] register [1:31];

assign clka=~clk_100mhz;
assign Clk_CPUa=~Clk_CPU;
assign xc[9:0]=vga_databus[9:0];
assign yc[9:0]=vga_databus[25:16];

//+++++++++++++++++++++++++ Multi_CPU +++++++++++++++++++++++++++//
Muliti_CPU muliti_cpu(
.clk(Clk_CPU),
.reset(rst),
.inst_out(Inst_out[31:0]),
.INT(counter0_OUT),
.mem_w(mem_w),
.PC_out(PC_out[31:0]),
.state(state),
.Addr_out(Addr_out[31:0]),
.Data_out(Data_out[31:0]),
.CPU_MIO(CPU_MIO),
.Data_in(Cpu_data4bus[31:0]),
.MIO_ready(1'b1),
.register0(register0),
.register1(register1),
.register2(register2),
.register3(register3),
.register4(register4),
.register5(register5),
.register6(register6),
.register7(register7),
.register8(register8),
.register9(register9),
.register10(register10),
.register11(register11),
.register12(register12),
.register13(register13),
.register14(register14),
.register15(register15),
.register16(register16),
.register17(register17),
.register18(register18),
.register19(register19),
.register20(register20),
.register21(register21),
.register22(register22),
.register23(register23),
.register24(register24),
.register25(register25),
.register26(register26),
.register27(register27),
.register28(register28),
.register29(register29),
.register30(register30),
.register31(register31)
);
//+++++++++++++++++++++++++ Multi_CPU +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ clk_div +++++++++++++++++++++++++++//
clk_div(
.clk(clk_100mhz),
.rst(rst),
.SW2(SW_OK[2]),
.clkdiv(clkdiv),
.Clk_CPU(Clk_CPU),
.clk25(clk25)
);

//+++++++++++++++++++++++++ clk_div +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ MIO_BUS +++++++++++++++++++++++++++//
MIO_BUS(
.clk(clk_100mhz),
.rst(rst),
.mem_w(mem_w),
.counter0_out(counter0_OUT),
.counter1_out(counter1_OUT),
.counter2_out(counter2_OUT),
.BTN(button_out[3:0]),
.SW(SW_OK[7:0]),
.xkey(xkey[15:0]),
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
.data_ram_we(data_ram_we),
.vram_addr(vram_waddr[15:0]),
.GPIOvga_we(GPIOvga_we)
);
//+++++++++++++++++++++++++ MIO_BUS +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ Seven_seg_Dev_IO +++++++++++++++++++++++++++//
seven_seg_Dev_IO(
.clk(Clk_CPUa),
.rst(rst),
.GPIOe0000000_we(GPIOe0000000_we),
.Test(SW_OK[7:5]),
.point_in(32'hFFFF_FFFF),
.blink_in(32'h0000_0000),
.disp_cpudata(Peripheral_in[31:0]),
.Test_data1({2'b00,PC_out[31:2]}),
.Test_data2(counter_out[31:0]),
.Test_data3(Inst_out[31:0]),
.Test_data4(Addr_out[31:0]),
.Test_data5(Data_out[31:0]),
.Test_data6(Cpu_data4bus[31:0]),
.Test_data7(PC_out[31:0]),
.Disp_num(Disp_num[31:0]),
.blink_out(blink_out[3:0]),
.point_out(point_out[3:0])
);
//+++++++++++++++++++++++++ Seven_seg_Dev_IO +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ seven_seg_dev +++++++++++++++++++++++++++//
seven_seg_dev(
.flash_clk(clkdiv[26]),
.disp_num(Disp_num[31:0]),
.SW(SW_OK[1:0]),
.Scanning(clkdiv[19:18]),
.SEGMENT(SEGMENT[7:0]),
.pointing(point_out[3:0]),
.blinking(blink_out[3:0]),
.AN(AN[3:0])
);
//+++++++++++++++++++++++++ seven_seg_dev +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ led_Dev_IO +++++++++++++++++++++++++++//
led_Dev_IO(
.clk(Clk_CPUa),
.rst(rst),
.GPIOf0000000_we(GPIOf0000000_we),
.Peripheral_in(Peripheral_in[31:0]),
.counter_set(counter_set[1:0]),
.led_out(LED[7:0]),
.GPIOf0(GPIOf0)
);
//+++++++++++++++++++++++++ led_Dev_IO +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ Anti_jitter +++++++++++++++++++++++++++//
Anti_jitter(
.clk(clk_100mhz),
.button(BTN[3:0]),
.SW(SW[7:0]),
.SW_OK(SW_OK[7:0]),
.button_pulse(button_pulse[3:0]),
.rst(rst),
.button_out(button_out[3:0])
);
//+++++++++++++++++++++++++ Anti_jitter +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ Counter_x +++++++++++++++++++++++++++//
Counter_x(
.clk(Clk_CPUa),
.rst(rst),
.clk0(clkdiv[7]),
.clk1(clkdiv[10]),
.clk2(clkdiv[10]),
.counter_we(counter_we),
.counter_val(Peripheral_in[31:0]),
.counter_ch(counter_set[1:0]),
.counter0_OUT(counter0_OUT),
.counter1_OUT(counter1_OUT),
.counter2_OUT(counter2_OUT),
.counter_out(counter_out[31:0])
);
//+++++++++++++++++++++++++ Counter_x +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ RAM_B +++++++++++++++++++++++++++//
RAM_B(
.addra(ram_addr[9:0]),
.wea(data_ram_we),
.dina(ram_data_in[31:0]),
.clka(clka),
.douta(douta[31:0])
);
//+++++++++++++++++++++++++ RAM_B +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ VGA +++++++++++++++++++++++++++//
vga_640x480(
.clk(clk25),
.clr(rst),
.hsync(hsync),
.vsync(vsync),
.hc(hc[9:0]),
.vc(vc[9:0]),
.vidon(vidon)
);

vga_display(
.vidon(vidon),
.hc(hc[9:0]),
.vc(vc[9:0]),
.font_data(font_data),
.M(vga_in[7:0]),
.CX(C[9:0]),
.RX(R[9:0]),
.red(RED[2:0]),
.green(GREEN[2:0]),
.blue(BLUE[1:0]),

.row(row[10:0]),
.col(col[10:0]),
.font_addr(font_addr[15:0])
);

VRAM_B(
.clka(clk_100mhz),
.wea(GPIO_VGA_WE),
.addra(font_addr[12:0]),
.dina(vga_data[7:0]),
.clkb(clka),
.addrb(font_addr[12:0]),
.doutb(vga_in[7:0])
);

Font(
.ascii(vga_in[7:0]),
.col(col[2:0]),
.row(row[2:0]),
.font(font_data)
);

Reg_Font(
.col(col[10:3]),
.row(row[10:3]),
.register1(register1),
.register2(register2),
.register3(register3),
.register4(register4),
.register5(register5),
.register6(register6),
.register7(register7),
.register8(register8),
.register9(register9),
.register10(register10),
.register11(register11),
.register12(register12),
.register13(register13),
.register14(register14),
.register15(register15),
.register16(register16),
.register17(register17),
.register18(register18),
.register19(register19),
.register20(register20),
.register21(register21),
.register22(register22),
.register23(register23),
.register24(register24),
.register25(register25),
.register26(register26),
.register27(register27),
.register28(register28),
.register29(register29),
.register30(register30),
.register31(register31),

.vga_data(vga_data[7:0]),
.GPIO_VGA_WE(GPIO_VGA_WE)
);
//+++++++++++++++++++++++++ VGA +++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ KEYBOARD +++++++++++++++++++++++++++//
keyboard(
.clk25(clk25),
.PS2C(PS2C),
.PS2D(PS2D),
.xkey(xkey[15:0])
);
//+++++++++++++++++++++++++ KEYBOARD +++++++++++++++++++++++++++//

endmodule
