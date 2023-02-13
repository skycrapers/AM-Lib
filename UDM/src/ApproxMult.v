//这个结构实现2x2的近似计算
module ApproxMult (a,b,result);
parameter n=16;
input  wire [n-1 :0] a;
input  wire [n-1 :0] b;
output wire [2*n-1 :0] result;
//这里按照所给出的卡诺图所写的第一步近似计算电路
generate
if(n == 2) begin
assign result[3]=0;
and(result[2],a[1],b[1]);
assign result[1]=(b[0]&a[1])|(b[1]&a[0]);
and(result[0],b[0],a[0]);
end 
else begin
//通过不断迭代同一个结构实现位数的配置
wire [n/2-1 :0] AH;
wire [n/2-1 :0] AL;
wire [n/2-1 :0] BH;
wire [n/2-1 :0] BL;
wire [n-1 :0] result_ALBL;
wire [n-1 :0] result_AHBL;
wire [n-1 :0] result_ALBH;
wire [n-1 :0] result_AHBH;
// 对AH,AL,BH,BL进行赋值
assign AH=a[n-1 :n/2];
assign AL=a[n/2-1 :0];
assign BH=b[n-1 :n/2];
assign BL=b[n/2-1 :0];
ApproxMult #(.n(n/2) )ALBL(.a(AL),.b(BL),.result(result_ALBL));
ApproxMult #(.n(n/2) )AHBL(.a(AH),.b(BL),.result(result_AHBL));
ApproxMult #(.n(n/2) )ALBH(.a(AL),.b(BH),.result(result_ALBH));
ApproxMult #(.n(n/2) )AHBH(.a(AH),.b(BH),.result(result_AHBH));
//这一行可以采用wallce tree的形式进行改写
//==================================================================================
//                               wallce tree
//===================================================================================
// wire [n*3/2-1 :0] co1;
// wire [n*3/2-1 :0] s1;
//  wire [2*n-1 :0] co2;
//  wire [2*n-1 :0] s2;
// compression_3_2 #(.n(n*3/2)) compression_3_2_1(.a({{(n/2){1'b0}},result_ALBL}),.b({result_AHBL,{(n/2){1'b0}}}),.c({result_ALBH,{(n/2){1'b0}}}),.co(co1),.s(s1));
// compression_3_2 #(.n(2*n))  compression_3_2_2(.a({{(n-1){1'b0}},co1,1'b0}),.b({{n{1'b0}},s1}),.c({result_AHBH,{n{1'b0}}}),.co(co2),.s(s2));
assign result = {{n{1'b0}},result_ALBL}+{{n/2{1'b0}},result_AHBL,{n/2{1'b0}}}+{{n/2{1'b0}},result_ALBH,{n/2{1'b0}}}+{result_AHBH,{n{1'b0}}};
// assign result=co2*2+s2;
end
endgenerate
endmodule
