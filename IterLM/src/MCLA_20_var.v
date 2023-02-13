/* input 20 bits(actually '0' + 19 bits), output 20bits, so call MCLA_20_var */
module MCLA_20_var
(
    input  wire [19:0] a, 
    input  wire [19:0] b,
    /* input  wire c0, */
    output wire [19:0] s
    /* output wire g, p */
);

    wire g0, g1, g2, g3, g4;
    wire p0, p1, p2, p3, p4;
    wire c0, c1, c2, c3, c4;


    MCLA_4 MCLA_40(.a(a[3 : 0]), .b(b[3 : 0]), .c0(c0), .s(s[3 : 0]), .g(g0), .p(p0));
    MCLA_4 MCLA_41(.a(a[7 : 4]), .b(b[7 : 4]), .c0(c1), .s(s[7 : 4]), .g(g1), .p(p1));
    MCLA_4 MCLA_42(.a(a[11: 8]), .b(b[11: 8]), .c0(c2), .s(s[11: 8]), .g(g2), .p(p2));
    MCLA_4 MCLA_43(.a(a[15:12]), .b(b[15:12]), .c0(c3), .s(s[15:12]), .g(g3), .p(p3));
    MCLA_4 MCLA_44(.a(a[19:16]), .b(b[19:16]), .c0(c4), .s(s[19:16]), .g(g4), .p(p4));

    wire g_n0, g_n1, g_n2, g_n3;
    not(g_n0, g0);
    not(g_n1, g1);
    not(g_n2, g2);
    not(g_n3, g3);


    wire cp1, cpp2, cppp3, cpppp4;
    wire gp2, gp3, gp4;
    wire gpp3, gpp4;
    wire gppp4;

    assign c0 = 0;
    assign cp1 = 1;
    assign cpp2 = 1;
    assign cppp3 = 1;
    assign cpppp4 = 1;

    /* c1 */
    //nand(cp1, c0, p0);
    nand(c1, g_n0, cp1);
    /* c2 */
    nand(gp2, g0, p1);
    //nand(cpp2, c0, p0, p1);
    nand(c2, g_n1, cpp2, gp2);
    /* c3 */
    nand(gp3, g1, p2);
    nand(gpp3, g0, p1, p2);
    //nand(cppp3, c0, p0, p1, p2);
    nand(c3, g_n2, cppp3, gpp3, gp3);
    /* c4 */
    
    nand(gp4, g2, p3);
    nand(gpp4, g1, p2, p3);
    nand(gppp4, g0, p1, p2, p3);
    //nand(cpppp4, c0, p0, p1, p2, p3);
    nand(c4, g_n3, cpppp4, gppp4, gpp4, gp4);
    
    /* g, p */
    /*
    nand(gp4, g2, p3);
    nand(gpp4, g1, p2, p3);
    nand(gppp4, g0, p1, p2, p3);
    nand(cpppp4, c0, p0, p1, p2, p3);
    
    nand(g, g_n3, gppp4, gpp4, gp4);
    and(p, p0, p1, p2, p3);
    */

endmodule