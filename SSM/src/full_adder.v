module full_adder(
    input a,
    input b,
	input cin,
	output cout,
    output sum
    );

//	wire t1,t2,t3;
//	wire s;

//	xor(s,a,b);
//	xor(sum,s,cin);
//	and (t3,a,b);
//	and (t2,b,cin);
//	and (t1,a,cin);
//	or (cout,t1,t2,t3);
	assign sum = a ^ b ^ cin;
	assign cout = a & b | (cin&(a^b));
endmodule
