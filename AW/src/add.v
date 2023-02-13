module add(
    input wire a,b,cin,
	output wire s,cout
);
	assign cout = (a&b)^(a&cin)^(b&cin);
	assign s = a ^ b ^ cin;
endmodule
