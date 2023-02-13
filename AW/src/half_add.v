module half_add (
    input wire a,b,
    output wire s,c
);
    assign s = a ^ b;
    assign c = a & b;
endmodule
