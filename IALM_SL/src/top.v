
module top
#(parameter
    n     = 16,   //length of original number
    M1    = 5 ,
    M2    = 11
)

(
    input  wire [n-1  :0] a,
    input  wire [n-1  :0] b,

    output wire [2*n-1:0] result
   
);
    wire [15:0] oa, ob;
    wire [16+3-1-M1+1:0] tloga, tlogb; /* M1=5, [14:0] */
    // wire [18:0] loga, logb;
    /* a */
    LOD_16 LOD_16a
    (
    .d(a),
    .o(oa)
    );
    TBLC_5 TBLCa (
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
    TBLC_5 TBLCb (
    .o(ob),
    .x(b),

    .tlog(tlogb)
	);
    /* adder1 */
    // wire [15:0] sloga_low, slogb_low; /* 16 bits, MSB=0 to enter MCLA_16_var */
    // wire [15:0] sumlog_low;  /* temporary sum of log, lower part */
    wire [19:0] sumlog;
    wire cin_EST;
    SOA_5 SOA_5(
    .tloga(tloga), /* M=5 , [14:0] */
    .tlogb(tlogb),
    
    .sumlog(sumlog),
    .cin_EST(cin_EST) /* cin of the EST */
    );

    // assign sloga_low = {1'b0, loga[14:0]};
    // assign slogb_low = {1'b0, logb[14:0]};
    // MCLA_16_var MCLA_16_var (
    // .a(sloga_low),
    // .b(slogb_low),

    // .s(sumlog_low)
    // );

    // assign sumlog[14:0] = sumlog_low[14:0];
    // /* while the sumlog_low[15] is very important, it's cin to Estimator */
    // MCLA_4_c_c0 MCLA_4_c_c0 (
    // .a(loga[18:15]), 
    // .b(logb[18:15]),
    // .c0(sumlog_low[15]), /* It is the carry of the 15th bit of the sumlog*/

    // .s(sumlog[19:15]) /* 5 bits */
    // );

    wire [31:0] rst_ab, rst_AB;
    LBC LBC(
    .sumlog(sumlog),

    .rst(rst_ab)
    );


    assign rst_AB = ( oa==0 | ob==0 ) ?  0 : rst_ab ; /* 1111_1111_1111_1111 * 0 = 65535 T_T*/ 
    

/*----------------the Iterative part of the ILM--------------*/
    
    wire [15:0] U, V;
    wire [14:0] x1_EST, x2_EST;
    assign x1_EST = {tloga[10:0], 4'b0};  /* the 11-14th bits of tlog is k */
    assign x2_EST = {tlogb[10:0], 4'b0};
    
    EST EST (
    .cin(cin_EST),
    .x1(x1_EST),
    .x2(x2_EST),

    .U(U),
    .V(V)
    );

    wire [15:0] oU, oV;
    
    wire [16+3-1-M2+1:0] tlogU, tlogV; /* M2=11, [8:0] */
    /* U */
    LOD_16 LOD_16U
    (
    .d(U),
    .o(oU)
    );
    TBLC_11 TBLCU (
    .o(oU),
    .x(U),

    .tlog(tlogU)
	);
    /* V */
    LOD_16 LOD_16V
    (
    .d(V),
    .o(oV)
    );
    TBLC_11 TBLCV (
    .o(oV),
    .x(V),

    .tlog(tlogV)
	);

    /* adder2 */
    // wire [19:0] slogU, slogV;
    wire [19:0] sumlogUV;
    // assign slogU = {1'b0, logU};
    // assign slogV = {1'b0, logV};
    // MCLA_20_var MCLA_20_var (
    // .a(slogU),
    // .b(slogV),
    // .s(sumlogUV)
    // );
    SOA_11 SOA_11 (
    .tloga(tlogU), /* M=11, [8:0] */
    .tlogb(tlogV),

    .sumlog(sumlogUV) /* [19:0] */
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
    // .k1(loga[18:15]), 
    // .k2(logb[18:15]),
    .k1(tloga[14:11]), 
    .k2(tlogb[14:11]),

    .revise(revise)
    );

/*-------------------Adder3------------------*/
    LOA_16 LOA_16(
    .a(rst_AB),
    .b(revise),

    .s(result)
    );

    

endmodule
