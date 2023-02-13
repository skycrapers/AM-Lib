module decode (
    input wire [4:0] A,
    output wire[31:0] Y
);
    wire [4:0] NA;
    
    assign NA[0] = ~A[0];
    assign NA[1] = ~A[1];
    assign NA[2] = ~A[2];
    assign NA[3] = ~A[3];
    assign NA[4] = ~A[4];

//---------------------Data Path----------------------//

    assign Y[0] = (NA[0] & NA[1] & NA[2] & NA[3] & NA[4]);
    assign Y[1] = (A[0] & NA[1] & NA[2] & NA[3] & NA[4]);
    assign Y[2] = (NA[0] & A[1] & NA[2] & NA[3] & NA[4]);
    assign Y[3] = (A[0] & A[1] & NA[2] & NA[3] & NA[4]);
    assign Y[4] = (NA[0] & NA[1] & A[2] & NA[3] & NA[4]);
    assign Y[5] = (A[0] & NA[1] & A[2] & NA[3] & NA[4]);
    assign Y[6] = (NA[0] & A[1] & A[2] & NA[3] & NA[4]);
    assign Y[7] = (A[0] & A[1] & A[2] & NA[3] & NA[4]);
    assign Y[8] = (NA[0] & NA[1] & NA[2] & A[3] & NA[4]);
    assign Y[9] = (A[0] & NA[1] & NA[2] & A[3] & NA[4]);
    assign Y[10] = (NA[0] & A[1] & NA[2] & A[3] & NA[4]);
    assign Y[11] = (A[0] & A[1] & NA[2] & A[3] & NA[4]);
    assign Y[12] = (NA[0] & NA[1] & A[2] & A[3] & NA[4]);
    assign Y[13] = (A[0] & NA[1] & A[2] & A[3] & NA[4]);
    assign Y[14] = (NA[0] & A[1] & A[2] & A[3] & NA[4]);
    assign Y[15] = (A[0] & A[1] & A[2] & A[3] & NA[4]);
    assign Y[16] = (NA[0] & NA[1] & NA[2] & NA[3] & A[4]);
    assign Y[17] = (A[0] & NA[1] & NA[2] & NA[3] & A[4]);
    assign Y[18] = (NA[0] & A[1] & NA[2] & NA[3] & A[4]);
    assign Y[19] = (A[0] & A[1] & NA[2] & NA[3] & A[4]);
    assign Y[20] = (NA[0] & NA[1] & A[2] & NA[3] & A[4]);
    assign Y[21] = (A[0] & NA[1] & A[2] & NA[3] & A[4]);
    assign Y[22] = (NA[0] & A[1] & A[2] & NA[3] & A[4]);
    assign Y[23] = (A[0] & A[1] & A[2] & NA[3] & A[4]);
    assign Y[24] = (NA[0] & NA[1] & NA[2] & A[3] & A[4]);
    assign Y[25] = (A[0] & NA[1] & NA[2] & A[3] & A[4]);
    assign Y[26] = (NA[0] & A[1] & NA[2] & A[3] & A[4]);
    assign Y[27] = (A[0] & A[1] & NA[2] & A[3] & A[4]);
    assign Y[28] = (NA[0] & NA[1] & A[2] & A[3] & A[4]);
    assign Y[29] = (A[0] & NA[1] & A[2] & A[3] & A[4]);
    assign Y[30] = (NA[0] & A[1] & A[2] & A[3] & A[4]);
    assign Y[31] = (A[0] & A[1] & A[2] & A[3] & A[4]);

endmodule