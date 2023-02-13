`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 20:16:55
// Design Name: 
// Module Name: Mantissa_LP
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


module Mantissa_LP #(
    parameter BASELINE = 23,
    parameter WIDTH = 23
)
(
    input wire[WIDTH - 1 : 0] mantissa_1,
    input wire[WIDTH - 1 : 0] mantissa_2,
    output wire[WIDTH - 1 : 0] mantissa_out,
    output wire[1 : 0] shift
);

    wire[WIDTH : 0] sum, diff;
    /* CLAdder #(.WIDTH(WIDTH + 1)) Sum_Adder(
        .A({1'b0, mantissa_1[WIDTH - 1 : 0]}),
        .B({1'b0, mantissa_2[WIDTH - 1 : 0]}),
        .C_in(1'b0),
        .S(sum[WIDTH : 0]),
        .C_out()
    );

    CLAdder #(.WIDTH(WIDTH + 1)) Diff_Adder(
        .A({1'b0, mantissa_1[WIDTH - 1 : 0]}),
        .B({1'b1, ~mantissa_2[WIDTH - 1 : 0]}),
        .C_in(1'b1),
        .S(diff[WIDTH : 0]),
        .C_out()
    ); */
    assign sum = {1'b0, mantissa_1} + {1'b0, mantissa_2};
    assign diff = {1'b0, mantissa_1} - {1'b0, mantissa_2};
    //level 0
    wire x_bt_y = ~diff[WIDTH];

    //level 1
    // wire xpy_bt_1 = sum[WIDTH];

    //level 2
    // wire xpy_bt_1_5 = sum[WIDTH] && sum[WIDTH - 1];
    // wire xmy_bt_0_5 = ~diff[WIDTH] && diff[WIDTH - 1];
    // wire xpy_lt_0_5 = ~(sum[WIDTH || sum[WIDTH - 1]]);
    // wire ymx_bt_0_5 = diff[WIDTH] || ~diff[WIDTH - 1];

    //level 0
   wire[BASELINE-(-1) : BASELINE-(WIDTH - 1)] pp_l0_0 = x_bt_y ? {1'b0, mantissa_2} : {1'b0, mantissa_1};
    wire[BASELINE-(-1) : BASELINE-(WIDTH)] pp_l0_1 = x_bt_y ? {2'b01, mantissa_1} : {2'b01, mantissa_2};


    wire[BASELINE-(-1) : BASELINE-WIDTH] result;
    /* wire no_use, cla;
    CLAdder #(.WIDTH(WIDTH + 5)) Final_Adder(
        .A({s_6, 1'b0}),
        .B({s_7, 2'b0}),
        .C_in(1'b0),
        .S(result),
        .C_out(c_cla)
    ); */
    assign result = pp_l0_1 + {pp_l0_0, 1'b0};

    assign shift = result[BASELINE-(-1) : BASELINE-0];
    assign mantissa_out = result[BASELINE-(-1)] ? (
        result[BASELINE-0 : BASELINE-(WIDTH - 1)]
    ) : (
        result[BASELINE-1:BASELINE-(WIDTH)]
    );

endmodule

