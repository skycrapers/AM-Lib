/* set-one adder */

module SOA
#(parameter
    M     = 11
)
(
    input wire [16+3-1-M+1:0] tloga, /* M=11, [8:0] */
    input wire [16+3-1-M+1:0] tlogb,

    output wire [19:0] sumlog
);
    /* adder, has 9 bits */
    wire cin = tloga[0] & tlogb[0];
    wire c14; /* carry of 14 bit */
    MCLA_4_c_c4 MCLA_4_c_c4 
    (
    .a(tloga[4:1]), 
    .b(tlogb[4:1]),
    .c0(cin),

    .s(sumlog[14:11]), /* 4 bits*/
    .c4(c14)
    );

    MCLA_4_c_c0 MCLA_4_c_c0 (
    .a(tloga[8:5]), 
    .b(tlogb[8:5]),
    .c0(c14),

    .s(sumlog[19:15]) /* 5 bits*/
    );


    /* set-one, has 11 bits */
    assign sumlog[M-1:0] = 11'b111_1111_1111;


endmodule
