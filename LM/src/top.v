
module top
#(parameter
    n     = 16   //length of original number
)

(
    input  wire [n-1  :0] a,
    input  wire [n-1  :0] b,

    output wire [2*n-1:0] result
   
);
    wire [15:0] oa, ob;
    //wire [3 :0] ka, kb;
    wire [18:0] loga, logb;
    //wire [14:0] fa, fb;
    /* a */
    LOD_16 LOD_16a
    (
    .d(a),
    .o(oa)
    );
    BLC BLCa (
    .o(oa),
    .x(a),

    .log(loga)
    //.f(fa) 
	);
    /* b */
    LOD_16 LOD_16b
    (
    .d(b),
    .o(ob)
    );
    BLC BLCb (
    .o(ob),
    .x(b),

    .log(logb)
    //.f(fb) 
	);
    /* adder */
    wire [19:0] sloga, slogb;
    wire [19:0] sumlog;
    assign sloga = {1'b0, loga};
    assign slogb = {1'b0, logb};
    MCLA_20_var MCLA_20_var (
    .a(sloga),
    .b(slogb),
    .s(sumlog)
    );

    LBC LBC(
    .sumlog(sumlog),

    .rst(result)
    );

endmodule
