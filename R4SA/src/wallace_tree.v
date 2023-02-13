module wallace_tree
(
   input [18:0] prod0,
   input [19:0] prod1,
   input [19:0] prod2,
   input [19:0] prod3,
   input [19:0] prod4,
   input [19:0] prod5,
   input [19:0] prod6,
   input [19:0] prod7,
   output [31:0] result
);
	wire [31:0] p0,p1,p2,p3,p4,p5,p6,p7;
	assign p0 = {13'b0,prod0};
	assign p1 = {12'b0,prod1};
	assign p2 = {10'b0,prod2,2'b0};
	assign p3 = {8'b0,prod3,4'b0};
	assign p4 = {6'b0,prod4,6'b0};
	assign p5 = {4'b0,prod5,8'b0};
	assign p6 = {2'b0,prod6,10'b0};	
	assign p7 = {prod7,12'b0};
	//level_0
	wire [31:0] S11,C11,S12,C12;
	Compressor_4_2 ucom_1_1(.op0(p0),.op1(p1),.op2(p2),.op3(p3),.S(S11),.C(C11),.cout());
	Compressor_4_2 ucom_1_2(.op0(p4),.op1(p5),.op2(p6),.op3(p7),.S(S12),.C(C12),.cout());	
	//level_1
	wire [31:0] S2,C2;
	Compressor_4_2 ucom_2(.op0(S11),.op1(C11<<1),.op2(S12),.op3(C12<<1),.S(S2),.C(C2),.cout());	
	//level_2
	adder_32bits uadd(.a(S2),.b(C2<<1),.ci(1'b0),.s(result),.co());
	
endmodule