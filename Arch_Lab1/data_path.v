module data_path(input clk,
					  input reset,
					  
					  input MIO_ready,
					  input IorD,
					  input IRWrite,
					  input[1:0] RegDst,
					  input RegWrite,
					  input[1:0]MemtoReg,
					  input ALUSrcA,
					  
					  input[1:0]ALUSrcB,
					  input[1:0]PCSource,
					  input PCWrite,
					  input PCWriteCond,	
					  input Branch,
					  input[2:0]ALU_operation,
					  
					  output[31:0]PC_Current,
					  input[31:0]data2CPU,
					  output[31:0]Inst_R,
					  output[31:0]data_out,
					  output[31:0]M_addr,
					  
					  output zero,
					  output overflow,
					  
					  output[31:0] register0,
	output[31:0] register1,
	output[31:0] register2,
	output[31:0] register3,
	output[31:0] register4,
	output[31:0] register5,
	output[31:0] register6,
	output[31:0] register7,
	output[31:0] register8,
	output[31:0] register9,
	output[31:0] register10,
	output[31:0] register11,
	output[31:0] register12,
	output[31:0] register13,
	output[31:0] register14,
	output[31:0] register15,
	output[31:0] register16,
	output[31:0] register17,
	output[31:0] register18,
	output[31:0] register19,
	output[31:0] register20,
	output[31:0] register21,
	output[31:0] register22,
	output[31:0] register23,
	output[31:0] register24,
	output[31:0] register25,
	output[31:0] register26,
	output[31:0] register27,
	output[31:0] register28,
	output[31:0] register29,
	output[31:0] register30,
	output[31:0] register31
					  );	

wire PC_CE;
wire[4:0] ra;
wire[4:0] mux_Wt_addr;
wire[31:0] MDR,lui,rdata_A,rdata_B,mux_Wt_data;
wire[31:0] SrcA_out,SrcB_out,res,ALUOut,Imm_32,o_PC;
wire o_xora,o_and,o_or;

assign data_out[31:0]=rdata_B[31:0];
assign ra[4:0]=5'b11111;

assign o_xora=~(zero^Branch);
assign o_and=o_xora&PCWriteCond;
assign o_or=o_and|PCWrite;
assign PC_CE=o_or&MIO_ready;
assign lui[31:0]={Inst_R[15:0],16'h0};

ALU U1(
.ALU_operation(ALU_operation[2:0]),
.A(SrcA_out[31:0]),
.B(SrcB_out[31:0]),
.zero(zero),
.res(res[31:0]),
.overflow(overflow)
);


Regs U2(
.clk(clk),
.rst(reset),
.R_addr_A(Inst_R[25:21]),
.R_addr_B(Inst_R[20:16]),
.Wt_addr(mux_Wt_addr[4:0]),
.Wt_data(mux_Wt_data[31:0]),
.L_S(RegWrite),
.rdata_A(rdata_A[31:0]),
.rdata_B(rdata_B[31:0]),
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

REG32 REG32_IR(
.clk(clk),
.rst(1'b0),
.CE(IRWrite),
.D(data2CPU[31:0]),
.Q(Inst_R[31:0])
);

REG32 REG32_MDR(
.clk(clk),
.rst(1'b0),
.CE(1'b1),
.D(data2CPU[31:0]),
.Q(MDR[31:0])
);

REG32 ALUOUT(
.clk(clk),
.rst(1'b0),
.CE(1'b1),
.D(res[31:0]),
.Q(ALUOut[31:0])
);

REG32 PC(
.clk(clk),
.rst(reset),
.CE(PC_CE),
.D(o_PC[31:0]),
.Q(PC_Current[31:0])
);

Ext_32(
.imm_16(Inst_R[15:0]),
.imm_32(Imm_32[31:0])
);

//+++++++++++++++++++++++++++++++++++++++++ MUX +++++++++++++++++++++++++++//

mux4to1_5 MUX_Wt_addr(
.sel(RegDst[1:0]),
.a(Inst_R[20:16]),
.b(Inst_R[15:11]),
.c(ra[4:0]),
.d(5'b00000),
.o(mux_Wt_addr[4:0])
);

mux4to1_32 MUX_Wt_data(
.sel(MemtoReg[1:0]),
.a(ALUOut[31:0]),
.b(MDR[31:0]),
.c(lui[31:0]),
.d(PC_Current[31:0]),
.o(mux_Wt_data[31:0])
);

mux2to1_32 MUX_SrcA_out(
.sel(ALUSrcA),
.a(rdata_A[31:0]),
.b(PC_Current[31:0]),
.o(SrcA_out[31:0])
);

mux4to1_32 MUX_SrcB_out(
.sel(ALUSrcB[1:0]),
.a(rdata_B[31:0]),
.b(32'h00004),
.c(Imm_32[31:0]),
.d({Imm_32[29:0],2'b00}),
.o(SrcB_out[31:0])
);

mux2to1_32 MUX_M_addr(
.sel(IorD),
.a(ALUOut[31:0]),
.b(PC_Current[31:0]),
.o(M_addr[31:0])
);

mux4to1_32 MUX_PC_sel(
.sel(PCSource[1:0]),
.a(res[31:0]),
.b(ALUOut[31:0]),
.c({PC_Current[31:28],Inst_R[25:0],2'b00}),
.d(ALUOut[31:0]),
.o(o_PC[31:0])
);

//+++++++++++++++++++++++++++++++++++++++++ MUX +++++++++++++++++++++++++++//

endmodule
