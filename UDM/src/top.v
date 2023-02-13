module top(
input wire [15:0] a,
input wire [15:0] b,
output wire [31:0] result
);

ApproxMult #(.n(16)) test(.a(a),.b(b),.result(result));
endmodule
