module NOD (
    input wire [15:0] income,
    output wire [15:0] outcome
);
    wire [13:0] T/*verilator split_var*/;
    
    assign T[0] = ~income[15];
    assign T[1] = T[0] & (~income[14]);
    assign T[2] = T[1] & (~income[13]);
    assign T[3] = T[2] & (~income[12]);
    assign T[4] = T[3] & (~income[11]);
    assign T[5] = T[4] & (~income[10]);
    assign T[6] = T[5] & (~income[9]);
    assign T[7] = T[6] & (~income[8]);
    assign T[8] = T[7] & (~income[7]);
    assign T[9] = T[8] & (~income[6]);
    assign T[10] = T[9] & (~income[5]);
    assign T[11] = T[10] & (~income[4]);
    assign T[12] = T[11] & (~income[3]);
    assign T[13] = T[12] & (~income[2]);


    //-------------------------------------//

    assign outcome[0] = income[0] & T[13] & ~income[1];
    assign outcome[1] = (~income[0] & income[1]) & T[13];
    assign outcome[2] = ((income[0] & income[1] & ~income[2]) || (~income[1] & income[2])) & T[12];
    assign outcome[3] = ((income[1] & income[2] & ~income[3]) || (~income[2] & income[3])) & T[11];
    assign outcome[4] = ((income[2] & income[3] & ~income[4]) || (~income[3] & income[4])) & T[10];
    assign outcome[5] = ((income[3] & income[4] & ~income[5]) || (~income[4] & income[5])) & T[9];
    assign outcome[6] = ((income[4] & income[5] & ~income[6]) || (~income[5] & income[6])) & T[8];
    assign outcome[7] = ((income[5] & income[6] & ~income[7]) || (~income[6] & income[7])) & T[7];
    assign outcome[8] = ((income[6] & income[7] & ~income[8]) || (~income[7] & income[8])) & T[6];
    assign outcome[9] = ((income[7] & income[8] & ~income[9]) || (~income[8] & income[9])) & T[5];
    assign outcome[10] = ((income[8] & income[9] & ~income[10]) || (~income[9] & income[10])) & T[4];
    assign outcome[11] = ((income[9] & income[10] & ~income[11]) || (~income[10] & income[11])) & T[3];
    assign outcome[12] = ((income[10] & income[11] & ~income[12]) || (~income[11] & income[12])) & T[2];
    assign outcome[13] = ((income[11] & income[12] & ~income[13]) || (~income[12] & income[13])) & T[1];
    assign outcome[14] = ((income[12] & income[13] & ~income[14]) || (~income[13] & income[14])) & T[0];
    assign outcome[15] = (income[13] & income[14]) || income[15];
    
endmodule
