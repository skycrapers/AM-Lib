/* Leading one detector, 16bit */
module LOD_16
(
    input  wire [15:0] d,
    output wire [15:0] o
);

    wire [15:0] p;
    LOD_4 LOD_40(.d(d[ 3: 0]), .o(p[ 3: 0]));
    LOD_4 LOD_41(.d(d[ 7: 4]), .o(p[ 7: 4]));
    LOD_4 LOD_42(.d(d[11: 8]), .o(p[11: 8]));
    LOD_4 LOD_43(.d(d[15:12]), .o(p[15:12]));

    wire [3:0] e;
    assign e[0] = d[ 0] | d[ 1] | d[ 2] | d[ 3];
    assign e[1] = d[ 4] | d[ 5] | d[ 6] | d[ 7];
    assign e[2] = d[ 8] | d[ 9] | d[10] | d[11];
    assign e[3] = d[12] | d[13] | d[14] | d[15];

    wire [3:0] q;
    LOD_4 LOD_44(.d(e       ), .o(q       ));

    assign o[ 3: 0] = q[0] ? p[ 3: 0] : 0;
    assign o[ 7: 4] = q[1] ? p[ 7: 4] : 0;
    assign o[11: 8] = q[2] ? p[11: 8] : 0;
    assign o[15:12] = q[3] ? p[15:12] : 0; 
    
endmodule