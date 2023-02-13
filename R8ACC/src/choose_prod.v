module choose_prod (
    input [15:0] A,
    input neg,
    input f0,
    input f1,
    input f2,
    input f3,
    input f4,
    output [31:0] prod
);
wire [31:0] prod0;
wire [31:0] prod1;
wire [31:0] prod2;
wire [31:0] prod3;
wire [31:0] prod4;
    ac_gen_prod u_ac_gen_prod(
    .A(A),
    .prod0(prod0),
    .prod1(prod1),
    .prod2(prod2),
    .prod3(prod3),
    .prod4(prod4)
  //这里为了wallce tree方便，直接生成了32位的结果
);
    reg [31:0] prod_pre;
   always @(*) 
   begin
     if(f0) prod_pre=prod0;
     else if(f1) prod_pre=prod1;
     else if(f2) prod_pre=prod2;
     else if(f3) prod_pre=prod3;
     else prod_pre=prod4;
  end
    assign prod = neg ?(~prod_pre+1'b1) : prod_pre;


endmodule //choose_prod
