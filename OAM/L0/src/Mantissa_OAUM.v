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


module Mantissa_OAUM#(
    parameter BASELINE = 15,
    parameter MANTISSA_WIDTH = 15,
    parameter log_n = 4,
    parameter ACC_3 = 1
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

    // wire[0 : PP_Length(ACC_3) - 1] Partial_Product_X;
    // wire[0 : PP_Length(ACC_3) - 1] Partial_Product_Y;
    // Partial_Product_Generator #(
    //     .MANTISSA_WIDTH(MANTISSA_WIDTH),
    //     .MAX_LEVEL(ACC_3)
    // )PGEN(
    //     .Mantissa_X(Mantissa_X),
    //     .Mantissa_Y(Mantissa_Y),
    //     .Partial_Product_X(Partial_Product_X),
    //     .Partial_Product_Y(Partial_Product_Y)
    // );

    //stage 0
    wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] pp_0_x_0 = Mantissa_X[BASELINE-1 : BASELINE-MANTISSA_WIDTH];
    wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] pp_0_y_0 = Mantissa_Y[BASELINE-1 : BASELINE-MANTISSA_WIDTH];
    wire[BASELINE-2 : BASELINE-(MANTISSA_WIDTH + 1)] pp_0_x_1 = Mantissa_X[BASELINE-1 : BASELINE-MANTISSA_WIDTH];
    
    wire[BASELINE-2 : BASELINE-(MANTISSA_WIDTH + 1)] pp_0_y_1 = Mantissa_Y[BASELINE-1 : BASELINE-MANTISSA_WIDTH];
    wire[BASELINE-1 : BASELINE-2 * (ACC_3 + 1)] pp_0_c = const_cn[BASELINE-1 : BASELINE-2 * (ACC_3 + 1)];          // 2 * (ACC_3 + 1) <= MANTISSA_WIDTH + 1
    


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

    // wire[1 : MANTISSA_WIDTH + 1] s_1_0;
    // wire[0 : MANTISSA_WIDTH] s_1_1;
    // wire[2 : MANTISSA_WIDTH + 1] pp_0_y_1 

    wire[BASELINE-0 : BASELINE-(MANTISSA_WIDTH + 1)] s_2_0;
    wire[BASELINE-(-1) : BASELINE-MANTISSA_WIDTH] s_2_1;

    CSA3_2_Array #(
        .WIDTH(MANTISSA_WIDTH + 2)
    )Stage_1_0
    (
        .In_1({1'b0, s_1_0}),
        .In_2({s_1_1, 1'b0}),
        .In_3({2'b0, pp_0_y_1}),
        .S(s_2_0),
        .C(s_2_1)
    );

    // wire[0 : MANTISSA_WIDTH + 1] s_2_0;
    // wire[-1 : MANTISSA_WIDTH] s_2_1;
    // wire[1 : 2 * (ACC_3 + 1)] pp_0_c

    wire[BASELINE-(-1): BASELINE-2 * (ACC_3 + 1)] s_3_0;
    wire[BASELINE-(-1): BASELINE-(2 * (ACC_3 + 1) - 1)] s_3_1;
    wire _s_3_1;

    CSA3_2_Array #(
        .WIDTH(2 * (ACC_3 + 1) + 2)
    )Stage_2_0
    (
        .In_1({1'b0, s_2_0[BASELINE-0: BASELINE-2 * (ACC_3 + 1)]}),
        .In_2(s_2_1[BASELINE-(-1): BASELINE-2 * (ACC_3 + 1)]),
        .In_3({2'b0, pp_0_c}),
        .S(s_3_0),
        .C({_s_3_1, s_3_1})
    );


    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 1)] final_add_0 = {s_3_0, s_2_0[BASELINE-(2 * (ACC_3 + 1) + 1 ): BASELINE-(MANTISSA_WIDTH + 1)]};
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 1)] final_add_1 = {s_3_1, 1'b0, s_2_1[BASELINE-(2 * (ACC_3 + 1) + 1 ): BASELINE-(MANTISSA_WIDTH)], 1'b0};
    wire[BASELINE-(-1) : BASELINE-(MANTISSA_WIDTH + 1)] final_sum;
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
    
    // //final sum左移15位，但由于-1～-5已经预支了5位，所以补上10bit的0，右移(lod_a_en+lod_b_en)
    // wire [2*BASELINE+1:0] before_shift;
    // assign before_shift = {final_sum,{(2*BASELINE-(MANTISSA_WIDTH + 1)){1'b0}}};
    // wire [log_n:0] shift_back;
    // assign shift_back = (lod_a_en+lod_b_en);
    // assign result = before_shift >> shift_back;
endmodule
