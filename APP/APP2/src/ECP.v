/* Exact 4-2 Compressor */

module ECP (
    input wire x1, x2, x3, x4,
    input wire cin,
    output wire cout,
    output wire sum,
    output wire carry
);
    wire s;
    assign cout  = (x1 ^ x2) & x3 | x1 & x2;
    assign s     = x1 ^ x2 ^ x3;
    assign sum   = s ^ x4 ^ cin;
    assign carry = (s ^ x4) & cin | s & x4;
    
endmodule