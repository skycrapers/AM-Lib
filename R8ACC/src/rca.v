//Date		: 2020/05/26
//Author	: zhishangtanxin 
//Function	: 
//read more, please refer to wechat public account "zhishangtanxin"
/* verilator lint_off UNOPTFLAT */
module rca #(parameter width=16) (
    input  [width-1:0] op1,
    input  [width-1:0] op2,
    input  cin,
    output [width-1:0] sum,
    output cout
);

wire [width:0] temp_in;
wire [width:0] temp;
assign temp[0] = cin;
assign cout = temp[width];
assign temp_in=temp;
genvar i;

for( i=0; i<width; i=i+1) begin
    full_adder u_full_adder(
        .a      (   op1[i]     ),
        .b      (   op2[i]     ),
        .cin    (   temp_in[i]    ),
        .cout   (   temp[i+1]  ),
        .s      (   sum[i]     )
    );
    
end

endmodule
