`include "common.vh"
module ENCODER(in,out);
//encoder:n bits(only one bit equals one) --> log_n bits
parameter n=16,log_n = `C_LOG_2(n),k=6;

input  wire [n-1:0] in;
output reg  [log_n-1:0] out;

integer i;
always @(*) 
  begin
    out = k-1; // default value if 'in' is 0
    for (i=n-1; i>k-1; i=i-1)
      if (in[i]) out = i[3:0];
  end
  
endmodule