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

    wire[WIDTH : 0] sum, diff,diff_yx;
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

    assign diff_yx = {1'b0, mantissa_2} - {1'b0, mantissa_1};
    //level 0
    wire x_bt_y = ~diff[WIDTH];//1: x>=y; 0: x<y

    //level 1
    wire xpy_bt_1 = sum[WIDTH];//1: x+y >=1; 0:x+y<1

    //level 2
    wire xpy_bt_1_5 = sum[WIDTH] && sum[WIDTH - 1];
    wire xmy_bt_0_5 = ~diff[WIDTH] && diff[WIDTH - 1];
    wire xpy_lt_0_5 = ~(sum[WIDTH] || sum[WIDTH - 1]);
    // wire ymx_bt_0_5 = diff[WIDTH] || ~diff[WIDTH - 1];//BUG
    wire ymx_bt_0_5 = ~diff_yx[WIDTH] && diff_yx[WIDTH - 1];

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
    wire[BASELINE-1 : BASELINE-3] pp_l2_0 = x_bt_y ? (
        xpy_bt_1 ? (
            xpy_bt_1_5 ? 3'b110 : (
                xmy_bt_0_5 ? 3'b010 : 3'b001
            )
        ) : (
            xmy_bt_0_5 ? 3'b000 : (
                xpy_lt_0_5 ? 3'b000 : 3'b111
            )
        )
    ) : (
        xpy_bt_1 ? (
            ymx_bt_0_5 ? 3'b010 : (
                xpy_bt_1_5 ? 3'b110 : 3'b001
            )
        ) : (
            ymx_bt_0_5 ? 3'b000 : (
                xpy_lt_0_5 ? 3'b000 : 3'b111
            )
        )
    );

    wire[BASELINE-2 : BASELINE-(WIDTH + 2)] pp_l2_1 = x_bt_y ? (
        xpy_bt_1 ? (
            xpy_bt_1_5 ? {1'b0, mantissa_1} : (
                xmy_bt_0_5 ? {1'b1, ~mantissa_1} : {1'b1, ~mantissa_2}
            )
        ) : (
            xmy_bt_0_5 ? {1'b0, mantissa_2} : (
                xpy_lt_0_5 ? {1'b1, ~mantissa_2} : {1'b0, mantissa_1}
            )
        )
    ) : (
        xpy_bt_1 ? (
            ymx_bt_0_5 ? {1'b1, ~mantissa_2} : (
                xpy_bt_1_5 ? {1'b0, mantissa_2} : {1'b1, ~mantissa_1}
            )
        ) : (
            ymx_bt_0_5 ? {1'b0, mantissa_1} : (
                xpy_lt_0_5 ? {1'b1, ~mantissa_1} : {1'b0, mantissa_2}
            )
        )
    );

    // wire[-1 : WIDTH - 1] pp_l0_0 
    // wire[-1 : WIDTH] pp_l0_1
    // wire[0 : 1] pp_l1_0

    // wire[1 : WIDTH + 1] pp_l1_1
    // wire[1 : 3] pp_l2_0
    // wire[2 : WIDTH + 2] pp_l2_1
    wire [BASELINE-(-1) : BASELINE-WIDTH] s_0;
    wire [BASELINE-(-1) : BASELINE-(WIDTH - 1)] s_1;
    wire _s_1;

    //level0:2y x+1 level1:-0.5
    CSA3_2_Array #(.WIDTH(WIDTH + 2)) U0(
        .IN_1({pp_l0_0, 1'b0}),
        .IN_2({pp_l0_1}),
        .IN_3({pp_l1_0[BASELINE-0], pp_l1_0, {(WIDTH - 1){1'b0}}}),
        .S(s_0),
        .C({_s_1, s_1})
    );

    wire [BASELINE-1 : BASELINE-(WIDTH + 2)] s_2;
    wire [BASELINE-0 : BASELINE-(WIDTH + 1)] s_3;
    // //level1:0.5x  level2:const   -0.25y 
    //Original U1!!
    CSA3_2_Array #(.WIDTH(WIDTH + 2)) U1(
        .IN_1({pp_l1_1, 1'b0}),//TODO: BUG *0.5
        .IN_2({pp_l2_0, {(WIDTH - 1){1'b0}}}),//BUG ?
        .IN_3({pp_l2_1[BASELINE-2], pp_l2_1}),//?
        .S(s_2),
        .C(s_3)
    );
    
//    CSA3_2_Array #(.WIDTH(WIDTH + 2)) U1(
//         .IN_1({ {(2){pp_l1_1[BASELINE-1]}}, pp_l1_1[BASELINE-1 -: WIDTH]  }),//pp_l1_1 from 22
//         .IN_2({ {(2){pp_l2_0[BASELINE-1]}}, pp_l2_0, {(WIDTH - 3){1'b0}} }),//pp_l2_0 from 22
//         .IN_3({ {(3){pp_l2_1[BASELINE-2]}}, pp_l2_1[BASELINE-2 -: (WIDTH-1)] }),//* 0.25 realized through bit index
//         .S(s_2),
//         .C(s_3)
//     );
    // wire [-1 : WIDTH] s_0;
    // wire [-1 : WIDTH + 2] s_4;
    // wire [-1 : WIDTH + 1] s_5;

    // wire [-1 : WIDTH - 1] s_1;
    // wire [1 : WIDTH + 2] s_2;
    // wire [0 : WIDTH + 1] s_3;

    wire [BASELINE-(-1) : BASELINE-(WIDTH + 2)] s_4;
    wire [BASELINE-(-1) : BASELINE-(WIDTH + 1)] s_5;
    wire _s_5;
    CSA3_2_Array #(.WIDTH(WIDTH + 4)) U2(
        .IN_1({s_1, 3'b0}),
        .IN_2({{2{s_2[BASELINE-1]}}, s_2}),
        .IN_3({s_3[BASELINE-0], s_3, 1'b0}),
        .S(s_4),
        .C({_s_5, s_5})
    );

    wire [BASELINE-(-1) : BASELINE-(WIDTH + 2)] s_6;
    wire [BASELINE-(-1) : BASELINE-(WIDTH + 1)] s_7;
    wire _s_7;

    CSA3_2_Array #(.WIDTH(WIDTH + 4)) U3(
        .IN_1({s_0, 2'b0}),
        .IN_2(s_4),
        .IN_3({s_5, 1'b0}),
        .S(s_6),
        .C({_s_7, s_7})
    );

    wire[BASELINE-(-1) : BASELINE-(WIDTH + 2)] result;
    /* wire no_use, cla;
    CLAdder #(.WIDTH(WIDTH + 5)) Final_Adder(
        .A({s_6, 1'b0}),
        .B({s_7, 2'b0}),
        .C_in(1'b0),
        .S(result),
        .C_out(c_cla)
    ); */
    assign result = s_6 + {s_7, 1'b0};

    assign shift = result[BASELINE-(-1) : BASELINE-0];
    assign mantissa_out = result[BASELINE-(-1)] ? (
        result[BASELINE-0 : BASELINE-(WIDTH - 1)]
    ) : (
        // result[BASELINE-0]? result[BASELINE-1:BASELINE-(WIDTH)]:
        // result[BASELINE-(2) : BASELINE-(WIDTH + 1)]
        result[BASELINE-1:BASELINE-(WIDTH)]
    );


// assign Mantissa_Out[BASELINE-1 : BASELINE-MANTISSA_WIDTH] = final_sum[BASELINE-(-1)] ? final_sum[BASELINE-0 : BASELINE-(MANTISSA_WIDTH - 1)] : 
//                                               (final_sum[BASELINE-0] ? final_sum[BASELINE-1 : BASELINE-MANTISSA_WIDTH] : final_sum[BASELINE-2 : BASELINE-(MANTISSA_WIDTH + 1)]);
//     assign Shift = final_sum[BASELINE-(-1) : BASELINE-0];//用于归一化的移位？
endmodule

