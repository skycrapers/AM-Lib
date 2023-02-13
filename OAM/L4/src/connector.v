`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/12 13:27:23
// Design Name: 
// Module Name: connector
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


module connector#(
    parameter WIDTH = 32
)(
    input wire[WIDTH - 1 : 0] In,
    output wire[WIDTH - 1 : 0] Out
);
    assign Out[WIDTH - 1 : 0] = In[WIDTH - 1 : 0];
endmodule
