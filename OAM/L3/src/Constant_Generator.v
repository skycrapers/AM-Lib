`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/06 16:01:51
// Design Name: 
// Module Name: Constant_generator
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


module Constant_Generator
#(
    // parameter ACC_1 = 0,
    // parameter ACC_2 = 4,
    parameter BASELINE = 10,
    parameter ACC_3 = 11
)
(
    // input wire [1 : 0] Enable,
    output wire [BASELINE-1 :BASELINE-( 2 * ACC_3 + 2)] Const
);
    if(ACC_3 == 0) begin: Const_0
        assign Const[BASELINE-1 : BASELINE-2] = 2'b11;
    end
    else begin: Const_0_ELSE
        assign Const[BASELINE-1 : BASELINE-2] = 2'b10;
    end

    // wire en_2 = Enable[0] || Enable[1];
    // wire en_3 = Enable[1];

    genvar i;
    // generate for(i = 3; i < 2 * ACC_3 + 2; i = i + 2) begin: c_odd_assign
    //     if(i == 2 * ACC_1 + 1) begin: Const_ACC_1
    //         assign Const[i] = 1'b0;     //ACC_1 always On
    //     end
    //     else if(i == 2 * ACC_2 + 1) begin: Const_ACC_2
    //         assign Const[i] = Enable[0];
    //     end
    //     else if(i == 2 * ACC_3 + 1) begin: Const_ACC_3
    //         assign Const[i] = Enable[1];
    //     end
    //     else begin: Const_Other
    //         assign Const[i] = 1'b0;
    //     end
    // end
    // endgenerate

    generate for(i = 3; i <= 2 * ACC_3 + 2; i = i + 1) begin: c_even_assign
        // if(i == 2 * ACC_1 + 2) begin: Const_ACC_1
        //     assign Const[i] = 1'b1;      //ACC_1 always On
        // end else if(i == 2 * ACC_2 + 2) begin: Const_ACC_2
        //     assign Const[i] = Enable[0];
        if(i == 2 * ACC_3 + 2) begin: Const_ACC_3
            assign Const[BASELINE-i] = 1'b1;
        end else begin: Others //(not working here)
            assign Const[BASELINE-i] = 1'b0;
        end
    end
    endgenerate

endmodule