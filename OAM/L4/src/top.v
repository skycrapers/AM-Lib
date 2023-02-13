`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 21:52:22
// Design Name: 
// Module Name: FP_Mul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input wire [22 : 0] mantissa_x,
    input wire [22 : 0] mantissa_y,
    input wire sign_x,
    input wire sign_y,
    input wire [7 : 0] exp_x,
    input wire [7 : 0] exp_y,

    output wire [22 : 0] mantissa_out,
    output wire sign_out,
    output wire [7 : 0] exp_out
    );
    
    assign sign_out = sign_x ^ sign_y;

    wire [1 : 0] shift;
    wire [22 : 0] mantissa_out_temp;
    
    //overflow
    wire [9:0] exp_overflow;
    assign exp_overflow = {2'b0,exp_x} + {2'b0,exp_y} + {8'b11100000, shift[1], shift[0] && ~shift[1]};
    Mantissa_OAUM #(
        .MANTISSA_WIDTH(23),
        .ACC_3(4)
    )OAUM(
        .Mantissa_X(mantissa_x),
        .Mantissa_Y(mantissa_y),
        .Mantissa_Out(mantissa_out_temp),
        .Shift(shift)
    );

    wire overflow;
    assign overflow = (~exp_overflow[9] && exp_overflow[8]) || (~exp_overflow[9] && ~exp_overflow[8] && (& exp_overflow[7:0]));
    wire underflow;
    assign underflow = exp_overflow[9] && exp_overflow[8];

    //overflow: [255,383] mantissa all 1; exp = 254
    //underflow: [-127,0] mantissa all 0; exp = 1
    assign mantissa_out = overflow ?  23'h7fffff:(underflow ? 23'd0 : mantissa_out_temp) ;
    assign exp_out = overflow ? 8'hfe : (underflow? 8'h01 : exp_overflow[7:0]);
endmodule

