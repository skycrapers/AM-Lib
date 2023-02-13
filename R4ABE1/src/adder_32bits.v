module adder_32bits(a,b,ci,s,co);

    input wire [31:0] a;
    input wire [31:0] b;
	input wire ci;
    output wire [31:0] s;
	output wire co;
	
	wire c3,c7,c11,c15,c19,c24,c27;
	
	adder_4bits A0(.a(a[3:0]),.b(b[3:0]),.ci(ci),.s(s[3:0]),.co(c3));
	adder_mux A1(.a(a[7:4]),.b(b[7:4]),.ci(c3),.s(s[7:4]),.co(c7));
	adder_mux A2(.a(a[11:8]),.b(b[11:8]),.ci(c7),.s(s[11:8]),.co(c11));
	adder_mux A3(.a(a[15:12]),.b(b[15:12]),.ci(c11),.s(s[15:12]),.co(c15));
	adder_mux A4(.a(a[19:16]),.b(b[19:16]),.ci(c15),.s(s[19:16]),.co(c19));
	adder_mux A5(.a(a[23:20]),.b(b[23:20]),.ci(c19),.s(s[23:20]),.co(c24));
	adder_mux A6(.a(a[27:24]),.b(b[27:24]),.ci(c24),.s(s[27:24]),.co(c27));
	adder_mux A7(.a(a[31:28]),.b(b[31:28]),.ci(c27),.s(s[31:28]),.co(co));
	
endmodule