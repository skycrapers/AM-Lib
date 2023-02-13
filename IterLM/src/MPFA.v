/* metamorphosis of partial full adder */
module MPFA 
(
    input  wire a,
    input  wire b,
    input  wire c,
    output wire s,
    output wire g_n,
    output wire p

);

    xor (p  , a, b);
    nand(g_n, a, b);
    xor (s  , p, c);


endmodule
