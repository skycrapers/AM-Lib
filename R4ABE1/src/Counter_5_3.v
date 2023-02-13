module Counter_5_3
(
   input  wire x0,
   input  wire x1,
   input  wire x2,
   input  wire x3,   
   input  wire cin,
   output wire cout,
   output wire carry,
   output wire sum
);

//	assign cout = (x3&x2)|(x2&x1)|(x3&x1);
	assign cout = ((x0^x1)&x2)|(~(x0^x1)&x0);
	assign sum = x3^x2^x1^x0^cin;
//	assign carry = (x0&~(x3^x2^x1^x0))||(cin&(x3^x2^x1^x0));
	assign carry = ((x0^x1^x2^x3)&cin) | ((~(x0^x1^x2^x3))& x3);
	
endmodule