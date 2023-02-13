// 描述所设计的2bit近似加法器
module ap_adder_u (
    input y2,
    input y1,
    input y0,
    input cin,
    output s1,
    output s2,
    output cout
);
assign cout=y1;
assign s2=y2;
assign s1=cin^y1^y0;

endmodule //app_adder_u