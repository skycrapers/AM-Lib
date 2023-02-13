
module MCLA_4 (
    input  wire [3:0] a, 
    input  wire [3:0] b,
    input  wire c0,
    output wire [3:0] s,
    output wire g, p
);
    wire g_n0, g_n1, g_n2, g_n3;
    wire p0, p1, p2, p3;
    wire c1, c2, c3;

    MPFA MPFA0(.a(a[0]), .b(b[0]), .c(c0), .s(s[0]), .g_n(g_n0), .p(p0));
    MPFA MPFA1(.a(a[1]), .b(b[1]), .c(c1), .s(s[1]), .g_n(g_n1), .p(p1));
    MPFA MPFA2(.a(a[2]), .b(b[2]), .c(c2), .s(s[2]), .g_n(g_n2), .p(p2));
    MPFA MPFA3(.a(a[3]), .b(b[3]), .c(c3), .s(s[3]), .g_n(g_n3), .p(p3));
    
    wire g0, g1, g2, g3;
    not(g0, g_n0);
    not(g1, g_n1);
    not(g2, g_n2);
    not(g3, g_n3);
    

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
    nand(gp4, g2, p3);
    nand(gpp4, g1, p2, p3);
    nand(gppp4, g0, p1, p2, p3);
    nand(cpppp4, c0, p0, p1, p2, p3);
    
    nand(g, g_n3, gppp4, gpp4, gp4);
    and(p, p0, p1, p2, p3);



endmodule