module shifter (
    input wire [15:0] data_in,
    input wire [3:0] select,
    output wire [31:0] data_out
);
    wire [47:0] data_in_double;
    wire [47:0] data_in_double2;
    assign data_in_double = {16'b0000000000000000,data_in,16'b0000000000000000};
    assign data_in_double2 = {16'b1111111111111111,data_in,16'b0000000000000000};

//The same as signal[select + 15 : select]
    assign data_out = (data_in[15])? data_in_double2[(16-select)+31-:32] : data_in_double[(16-select)+31-:32];

endmodule