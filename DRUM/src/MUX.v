`include "common.vh"
module MUX(in,lod_en,out);
//selecting k bits out of n-bit original number
parameter n=16,k=6,log_n = `C_LOG_2(n);

input  wire [n-1:0]     in;
input  wire [log_n-1:0] lod_en;
output reg  [k-1:0]     out;

always @(*)
  begin
    if(lod_en > k-1)
	  out = {in[lod_en-:(k-1)],1'b1};
	else
	  out = in[k-1:0];
  end

endmodule