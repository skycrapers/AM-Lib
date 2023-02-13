`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/06 16:02:19
// Design Name: 
// Module Name: partial_product_generator
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


module Partial_Product_Generator#(
    parameter BASELINE = 23,
    parameter MANTISSA_WIDTH = 23,
    parameter MAX_LEVEL = 9
)(
    input wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] Mantissa_X,
    input wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] Mantissa_Y,
    output wire[BASELINE-0 : BASELINE-(PP_Length(MAX_LEVEL) - 1)] Partial_Product_X,
    output wire[BASELINE-0 : BASELINE-(PP_Length(MAX_LEVEL) - 1)] Partial_Product_Y
);

    function integer PP_Length(input integer Level_n);
    begin
        PP_Length = (MANTISSA_WIDTH + 1) * Level_n - (1 + Level_n) * Level_n / 2;
    end
    endfunction

    wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] Mantissa_X_Inv = ~Mantissa_X;
    wire[BASELINE-1 : BASELINE-MANTISSA_WIDTH] Mantissa_Y_Inv = ~Mantissa_Y;
    wire[BASELINE-1 : BASELINE-MAX_LEVEL] Mantissa_XY_XNOR = (Mantissa_X[BASELINE-1 : BASELINE-MAX_LEVEL] ^~ Mantissa_Y[BASELINE-1 : BASELINE-MAX_LEVEL]);

//这里的x，y和paper上不对应，paper上和x[n],y[n]一致，这里和选取数据一致
    genvar j;
    generate for(j = 1; j <= MAX_LEVEL; j = j + 1)
        begin: PP_GEN
            // connector #(.WIDTH(MANTISSA_WIDTH - j + 1))ConnectPPX(
            //     .In(
            //         {Mantissa_XY_XNOR[BASELINE-j],
            //         {Mantissa_Y[BASELINE-j] ? 
            //         Mantissa_X[BASELINE-(j + 1): BASELINE-MANTISSA_WIDTH] :
            //         Mantissa_X_Inv[BASELINE-(j + 1): BASELINE-MANTISSA_WIDTH]}}
            //     ),
            //     .Out(
            //         Partial_Product_X[BASELINE-PP_Length(j - 1) : BASELINE-(PP_Length(j) - 1)]
            //     )
            // );

            // connector #(.WIDTH(MANTISSA_WIDTH - j + 1))ConnectPPY(
            //     .In(
            //         {1'b0,
            //         {Mantissa_X[BASELINE-j] ? 
            //         Mantissa_Y[BASELINE-(j + 1) : BASELINE-MANTISSA_WIDTH] :
            //         Mantissa_Y_Inv[BASELINE-(j + 1) : BASELINE-MANTISSA_WIDTH]}}
            //     ),
            //     .Out(
            //         Partial_Product_Y[BASELINE-PP_Length(j - 1) : BASELINE-(PP_Length(j) - 1)]
            //     )
            // );
            //上面的源代码有问题？
            connector #(.WIDTH(MANTISSA_WIDTH - j + 1))ConnectPPX(
                .In(
                    {Mantissa_XY_XNOR[BASELINE-j],
                    {Mantissa_X[BASELINE-j] ? 
                    Mantissa_Y[BASELINE-(j + 1): BASELINE-MANTISSA_WIDTH] :
                    Mantissa_Y_Inv[BASELINE-(j + 1): BASELINE-MANTISSA_WIDTH]}}
                ),
                .Out(
                    Partial_Product_X[BASELINE-PP_Length(j - 1) : BASELINE-(PP_Length(j) - 1)]
                )
            );

            connector #(.WIDTH(MANTISSA_WIDTH - j + 1))ConnectPPY(
                .In(
                    {1'b0,
                    {Mantissa_Y[BASELINE-j] ? 
                    Mantissa_X[BASELINE-(j + 1) : BASELINE-MANTISSA_WIDTH] :
                    Mantissa_X_Inv[BASELINE-(j + 1) : BASELINE-MANTISSA_WIDTH]}}
                ),
                .Out(
                    Partial_Product_Y[BASELINE-PP_Length(j - 1) : BASELINE-(PP_Length(j) - 1)]
                )
            );
        end
    endgenerate
endmodule
