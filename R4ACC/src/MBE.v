module MBE
(
   input  [1:0] a,
   input  [2:0] b,
   output pp
);

	wire result;
	assign result = ~(((~(a[1]^b[2]))|(~(b[0]^b[1]))) & ((~(a[0]^b[2]))|(~(b[1]^b[2]))|~(b[0]^b[1])));
	
	assign pp = ((b[1]^b[0])&(b[2]^a[1]))|(~(b[1]^b[0])&(b[2]^b[1])&(b[2]^a[0]));
	
endmodule