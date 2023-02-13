/* Approximate 4-2 Compressor */

module ACP (
    input  x1, x2, x3, x4,
    output sum, cout
);
    wire   w1, w2;

    assign w1 = x1 & x2;
    assign w2 = x3 & x4;
    assign sum = (x1 ^ x2) | (x3 ^ x4) | w1 & w2;
    assign cout = w1 | w2;
    
endmodule