/* set-one adder */

module SOA_5
#(parameter
    M     = 5
)
(
    input wire [16+3-1-M+1:0] tloga, /* M=5 , [14:0] */
    input wire [16+3-1-M+1:0] tlogb,

    output wire [19:0] sumlog,
    output wire cin_EST /* cin of the EST */
);
    /* adder, has 15 bits */
    wire cin = tloga[0] & tlogb[0];
    
    wire [15:0] A, B, S;
    assign A = {2'b00, tloga[14:1]};
    assign B = {2'b00, tlogb[14:1]};

    MCLA_16_c0_c10 MCLA_16_c0_c10(
        .a(A),
        .b(B),
        .c0(cin),

        .s(S), /* 16 bits */
        .c10(cin_EST)
    );
    assign sumlog[19:M] = S[14:0]; /* 15 bits */

    /* set-one, has 5 bits */
    assign sumlog[M-1:0] = 5'b1_1111;


endmodule
