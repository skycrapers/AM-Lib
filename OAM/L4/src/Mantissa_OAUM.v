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
    parameter BASELINE = 23,
    parameter MANTISSA_WIDTH = 23,
    parameter ACC_3 = 4
)
(
    input wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] Mantissa_X,
    input wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] Mantissa_Y,
    // input wire[1 : 0] ACC_Ctrl,
    output wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] Mantissa_Out,

    output wire[1 : 0] Shift
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
    
    wire[BASELINE-7 : BASELINE-(MANTISSA_WIDTH + 4)] pp_3_x = Partial_Product_X[BASELINE-PP_Length(2) : BASELINE-(PP_Length(3) - 1)];
    wire[BASELINE-7 : BASELINE-(MANTISSA_WIDTH + 4)] pp_3_y = Partial_Product_Y[BASELINE-PP_Length(2) : BASELINE-(PP_Length(3) - 1)];
    wire[BASELINE-9 : BASELINE-(MANTISSA_WIDTH + 5)] pp_4_x = Partial_Product_X[BASELINE-PP_Length(3) : BASELINE-(PP_Length(4) - 1)];
    
    wire[BASELINE-9 : BASELINE-(MANTISSA_WIDTH + 5)] pp_4_y = Partial_Product_Y[BASELINE-PP_Length(3) : BASELINE-(PP_Length(4) - 1)];

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

    wire[BASELINE-7 : BASELINE-(MANTISSA_WIDTH + 5)] s_1_6;
    wire[BASELINE-6 : BASELINE-(MANTISSA_WIDTH + 4)] s_1_7;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH - 1)
    )Stage_0_3
    (
        .In_1({pp_3_x, 1'b0}),
        .In_2({pp_3_y, 1'b0}),
        .In_3({2'b0, pp_4_x}),
        .S(s_1_6),
        .C(s_1_7)
    );

    wire[BASELINE-9 : BASELINE-(MANTISSA_WIDTH + 5)] s_1_8 = pp_4_y;


    //Stage 1
    // wire[1 : MANTISSA_WIDTH + 1] s_1_0;
    // wire[0 : MANTISSA_WIDTH] s_1_1;
    // wire[1 : MANTISSA_WIDTH + 2] s_1_2;

    // wire[0 : MANTISSA_WIDTH + 1] s_1_3;
    // wire[3 : MANTISSA_WIDTH + 3] s_1_4;
    // wire[2 : MANTISSA_WIDTH + 2] s_1_5;

    // wire[7 : MANTISSA_WIDTH + 5] s_1_6;
    // wire[6 : MANTISSA_WIDTH + 4] s_1_7;
    // wire[9 : MANTISSA_WIDTH + 5] s_1_8 = pp_4_y;

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

    wire[BASELINE-6 : BASELINE-(MANTISSA_WIDTH + 5)] s_2_4;
    wire[BASELINE-5 : BASELINE-(MANTISSA_WIDTH + 4)] s_2_5;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH)
    )Stage_1_2
    (
        .In_1({1'b0, s_1_6}),
        .In_2({s_1_7, 1'b0}),
        .In_3({3'b0, s_1_8}),
        .S(s_2_4),
        .C(s_2_5)
    );

    //Stage 2
    // wire[0 : MANTISSA_WIDTH + 2] s_2_0;
    // wire[-1 : MANTISSA_WIDTH + 1] s_2_1;
    // wire[-1 : MANTISSA_WIDTH + 2] s_2_3;

    // wire[0 : MANTISSA_WIDTH + 3] s_2_2;
    // wire[6 : MANTISSA_WIDTH + 5] s_2_4;
    // wire[5 : MANTISSA_WIDTH + 4] s_2_5;

    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 2)] s_3_0;
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 1)] s_3_1;

    wire a_s_3_1;
    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 4)
    )Stage_2_0
    (
        .In_1({1'b0, s_2_0}),
        .In_2({s_2_1, 1'b0}),
        .In_3(s_2_3),
        .S(s_3_0),
        .C({a_s_3_1, s_3_1})
    );

    wire[BASELINE-0 : BASELINE-(MANTISSA_WIDTH + 5)] s_3_2;
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 4)] s_3_3;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 6)
    )Stage_2_1
    (
        .In_1({s_2_2, 2'b0}),
        .In_2({6'b0, s_2_4}),
        .In_3({5'b0, s_2_5, 1'b0}),
        .S(s_3_2),
        .C(s_3_3)
    );

    //Stage 3
    // wire[-1 : MANTISSA_WIDTH + 2] s_3_0;
    // wire[-1 : MANTISSA_WIDTH + 1] s_3_1;    
    // wire[-1 : MANTISSA_WIDTH + 4] s_3_3;

    // wire[0 : MANTISSA_WIDTH + 5] s_3_2;


    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 4)] s_4_0;
    wire[BASELINE-(-1 ): BASELINE-(MANTISSA_WIDTH + 3)] s_4_1;
    wire a_s_4_1;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 6) //TODO:change from +5 to +6. Any Problem?
    )Stage_3_0
    (
        .In_1({s_3_0, 2'b0}),
        .In_2({s_3_1, 3'b0}),
        .In_3(s_3_3),
        .S(s_4_0),
        .C({a_s_4_1, s_4_1})
    );

    wire[BASELINE-0 : BASELINE-(MANTISSA_WIDTH + 5)] s_4_2 = s_3_2;

    //Stage 4
    // wire[-1 : MANTISSA_WIDTH + 4] s_4_0;
    // wire[-1 : MANTISSA_WIDTH + 3] s_4_1;
    // wire[0 : MANTISSA_WIDTH + 5] s_4_2 = s_3_2;


    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 5)] s_5_0;
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 4)] s_5_1;
    wire a_s_5_1;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 7)
    )Stage_4_0
    (
        .In_1({s_4_0, 1'b0}),
        .In_2({s_4_1, 2'b0}),
        .In_3({1'b0, s_4_2}),
        .S(s_5_0),
        .C({a_s_5_1, s_5_1})
    );


    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 5)] final_add_0 = s_5_0;
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 5)] final_add_1 = {s_5_1, 1'b0};
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 5)] final_sum;
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
    assign Shift = final_sum[BASELINE-(-1) : BASELINE-0];//用于归一化的移位？
endmodule
