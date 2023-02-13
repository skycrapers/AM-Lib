module ac_comp (
    input wire x1,x2,x3,x4,cin,
    output wire s,cout,c
);
    assign s=x1^x2^x3^x4^cin;
    assign c=(x1^x2^x3^x4)&cin || (!(x1^x2^x3^x4)&x4);
    assign cout=(x1^x2)&x3 || ( !(x1^x2)&x1);
    
endmodule