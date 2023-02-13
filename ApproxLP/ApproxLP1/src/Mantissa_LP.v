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
    wire xpy_bt_1 = sum[WIDTH];

    //level 2
    // wire xpy_bt_1_5 = sum[WIDTH] && sum[WIDTH - 1];
    // wire xmy_bt_0_5 = ~diff[WIDTH] && diff[WIDTH - 1];
    // wire xpy_lt_0_5 = ~(sum[WIDTH || sum[WIDTH - 1]]);
    // wire ymx_bt_0_5 = diff[WIDTH] || ~diff[WIDTH - 1];

    //level 0
    wire[BASELINE-(-1) : BASELINE-(WIDTH - 1)] pp_l0_0 = x_bt_y ? {1'b0, mantissa_2} : {1'b0, mantissa_1};
    wire[BASELINE-(-1) : BASELINE-(WIDTH)] pp_l0_1 = x_bt_y ? {2'b01, mantissa_1} : {2'b01, mantissa_2};

    //level 1
    wire[BASELINE-0 : BASELINE-1] pp_l1_0 = xpy_bt_1 ? 2'b11 : 2'b00;
    wire[BASELINE-1 : BASELINE-(WIDTH + 1)] pp_l1_1 = x_bt_y ? (
        xpy_bt_1 ? {1'b0, mantissa_1} : {1'b1, ~mantissa_2}
    ) : (
        xpy_bt_1 ? {1'b0, mantissa_2} : {1'b1, ~mantissa_1}
    );

    //level 2
    // wire[1 : 3] pp_l2_0 = x_bt_y ? (
    //     xpy_bt_1 ? (
    //         xpy_bt_1_5 ? 3'b110 : (
    //             xmy_bt_0_5 ? 3'b010 : 3'b001
    //         )
    //     ) : (
    //         xmy_bt_0_5 ? 3'b000 : (
    //             xpy_lt_0_5 ? 3'b000 : 3'b111
    //         )
    //     )
    // ) : (
    //     xpy_bt_1 ? (
    //         ymx_bt_0_5 ? 3'b010 : (
    //             xpy_bt_1_5 ? 3'b110 : 3'b001
    //         )
    //     ) : (
    //         ymx_bt_0_5 ? 3'b000 : (
    //             xpy_lt_0_5 ? 3'b000 : 3'b111
    //         )
    //     )
    // );

    // wire[2 : WIDTH + 2] pp_l2_1 = x_bt_y ? (
    //     xpy_bt_1 ? (
    //         xpy_bt_1_5 ? {1'b0, mantissa_1} : (
    //             xmy_bt_0_5 ? {1'b1, ~mantissa_1} : {1'b1, ~mantissa_2}
    //         )
    //     ) : (
    //         xmy_bt_0_5 ? {1'b0, mantissa_2} : (
    //             xpy_lt_0_5 ? {1'b1, ~mantissa_2} : {1'b0, mantissa_1}
    //         )
    //     )
    // ) : (
    //     xpy_bt_1 ? (
    //         ymx_bt_0_5 ? {1'b1, ~mantissa_2} : (
    //             xpy_bt_1_5 ? {1'b0, mantissa_2} : {1'b1, ~mantissa_1}
    //         )
    //     ) : (
    //         ymx_bt_0_5 ? {1'b0, mantissa_1} : (
    //             xpy_lt_0_5 ? {1'b1, ~mantissa_1} : {1'b0, mantissa_2}
    //         )
    //     )
    // );

    // wire[-1 : WIDTH - 1] pp_l0_0 
    // wire[-1 : WIDTH] pp_l0_1
    // wire[0 : 1] pp_l1_0

    // wire[1 : WIDTH + 1] pp_l1_1
    wire [BASELINE-(-1) : BASELINE-WIDTH] s_0;
    wire [BASELINE-(-1) : BASELINE-(WIDTH - 1)] s_1;
    wire _s_1;

    CSA3_2_Array #(.WIDTH(WIDTH + 2)) U0(
        .IN_1({pp_l0_0, 1'b0}),
        .IN_2({pp_l0_1}),
        .IN_3({pp_l1_0[BASELINE-0], pp_l1_0, {(WIDTH - 1){1'b0}}}),
        .S(s_0),
        .C({_s_1, s_1})
    );

     wire [BASELINE-(-1) : BASELINE-(WIDTH + 1)] s_2; //BUG?
    wire [BASELINE-(-1) : BASELINE-(WIDTH + 0)] s_3;
    wire _s_3;

    CSA3_2_Array #(.WIDTH(WIDTH + 3)) U1(
        .IN_1({s_0, 1'b0}),
        .IN_2({s_1, 2'b0}),
        .IN_3({{2{pp_l1_1[BASELINE-1]}}, pp_l1_1}),
        .S(s_2),
        .C({_s_3, s_3})
    );

    wire[BASELINE-(-1 ): BASELINE-(WIDTH + 1)] result;
    /* wire no_use, cla;
    CLAdder #(.WIDTH(WIDTH + 5)) Final_Adder(
        .A({s_6, 1'b0}),
        .B({s_7, 2'b0}),
        .C_in(1'b0),
        .S(result),
        .C_out(c_cla)
    ); */
    assign result = s_2 + {s_3, 1'b0};

    assign shift = result[BASELINE-(-1) : BASELINE-0];
    assign mantissa_out = result[BASELINE-(-1)] ? (
        result[BASELINE-0 : BASELINE-(WIDTH - 1)]
    ) : (
        result[BASELINE-(1) : BASELINE-(WIDTH)]//BUG
    );

endmodule

