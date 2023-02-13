`include "common.vh"
module MULT_DIR(a,b,result);
parameter n=6;

input  wire  [n-1:0]     a;
input  wire  [n-1:0]     b;
output  wire [2*n-1:0]   result;

assign result = a*b;
endmodule
