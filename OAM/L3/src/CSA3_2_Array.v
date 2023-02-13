`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/17 17:10:17
// Design Name: 
// Module Name: CSA3_2
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

module CSA3_2_Array #
(
    parameter   WIDTH  = 24
)
(
    input wire[WIDTH - 1 : 0] In_1,
    input wire[WIDTH - 1 : 0] In_2,
    input wire[WIDTH - 1 : 0] In_3,
    output wire[WIDTH - 1 : 0] S,
    output wire[WIDTH - 1 : 0] C
);

//Conventional
    // assign S = In_1 ^ In_2 ^ In_3;
    // assign C = (In_1 & In_2) | (In_2 & In_3) | (In_1 & In_3);

//FA3
    wire[WIDTH - 1 : 0] temp1 = In_1 ^ In_2;
    wire[WIDTH - 1 : 0] temp2 = ~ In_1 ^ In_2;

    genvar i;
    for (i = 0; i < WIDTH ; i = i + 1) 
    begin : csa_assign
        assign C[i] = temp1[i] ? In_3[i] : In_1[i];
        assign S[i] = In_3[i] ? temp2[i] : temp1[i];
    end

endmodule  //CSA3_2
