`timescale 1ns / 1ps
module mul_one(
    input X,
    input Y,
    input Cin,
    input Z,
    output S,
    output Cout
    );
    
    wire xy;
    assign xy=X & Y;
    add u0(xy,Z,Cin,S,Cout);

endmodule
