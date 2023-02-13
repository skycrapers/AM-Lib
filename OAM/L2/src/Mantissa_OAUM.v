`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/25 12:23:23
// Design Name: 
// Module Name: Mantissa_OAUM
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


module Mantissa_OAUM #(
    parameter BASELINE = 15,
    parameter MANTISSA_WIDTH = 15,
    parameter log_n = 4,
    parameter ACC_3 = 2
)
(
    input wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] Mantissa_X,
    input wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] Mantissa_Y,
    // input wire [log_n:0] lod_a_en,
    // input wire [log_n:0] lod_b_en,
    // input wire[1 : 0] ACC_Ctrl,
    output wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] Mantissa_Out,
    output wire[1 : 0] Shift
    // output wire[2*BASELINE+1 : 0] result
);
    function integer PP_Length(input integer Level_n);
    begin
        PP_Length = (MANTISSA_WIDTH + 1) * Level_n - (1 + Level_n) * Level_n / 2;
    end
    endfunction

    wire [BASELINE-1 : BASELINE-2 * (ACC_3 + 1)] const_cn;
    Constant_Generator #(
        .ACC_3(ACC_3)
    )CG(
        // .Enable(ACC_Ctrl),
        .Const(const_cn)
    );

    wire[BASELINE-0 : BASELINE-(PP_Length(ACC_3) - 1)] Partial_Product_X/* verilator lint_off LITENDIAN */;
    wire[BASELINE-0 : BASELINE-(PP_Length(ACC_3) - 1)] Partial_Product_Y/* verilator lint_off LITENDIAN */;
    Partial_Product_Generator #(
        .BASELINE(BASELINE),
        .MANTISSA_WIDTH(MANTISSA_WIDTH),
        .MAX_LEVEL(ACC_3)
    )PGEN(
        .Mantissa_X(Mantissa_X),
        .Mantissa_Y(Mantissa_Y),
        .Partial_Product_X(Partial_Product_X),
        .Partial_Product_Y(Partial_Product_Y)
    );

    //stage 0
    wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] pp_0_x_0 = Mantissa_X[BASELINE-1 : BASELINE-MANTISSA_WIDTH];
    wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] pp_0_y_0 = Mantissa_Y[BASELINE-1 : BASELINE-MANTISSA_WIDTH];
    wire[BASELINE-2 : BASELINE-(MANTISSA_WIDTH + 1)] pp_0_x_1 = Mantissa_X[BASELINE-1 : BASELINE-MANTISSA_WIDTH];
    
    wire[BASELINE-2 : BASELINE-(MANTISSA_WIDTH + 1)] pp_0_y_1 = Mantissa_Y[BASELINE-1 : BASELINE-MANTISSA_WIDTH];
    wire[BASELINE-1 : BASELINE-2 * (ACC_3 + 1)] pp_0_c = const_cn[BASELINE-1 : BASELINE-2 * (ACC_3 + 1)];          // 2 * (ACC_3 + 1) <= MANTISSA_WIDTH + 1
    wire[BASELINE-3 : BASELINE-(MANTISSA_WIDTH + 2)] pp_1_x = Partial_Product_X[BASELINE-PP_Length(0) : BASELINE-(PP_Length(1) - 1)];
    
    wire[BASELINE-3 : BASELINE-(MANTISSA_WIDTH + 2)] pp_1_y = Partial_Product_Y[BASELINE-PP_Length(0) : BASELINE-(PP_Length(1) - 1)];
    wire[BASELINE-5 : BASELINE-(MANTISSA_WIDTH + 3)] pp_2_x = Partial_Product_X[BASELINE-PP_Length(1) : BASELINE-(PP_Length(2) - 1)];
    wire[BASELINE-5 : BASELINE-(MANTISSA_WIDTH + 3)] pp_2_y = Partial_Product_Y[BASELINE-PP_Length(1) : BASELINE-(PP_Length(2) - 1)];
    


    wire[BASELINE-1 : BASELINE-(MANTISSA_WIDTH + 1)] s_1_0;
    wire[BASELINE-0 : BASELINE-(MANTISSA_WIDTH)] s_1_1;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 1)
    )Stage_0_0
    (
        .In_1({pp_0_x_0[BASELINE-1 : BASELINE-MANTISSA_WIDTH], 1'b0}),
        .In_2({pp_0_y_0[BASELINE-1 : BASELINE-MANTISSA_WIDTH], 1'b0}),
        .In_3({1'b0, pp_0_x_1[BASELINE-2 : BASELINE-(MANTISSA_WIDTH + 1)]}),
        .S(s_1_0),
        .C(s_1_1)
    );

    wire[BASELINE-1 : BASELINE-(MANTISSA_WIDTH + 2)] s_1_2;
    wire[BASELINE-0 : BASELINE-(MANTISSA_WIDTH + 1)] s_1_3;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 2)
    )Stage_0_1
    (
        .In_1({1'b0, pp_0_y_1, 1'b0}),
        .In_2({pp_0_c, {(MANTISSA_WIDTH - 2 * ACC_3){1'b0}}}),
        .In_3({2'b0, pp_1_x}),
        .S(s_1_2),
        .C(s_1_3)
    );

    wire[BASELINE-3 : BASELINE-(MANTISSA_WIDTH + 3)] s_1_4;
    wire[BASELINE-2 : BASELINE-(MANTISSA_WIDTH + 2)] s_1_5;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 1)
    )Stage_0_2
    (
        .In_1({pp_1_y, 1'b0}),
        .In_2({2'b0, pp_2_x}),
        .In_3({2'b0, pp_2_y}),
        .S(s_1_4),
        .C(s_1_5)
    );


    wire[BASELINE-0 : BASELINE-(MANTISSA_WIDTH + 2)] s_2_0;
    wire[BASELINE-(-1 ): BASELINE-(MANTISSA_WIDTH + 1)] s_2_1;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 3)
    )Stage_1_0
    (
        .In_1({1'b0, s_1_0, 1'b0}),
        .In_2({s_1_1, 2'b0}),
        .In_3({1'b0, s_1_2}),
        .S(s_2_0),
        .C(s_2_1)
    );

    wire[BASELINE-0 : BASELINE-(MANTISSA_WIDTH + 3)] s_2_2;
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 2)] s_2_3;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 4)
    )Stage_1_1
    (
        .In_1({s_1_3, 2'b0}),
        .In_2({3'b0, s_1_4}),
        .In_3({2'b0, s_1_5, 1'b0}),
        .S(s_2_2),
        .C(s_2_3)
    );

    // wire[6 : MANTISSA_WIDTH + 6] s_2_4;
    // wire[5 : MANTISSA_WIDTH + 5] s_2_5;

    // CSA3_2_Array #(
    //     .WIDTH(MANTISSA_WIDTH + 1)
    // )Stage_1_2
    // (
    //     .In_1({1'b0, s_1_6, 1'b0}),
    //     .In_2({s_1_7, 2'b0}),
    //     .In_3({3'b0, s_1_8}),
    //     .S(s_2_4),
    //     .C(s_2_5)
    // );

    // wire[8 : MANTISSA_WIDTH + 7] s_2_6;
    // wire[7 : MANTISSA_WIDTH + 6] s_2_7;

    // CSA3_2_Array #(
    //     .WIDTH(MANTISSA_WIDTH + 1)
    // )Stage_1_3
    // (
    //     .In_1({s_1_9, 2'b0}),
    //     .In_2({5'b0, s_1_10}),
    //     .In_3({5'b0, s_1_11}),
    //     .S(s_2_6),
    //     .C(s_2_7)
    // );

    // wire[14 : MANTISSA_WIDTH + 11] s_2_8;
    // wire[13 : MANTISSA_WIDTH + 10] s_2_9;

    // CSA3_2_Array #(
    //     .WIDTH(MANTISSA_WIDTH - 2)
    // )Stage_1_4
    // (
    //     .In_1({1'b0, s_1_12, 2'b0}),
    //     .In_2({s_1_13, 3'b0}),
    //     .In_3({5'b0, s_1_14}),
    //     .S(s_2_8),
    //     .C(s_2_9)
    // );

    // wire[18 : MANTISSA_WIDTH + 12] s_2_10;
    // wire[17 : MANTISSA_WIDTH + 11] s_2_11;

    // CSA3_2_Array #(
    //     .WIDTH(MANTISSA_WIDTH - 5)
    // )Stage_1_5
    // (
    //     .In_1({s_1_15, 2'b0}),
    //     .In_2({3'b0, s_1_16}),
    //     .In_3({2'b0, s_1_17, 1'b0}),
    //     .S(s_2_10),
    //     .C(s_2_11)
    // );

    //Stage 2
    // wire[0 : MANTISSA_WIDTH + 2] s_2_0;
    // wire[-1 : MANTISSA_WIDTH + 1] s_2_1;
    // wire[0 : MANTISSA_WIDTH + 3] s_2_2;

    // wire[-1 : MANTISSA_WIDTH + 2] s_2_3;

    // wire[6 : MANTISSA_WIDTH + 6] s_2_4;
    // wire[5 : MANTISSA_WIDTH + 5] s_2_5;
    // wire[8 : MANTISSA_WIDTH + 7] s_2_6;

    // wire[7 : MANTISSA_WIDTH + 6] s_2_7;



    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 3)] s_3_0;
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 2)] s_3_1;

    wire _s_3_1;
    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 5)
    )Stage_2_0
    (
        .In_1({1'b0, s_2_0, 1'b0}),
        .In_2({s_2_1, 2'b0}),
        .In_3({1'b0, s_2_2}),
        .S(s_3_0),
        .C({_s_3_1, s_3_1})
    );

    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 2)] s_3_2 = s_2_3;
    // wire[5 : MANTISSA_WIDTH + 7] s_3_3;
    // wire[4 : MANTISSA_WIDTH + 6] s_3_4;

    // CSA3_2_Array #(
    //     .WIDTH(MANTISSA_WIDTH + 3)
    // )Stage_2_1
    // (
    //     .In_1({1'b0, s_2_4, 1'b0}),
    //     .In_2({s_2_5, 2'b0}),
    //     .In_3({3'b0, s_2_6}),
    //     .S(s_3_3),
    //     .C(s_3_4)
    // );

    // wire[7 : MANTISSA_WIDTH + 6] s_3_5 = s_2_7;

    // wire[13 : MANTISSA_WIDTH + 12] s_3_6;
    // wire[12 : MANTISSA_WIDTH + 11] s_3_7;

    // CSA3_2_Array #(
    //     .WIDTH(MANTISSA_WIDTH)
    // )Stage_2_2
    // (
    //     .In_1({1'b0, s_2_8, 1'b0}),
    //     .In_2({s_2_9, 2'b0}),
    //     .In_3({5'b0, s_2_10}),
    //     .S(s_3_6),
    //     .C(s_3_7)
    // );

    // wire[17 : MANTISSA_WIDTH + 11] s_3_8 = s_2_11;

    //Stage 3
    // wire[-1 : MANTISSA_WIDTH + 3] s_3_0;
    // wire[-1 : MANTISSA_WIDTH + 2] s_3_1;
    // wire[-1 : MANTISSA_WIDTH + 2] s_3_2

    // wire[5 : MANTISSA_WIDTH + 7] s_3_3;
    // wire[4 : MANTISSA_WIDTH + 6] s_3_4;
    // wire[7 : MANTISSA_WIDTH + 6] s_3_5


    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 3)] s_4_0;
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 2)] s_4_1;
    wire _s_4_1;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 5)
    )Stage_3_0
    (
        .In_1(s_3_0),
        .In_2({s_3_1, 1'b0}),
        .In_3({s_3_2, 1'b0}),
        .S(s_4_0),
        .C({_s_4_1, s_4_1})
    );


    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 3)] final_add_0 = s_4_0;
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 3)] final_add_1 = {s_4_1, 1'b0};
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 3)] final_sum;
    //wire no_use_c;
    assign final_sum = final_add_0 + final_add_1;
/*
    CLAdder #(
        .WIDTH(MANTISSA_WIDTH + 12 + 5)
    )FA
    (
        .A({final_add_0, 3'b0}),
        .B({final_add_1, 3'b0}),
        .C_in(1'b0),
        .S(final_sum),
        .C_out(no_use_c)
    );
*/
    assign Mantissa_Out[BASELINE-1 : BASELINE-MANTISSA_WIDTH] = final_sum[BASELINE-(-1)] ? final_sum[BASELINE-0 : BASELINE-(MANTISSA_WIDTH - 1)] : 
                                              (final_sum[BASELINE-0] ? final_sum[BASELINE-1 : BASELINE-MANTISSA_WIDTH] : final_sum[BASELINE-2 : BASELINE-(MANTISSA_WIDTH + 1)]);
    assign Shift = final_sum[BASELINE-(-1) : BASELINE-0];
    
    //final sum左移15位，但由于-1～-5已经预支了5位，所以补上10bit的0，右移(lod_a_en+lod_b_en)
    // wire [2*BASELINE+1:0] before_shift;
    // assign before_shift = {final_sum,{(2*BASELINE-(MANTISSA_WIDTH + 3)){1'b0}}};
    // wire [log_n:0] shift_back;
    // assign shift_back = (lod_a_en+lod_b_en);
    // assign result = before_shift >> shift_back;
endmodule
