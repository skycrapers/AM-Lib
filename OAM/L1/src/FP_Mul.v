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


module FP_Mul(
    input wire [31 : 0] X_Input,
    input wire [31 : 0] Y_Input,
    output wire [31 : 0] Result
    );
    //rename wires
    wire [22 : 0] mantissa_x;
    wire [22 : 0] mantissa_y;
    
    wire [22 : 0] mantissa_out;
    wire [1 : 0] shift;
    wire sign_x, sign_y;
    wire [7 : 0] exp_out;
    wire [7 : 0] exp_x;
    wire [7 : 0] exp_y;

    assign mantissa_x[22 : 0] = X_Input[22 : 0];
    assign mantissa_y[22 : 0] = Y_Input[22 : 0];
    assign exp_x[7 : 0] = X_Input[30 : 23];
    assign exp_y[7 : 0] = Y_Input[30 : 23];
    assign sign_x = X_Input[31];
    assign sign_y = Y_Input[31];
    // ctrl <= ACC_Ctrl;
    assign Result = {sign_x ^ sign_y, exp_out, mantissa_out};

    assign exp_out = exp_x + exp_y + {6'b100000, shift[1], shift[0] && ~shift[1]};
    Mantissa_OAUM #(
        .MANTISSA_WIDTH(23),
        // .ACC_1(0),
        // .ACC_2(4),
        .ACC_3(1)
    )OAUM(
        .Mantissa_X(mantissa_x),
        .Mantissa_Y(mantissa_y),
        // .ACC_Ctrl(ctrl),
        .Mantissa_Out(mantissa_out),
        .Shift(shift)
    );

endmodule

