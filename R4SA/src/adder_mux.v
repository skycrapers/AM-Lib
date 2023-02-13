module adder_mux(a,b,ci,s,co);

    input [3:0] a;
    input [3:0] b;
	input ci;
    output [3:0] s;
	output co;
	
	wire c0,c1;
	wire [3:0] s1,s0;
	
	adder_4bits a1(.a(a),.b(b),.ci(1'b1),.s(s1),.co(c1));
	adder_4bits a0(.a(a),.b(b),.ci(1'b0),.s(s0),.co(c0));
	
	assign co = ci & c1 | c0;
	
	mux2 #(.n(4)) m(.ina(s0),.inb(s1),.sel(ci),.outy(s));


endmodule