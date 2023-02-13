module if_zero(
    input [15:0] A,B,
    output sig

    );
    
    assign sig = (|A) && (|B);
endmodule
