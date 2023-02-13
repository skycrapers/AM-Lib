
module BARREL_SHIFTER(approx,encode_sum,result);
//encoder:n bits(only one bit equals one) --> log_n bits
parameter n=12,k=6,shift_n = 5,result_n=32;

input  wire [n-1:0] approx;
input  wire [shift_n-1:0] encode_sum;
output wire [result_n-1:0] result;

assign result={16'd0,approx}<<(encode_sum-2*k+2);
  
endmodule