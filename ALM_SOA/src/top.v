/* ALM_SOA, M = 11 */
module top
#(parameter
    n     = 16,   //length of original number
    M     = 11
)

(
    input  wire [n-1  :0] a,
    input  wire [n-1  :0] b,

    output wire [2*n-1:0] result
   
);
    wire [15:0] oa, ob;
    wire [16+3-1-M+1:0] tloga, tlogb;
 
    /* a */
    LOD_16 LOD_16a
    (
    .d(a),
    .o(oa)
    );
    TBLC TBLCa (
    .o(oa),
    .x(a),

    .tlog(tloga)
	);
    /* b */
    LOD_16 LOD_16b
    (
    .d(b),
    .o(ob)
    );
    TBLC TBLCb (
    .o(ob),
    .x(b),

    .tlog(tlogb)
	);
    /* adder */
    
    wire [19:0] sumlog;
    SOA SOA
    (
    .tloga(tloga), /* M=11, [8:0] */
    .tlogb(tlogb),

    .sumlog(sumlog)
    );


    LBC LBC(
    .sumlog(sumlog),

    .rst(result)
    );

endmodule
