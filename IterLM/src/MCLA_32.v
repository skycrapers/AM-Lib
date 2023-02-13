
module MCLA_32
(
    input  wire [31:0] a, 
    input  wire [31:0] b,
    /* input  wire c0, */
    output wire [31:0] s
    /* output wire g, p */
);

    wire g0, g1;
    wire p0, p1;
    wire c0, c1;

    MCLA_16 MCLA_160(.a(a[15 :0]), .b(b[15 :0]), .c0(c0), .s(s[15 :0]), .g(g0), .p(p0));
    MCLA_16 MCLA_161(.a(a[31:16]), .b(b[31:16]), .c0(c1), .s(s[31:16]), .g(g1), .p(p1));
    
    assign c0 = 0;
    assign c1 = g0;
    // wire g_n0;
    // not(g_n0, g0);

    // wire cp1;
    // /* c1 */
    // nand(cp1, c0, p0);
    // nand(c1, g_n0, cp1);

    
endmodule