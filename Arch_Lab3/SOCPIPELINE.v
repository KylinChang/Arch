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
module SOC(
input wire clk_100mhz,
input wire[4:0] BTN,
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

wire[31:0] clkdiv;
wire CLK_CPU, clk25;
wire MIO_ready;
wire rst, vidon, font_data;

wire[4:0] button_out, button_pulse;
wire[7:0] SW_OK, vga_in, vga_data;
wire[9:0] hc, vc;
wire[10:0] col, row;
wire[15:0] font_addr;

wire[31:0] PC_out, Addr_out, Inst_out, Data_out, Data_in, Inst_in, douta, counter_out,res;
wire[31:0] Cpu_data4bus, Peripheral_in, ram_data_in;
wire[9:0] ram_addr;
wire mem_w, CPU_MIO, INT;
wire GPIOf0000000_we, GPIOe0000000_we, counter_we, data_ram_we;
wire GPIO_VGA_WE;
wire[31:0] Imm_Addr;

wire[31:0] TESTA, TESTB;
wire[31:0] 
reg1, reg2, reg3, reg4, reg5, reg6, reg7,
reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15,
reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23,
reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31;

//+++++++++++++++++++++++++ clk_div ++++++++++++++++++++++++++++//
clk_div(
.clk_100mhz(clk_100mhz),
.rst(rst),
.btn0(button_out[0]),
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
.Inst_out(Inst_out[31:0]),			//TEST
.mem_w(mem_w),
.Addr_out(Addr_out[31:0]),
.Data_out(Data_out[31:0]), 
.res(res[31:0]),
.Inst_in(Inst_in[31:0]),
.Data_in(douta[31:0]),
.CPU_MIO(CPU_MIO),
.INT(INT),
.FWA(LED[1:0]),
.FWB(LED[3:2]),
.TESTA(TESTA),
.TESTB(TESTB),
.ALUOP(LED[6:4]),
.BRANCH(LED[7]),
.Imm_Addr(Imm_Addr[31:0]),

.reg1(reg1[31:0]),
.reg2(reg2[31:0]),
.reg3(reg3[31:0]),
.reg4(reg4[31:0]),
.reg5(reg5[31:0]),
.reg6(reg6[31:0]),
.reg7(reg7[31:0]),
.reg8(reg8[31:0]),
.reg9(reg9[31:0]),
.reg10(reg10[31:0]),
.reg11(reg11[31:0]),
.reg12(reg12[31:0]),
.reg13(reg13[31:0]),
.reg14(reg14[31:0]),
.reg15(reg15[31:0]),
.reg16(reg16[31:0]),
.reg17(reg17[31:0]),
.reg18(reg18[31:0]),
.reg19(reg19[31:0]),
.reg20(reg20[31:0]),
.reg21(reg21[31:0]),
.reg22(reg22[31:0]),
.reg23(reg23[31:0]),
.reg24(reg24[31:0]),
.reg25(reg25[31:0]),
.reg26(reg26[31:0]),
.reg27(reg27[31:0]),
.reg28(reg28[31:0]),
.reg29(reg29[31:0]),
.reg30(reg30[31:0]),
.reg31(reg31[31:0])

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
.clk(clk_100mhz),
.scanning(clkdiv[19:18]),
.GPIOe0000000_we(GPIOe0000000_we),				//EN

.SW(SW_OK[1:0]),							//SW_OK[1:0]
.sel(SW_OK[7:5]),						//SW_OK[7:5]
.disp_cpudata(Data_out[31:0]),			//disp_cpudata
.Test_data1({2'b00,PC_out[31:2]}),
.Test_data2(douta[31:0]),
.Test_data3(Imm_Addr[31:0]),
.Test_data4(ram_addr[9:0]),
.Test_data5(res[31:0]),
.Test_data6(TESTA),
.Test_data7(TESTB),

.AN(AN[3:0]),
.SEGMENT(SEGMENT[7:0])
);
//+++++++++++++++++++++++++ seven_seg_dev ++++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ Font ++++++++++++++++++++++++++++//
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

.red(RED[2:0]),
.green(GREEN[2:0]),
.blue(BLUE[1:0]),

.row(row[10:0]),
.col(col[10:0]),
.font_addr(font_addr[15:0])
);

Reg_Font(
.PC(PC_out[31:0]),
.col(col[10:3]),
.row(row[10:3]),
.vga_data(vga_data[7:0]),
.GPIO_VGA_WE(GPIO_VGA_WE),
.reg1(reg1[31:0]),
.reg2(reg2[31:0]),
.reg3(reg3[31:0]),
.reg4(reg4[31:0]),
.reg5(reg5[31:0]),
.reg6(reg6[31:0]),
.reg7(reg7[31:0]),
.reg8(reg8[31:0]),
.reg9(reg9[31:0]),
.reg10(reg10[31:0]),
.reg11(reg11[31:0]),
.reg12(reg12[31:0]),
.reg13(reg13[31:0]),
.reg14(reg14[31:0]),
.reg15(reg15[31:0]),
.reg16(reg16[31:0]),
.reg17(reg17[31:0]),
.reg18(reg18[31:0]),
.reg19(reg19[31:0]),
.reg20(reg20[31:0]),
.reg21(reg21[31:0]),
.reg22(reg22[31:0]),
.reg23(reg23[31:0]),
.reg24(reg24[31:0]),
.reg25(reg25[31:0]),
.reg26(reg26[31:0]),
.reg27(reg27[31:0]),
.reg28(reg28[31:0]),
.reg29(reg29[31:0]),
.reg30(reg30[31:0]),
.reg31(reg31[31:0])

);

VRAM(
.clka(clk_100mhz),
.wea(GPIO_VGA_WE),
.addra(font_addr[12:0]),
.dina(vga_data[7:0]),
.clkb(~clk_100mhz),
.addrb(font_addr[12:0]),
.doutb(vga_in[7:0])
);

Font(
.ascii(vga_in[7:0]),
.col(col[2:0]),
.row(row[2:0]),
.font(font_data)
);
//+++++++++++++++++++++++++ Font ++++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ Inst_MEM ++++++++++++++++++++++++++++//
Inst_MEM(
.clka(clk_100mhz), // input clka
.addra(PC_out[12:2]), // input [10 : 0] addra
.douta(Inst_in[31:0]) // output [31 : 0] douta
);
//+++++++++++++++++++++++++ Inst_MEM ++++++++++++++++++++++++++++//
//+++++++++++++++++++++++++ Data_MEM ++++++++++++++++++++++++++++//
Data_MEM(
.clka(clk_100mhz), // input clka
.wea(data_ram_we), // input [0 : 0] wea
.addra(ram_addr[9:0]), // input [10 : 0] addra
.dina(ram_data_in[31:0]), // input [31 : 0] dina
.douta(douta[31:0]) // output [31 : 0] douta
);
//+++++++++++++++++++++++++ Data_MEM ++++++++++++++++++++++++++++//

endmodule
