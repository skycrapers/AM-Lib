module R4ABE1
(
   input  [1:0] a,
   input  [2:0] b,
   output pp
);

	assign pp = (b[1]^b[0])&(b[2]^a[1]);
	
endmodule