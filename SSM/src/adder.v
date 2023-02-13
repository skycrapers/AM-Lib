module adder(
    input [1:0] a,
    input [1:0] b,
	input cin,
    output [1:0] sum,
	output cout
    );
	
	wire cout0;
	
	full_adder f1(.a(a[0]),.b(b[0]),.cin(cin),.cout(cout0),.sum(sum[0]));
	full_adder f2(.a(a[1]),.b(b[1]),.cin(cout0),.cout(cout),.sum(sum[1]));

endmodule
