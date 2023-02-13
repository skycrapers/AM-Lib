`timescale 1ns / 1ps
module mux (
    input sel,
    input [3:0] a,
    input [3:0] b,
    output [3:0] s
);
    reg [3:0] SR;
    always @(sel or a or b)
    begin
        if(sel == 1'b0)
        SR=a;
        else
        SR=b;
    end
    assign s=SR;
endmodule
