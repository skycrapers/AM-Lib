module ADDER(a,b,cin,result);
parameter n=4;
input  [n-1:0] a;
input  [n-1:0] b;
input          cin;
output [n : 0] result;

wire [n:0] c/*verilator split_var*/;
assign c[0]=cin;

genvar i;
generate
  for(i=0;i<n;i=i+1)
    begin:generate_adder
	  add_onebit add0(.a(a[i]),.b(b[i]),.ci(c[i]),.sum(result[i]),.co(c[i+1]));
	    //FA add0(.a(a[i]),.b(b[i]),.cin(c[i]),.sum(result[i]),.carry(c[i+1]));
	end
endgenerate

assign result[n]=c[n];

endmodule



