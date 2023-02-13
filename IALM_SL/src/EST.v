/* Estimator, if cin is 1, then complement of x1 and x2 are used 
 if cin is 0, then doesn't alter. Finally add(attach) a 0 to the head of the 
 x1 and x2, because then we can use the modules before without altering them */

module EST 
(
    input  wire cin,
    input  wire [14:0] x1,
    input  wire [14:0] x2,

    output wire [15:0] U,
    output wire [15:0] V
);  
    wire [14:0] tempU, tempV;
    assign tempU = cin ? ~x1+1 : x1;
    assign tempV = cin ? ~x2+1 : x2;
    assign  U = {1'b0, tempU };
    assign  V = {1'b0, tempV };

endmodule