module compression_3_2 (
    a,b,c,co,s
);
parameter n=16 ;// n 代表a，b，c采用k bit
parameter diffba=16 ;//diffba 表示输出的a，b之间位移量
parameter diffca=16 ;//diffba 表示输出的a，c之间位移量
input wire [n-1 :0] a;
input wire [n-1 :0] b;
input wire [n-1 :0] c;
output wire [n-1:0] s;
output wire [n-1:0] co;
genvar i;
generate
 for (i=0;i<n;i=i+1)begin : adder_gen
     full_adder adder(.a(a[i]),.b(b[i]),.s(s[i]),.ci(c[i]),.co(co[i]));
 end
 endgenerate

endmodule //3_2_compression