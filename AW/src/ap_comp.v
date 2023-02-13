module ap_comp (
    input wire x1,x2,x3,x4,
    output wire s,c
);
    assign c=(x1&x2)|| (x1&x3) || (x1&x4) || (x2&x3)|| (x2&x4);
    assign s=(x1^x2)^(x3 || x4);
    
endmodule