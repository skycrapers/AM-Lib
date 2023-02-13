module ap_adder (
    input [15:0] y,
    output [31:0] s
);
wire [3:0] cout;
assign s[0]=y[0];
genvar i;
generate
    for(i=1;i<5;i=i+1)begin
    if(i==1)
    ap_adder_u ap_adder_unit(
     .y2(y[i*2]),
     .y1(y[i*2-1]),
     .y0(y[i*2-2]),
     .cin(1'b0),
     .s1(s[i*2-1]),
     .s2(s[i*2]),
     .cout(cout[i-1])
        );
    else  
    ap_adder_u ap_adder_unit(
     .y2(y[i*2]),
     .y1(y[i*2-1]),
     .y0(y[i*2-2]),
     .cin(cout[i-2]),
     .s1(s[i*2-1]),
     .s2(s[i*2]),
     .cout(cout[i-1])
        );
    end
endgenerate
rca #(.width(7)) u_rca(
      .op1(y[14:8]),
      .op2(y[15:9]),
      .cin(cout[3]),
      .sum(s[15:9]),
      .cout(s[16])
);
assign s[31:17]={15{y[15]}} ;
endmodule