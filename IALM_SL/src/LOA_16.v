/* lower-part-or adder */
module LOA_16
#(parameter
    M     = 16
)
(
    input wire [31:0] a, 
    input wire [31:0] b,

    output wire [31:0] s
);

    genvar i; 
    generate
        for(i=0;i<M;i=i+1)
        begin:gen_bit
            assign s[i] = a[i] | b[i];
        end
    endgenerate

    wire cM;
    assign cM = a[M-1] & b[M-1];

    MCLA_16_c0 MCLA_16_c0
    (
    .a(a[31:16]), 
    .b(b[31:16]),
    .c0(cM),

    .s(s[31:16])
    );

    
endmodule
