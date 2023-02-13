module LOD(in,out);
//leading one detector
parameter n=16;//length
input  [n-1:0] in;
output [n-1:0] out;


genvar i;
generate
	wire [n-1:0] in_r;
    for (i=0; i<n; i=i+1) begin: ReverseIn
        assign in_r[i] = in[n-1-i];
    end
endgenerate

wire [n-1:0] in_r_change;
wire [n-1:0] out_r;
assign in_r_change  = (~in_r) + 1;
assign out_r = in_r & in_r_change;

genvar j;
generate
    for (j=0; j<n; j=j+1) begin: ReverseResult
        assign out[j] = out_r[n-1-j];
    end
endgenerate

endmodule