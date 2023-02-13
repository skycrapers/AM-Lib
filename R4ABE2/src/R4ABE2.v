module R4ABE2
(
   input  [1:0] a,
   input  [2:0] b,
   output pp
);

	assign pp = b[2] ^ a[1];
	
endmodule