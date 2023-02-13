module p_encode (
    input wire [14:0] a,
    output wire [3:0] out
);
    assign out[0] = a[0] || a[2] || a[4] || a[6] ||
             a[8] || a[10] || a[12] || a[14];
            
    assign out[1] = a[1] || a[2] || a[5] || a[6] ||
             a[9] || a[10] || a[13] || a[14];

    assign out[2] = a[3] || a[4] || a[5] || a[6] ||
             a[11] || a[12] || a[13] || a[14];

    assign out[3] = a[7] || a[8] || a[9] || a[10] ||
             a[11] || a[12] || a[13] || a[14];
    
endmodule 
