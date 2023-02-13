module ap_gen_prod (
    input [15:0] A,
    output [31:0] prod0,
    output [31:0] prod1,
    output [31:0] prod2,
    output [31:0] prod3,
    output [31:0] prod4
    //这里为了wallce tree方便，直接生成了32位的结果
);

    assign prod0 = 32'd0;
    assign prod1 = {{16{A[15]}},A};
    assign prod2 = {{15{A[15]}},A,1'b0};
    ap_adder ap_adder1 (.y (A),.s (prod3));
    assign prod4 = {{14{A[15]}},A,2'b00};

endmodule
