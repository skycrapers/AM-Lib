/* Leading one detector, 4bit */
module LOD_4
(
    input  wire [3:0] d,
    output wire [3:0] o
);

    assign o[3] = d[3];
    assign o[2] = (~d[3]) & d[2];
    assign o[1] = (d[2] ? 0 : ~d[3]) & d[1];
    assign o[0] = (d[1] ? 0 : (d[2] ? 0 : ~d[3])) & d[0];


    
endmodule