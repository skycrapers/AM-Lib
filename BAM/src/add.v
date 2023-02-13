`timescale 1ns / 1ps
module add(
    input   A,
    input   B,
    input   C,
    output  Y,
    output  C1
    );
    
    assign Y=A^B^C;
    assign C1=(A^B)&C|A&B;
    
endmodule
