
module MCLA_16_c0_c10
(
    input  wire [15:0] a, 
    input  wire [15:0] b,
    input  wire c0,
    output wire [15:0] s,
    output wire c10  /* output the c10 of the adder, which is 10th carry of the sum */
    /* output wire g, p */
);

    wire g0, g1, g2, g3;
    wire p0, p1, p2, p3;
    wire c1, c2, c3;

    MCLA_4 MCLA_40(.a(a[3 : 0]), .b(b[3 : 0]), .c0(c0), .s(s[3 : 0]), .g(g0), .p(p0));
    MCLA_4 MCLA_41(.a(a[7 : 4]), .b(b[7 : 4]), .c0(c1), .s(s[7 : 4]), .g(g1), .p(p1));
    MCLA_4_c2 MCLA_42(.a(a[11: 8]), .b(b[11: 8]), .c0(c2), .s(s[11: 8]), .g(g2), .p(p2), .c2(c10));
    MCLA_4 MCLA_43(.a(a[15:12]), .b(b[15:12]), .c0(c3), .s(s[15:12]), .g(g3), .p(p3));

    wire g_n0, g_n1, g_n2, g_n3;
    not(g_n0, g0);
    not(g_n1, g1);
    not(g_n2, g2);
    not(g_n3, g3);
    

    wire cp1, cpp2, cppp3, cpppp4;
    wire gp2, gp3, gp4;
    wire gpp3, gpp4;
    wire gppp4;
    /* c1 */
    nand(cp1, c0, p0);
    nand(c1, g_n0, cp1);
    /* c2 */
    nand(gp2, g0, p1);
    nand(cpp2, c0, p0, p1);
    nand(c2, g_n1, cpp2, gp2);
    /* c3 */
    nand(gp3, g1, p2);
    nand(gpp3, g0, p1, p2);
    nand(cppp3, c0, p0, p1, p2);
    nand(c3, g_n2, cppp3, gpp3, gp3);
    /* c4 */
    /*
    nand(gp4, g2, p3);
    nand(gpp4, g1, p2, p3);
    nand(gppp4, g0, p1, p2, p3);
    nand(cpppp4, c0, p0, p1, p2, p3);
    nand(c4, g_n3, cpppp4, gppp4, gpp4, gp4);
    */
    /* g, p */
    // nand(gp4, g2, p3);
    // nand(gpp4, g1, p2, p3);
    // nand(gppp4, g0, p1, p2, p3);
    // nand(cpppp4, c0, p0, p1, p2, p3);
    
    // nand(g, g_n3, gppp4, gpp4, gp4);
    // and(p, p0, p1, p2, p3);
    
endmodule