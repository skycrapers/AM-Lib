
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
    wire [18:0] loga, logb;
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
	);
    /* adder1 */
    wire [15:0] sloga_low, slogb_low; /* 16 bits, MSB=0 to enter MCLA_16_var */
    wire [15:0] sumlog_low;  /* temporary sum of log, lower part */
    wire [19:0] sumlog;

    assign sloga_low = {1'b0, loga[14:0]};
    assign slogb_low = {1'b0, logb[14:0]};
    MCLA_16_var MCLA_16_var (
    .a(sloga_low),
    .b(slogb_low),

    .s(sumlog_low)
    );

    assign sumlog[14:0] = sumlog_low[14:0];
    /* while the sumlog_low[15] is very important, it's cin to Estimator */
    MCLA_4_c_c0 MCLA_4_c_c0 (
    .a(loga[18:15]), 
    .b(logb[18:15]),
    .c0(sumlog_low[15]), /* It is the carry of the 15th bit of the sumlog*/

    .s(sumlog[19:15]) /* 5 bits */
    );

    wire [31:0] rst_ab, rst_AB;
    LBC LBC(
    .sumlog(sumlog),

    .rst(rst_ab)
    );
    assign rst_AB = ( oa==0 | ob==0 ) ?  0 : rst_ab ; /* 1111_1111_1111_1111 * 0 = 65535 T_T*/ 
    

/*----------------the Iterative part of the ILM--------------*/
    
    wire [15:0] U, V;

    EST EST (
    .cin(sumlog_low[15]),
    .x1(loga[14:0]),
    .x2(logb[14:0]),

    .U(U),
    .V(V)
    );

    wire [15:0] oU, oV;
    wire [18:0] logU, logV;
    /* U */
    LOD_16 LOD_16U
    (
    .d(U),
    .o(oU)
    );
    BLC BLCU (
    .o(oU),
    .x(U),

    .log(logU)
	);
    /* V */
    LOD_16 LOD_16V
    (
    .d(V),
    .o(oV)
    );
    BLC BLCV (
    .o(oV),
    .x(V),

    .log(logV)
	);

    /* adder2 */
    wire [19:0] slogU, slogV;
    wire [19:0] sumlogUV;
    assign slogU = {1'b0, logU};
    assign slogV = {1'b0, logV};
    MCLA_20_var MCLA_20_var (
    .a(slogU),
    .b(slogV),
    .s(sumlogUV)
    );

    /* LBC_UV */
    wire [31:0] rst_UV;
    LBC LBC_UV(
    .sumlog(sumlogUV),

    .rst(rst_UV)
    );

    /* REV, revise */
    wire [31:0] revise;
    REV REV(
    .rst(rst_UV),
    .k1(loga[18:15]), 
    .k2(logb[18:15]),

    .revise(revise)
    );

/*-------------------Adder3------------------*/
    MCLA_32 MCLA_32(
    .a(rst_AB),
    .b(revise),

    .s(result)
    );

    

endmodule
