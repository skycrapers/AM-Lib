module csa #(parameter width=16) (
	input [width-1:0] op1,
	input [width-1:0] op2,
	input [width-1:0] op3,
	output [width-1:0] S,
	output [width-1:0] C
);

genvar i;
generate
	for(i=0; i<width; i=i+1) begin:gen_csa
		full_adder u_full_adder(
			.a      (   op1[i]    ),
			.b      (   op2[i]    ),
			.cin    (   op3[i]    ),
			.cout   (   C[i]	  ),
			.s      (   S[i]      )
		);
	end
endgenerate

endmodule
