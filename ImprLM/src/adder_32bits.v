module adder_32bits (
    input [31:0] a,
    input [31:0] b,
    input ci,
    output [31:0] s,
    output co
);
    wire [27:0] S1,S2;
    wire C1,C2,C3,C4,C5,C6,C7;
    wire [6:0] CS1,CS2;
    adder_4bits u1
    (
        .a(a[3:0]),
        .b(b[3:0]),
        .ci(ci),
        .s(s[3:0]),
        .co(C1)
    );

    adder_4bits u2
    (
        .a(a[7:4]),
        .b(b[7:4]),
        .ci(1'b0),
        .s(S1[3:0]),
        .co(CS1[0:0])
    );
    
    adder_4bits v2
    (
        .a(a[7:4]),
        .b(b[7:4]),
        .ci(1'b1),
        .s(S2[3:0]),
        .co(CS2[0:0])
    );
    
     mux m1
    (
        .sel(C1),
        .a(S1[3:0]),
        .b(S2[3:0]),
        .s(s[7:4])
    );
    
     mux_one n1
    (
        .sel(C1),
        .a(CS1[0:0]),
        .b(CS2[0:0]),
        .s(C2)
    );

    adder_4bits u3
    (
        .a(a[11:8]),
        .b(b[11:8]),
        .ci(1'b0),
        .s(S1[7:4]),
        .co(CS1[1:1])
    );
    
    adder_4bits v3
    (
        .a(a[11:8]),
        .b(b[11:8]),
        .ci(1'b1),
        .s(S2[7:4]),
        .co(CS2[1:1])
    );
        
     mux m2
    (
        .sel(C2),
        .a(S1[7:4]),
        .b(S2[7:4]),
        .s(s[11:8])
    );

     mux_one n2
    (
        .sel(C2),
        .a(CS1[1:1]),
        .b(CS2[1:1]),
        .s(C3)
    );
    adder_4bits u4
    (
        .a(a[15:12]),
        .b(b[15:12]),
        .ci(1'b0),
        .co(CS1[2:2]),
        .s(S1[11:8])
    );
    
    adder_4bits v4
    (
        .a(a[15:12]),
        .b(b[15:12]),
        .ci(1'b1),
        .co(CS2[2:2]),
        .s(S2[11:8])
    );

    mux m3
    (
        .sel(C3),
        .a(S1[11:8]),
        .b(S2[11:8]),
        .s(s[15:12])
    );

    mux_one n3
    (
        .sel(C3),
        .a(CS1[2:2]),
        .b(CS2[2:2]),
        .s(C4)
    );

    adder_4bits u5
    (
        .a(a[19:16]),
        .b(b[19:16]),
        .ci(1'b0),
        .co(CS1[3:3]),
        .s(S1[15:12])
    );
    
    adder_4bits v5
    (
        .a(a[19:16]),
        .b(b[19:16]),
        .ci(1'b1),
        .co(CS2[3:3]),
        .s(S2[15:12])
    );

    mux m4
    (
        .sel(C4),
        .a(S1[15:12]),
        .b(S2[15:12]),
        .s(s[19:16])
    );

    mux_one n4
    (
        .sel(C4),
        .a(CS1[3:3]),
        .b(CS2[3:3]),
        .s(C5)
    );

    adder_4bits u6
    (
        .a(a[23:20]),
        .b(b[23:20]),
        .ci(1'b0),
        .co(CS1[4:4]),
        .s(S1[19:16])
    );
    
    adder_4bits v6
    (
        .a(a[23:20]),
        .b(b[23:20]),
        .ci(1'b1),
        .co(CS2[4:4]),
        .s(S2[19:16])
    );

    mux m5
    (
        .sel(C5),
        .a(S1[19:16]),
        .b(S2[19:16]),
        .s(s[23:20])
    );

    mux_one n5
    (
        .sel(C5),
        .a(CS1[4:4]),
        .b(CS2[4:4]),
        .s(C6)
    );

    adder_4bits u7
    (
        .a(a[27:24]),
        .b(b[27:24]),
        .ci(1'b0),
        .co(CS1[5:5]),
        .s(S1[23:20])
    );
    
    adder_4bits v7
    (
        .a(a[27:24]),
        .b(b[27:24]),
        .ci(1'b1),
        .co(CS2[5:5]),
        .s(S2[23:20])
    );

    mux m6
    (
        .sel(C6),
        .a(S1[23:20]),
        .b(S2[23:20]),
        .s(s[27:24])
    );

    mux_one n6
    (
        .sel(C6),
        .a(CS1[5:5]),
        .b(CS2[5:5]),
        .s(C7)
    );

    adder_4bits u8
    (
        .a(a[31:28]),
        .b(b[31:28]),
        .ci(1'b0),
        .co(CS1[6:6]),
        .s(S1[27:24])
    );
    
    adder_4bits v8
    (
        .a(a[31:28]),
        .b(b[31:28]),
        .ci(1'b1),
        .co(CS2[6:6]),
        .s(S2[27:24])
    );

    mux m7
    (
        .sel(C7),
        .a(S1[27:24]),
        .b(S2[27:24]),
        .s(s[31:28])
    );

    mux_one n7
    (
        .sel(C7),
        .a(CS1[6:6]),
        .b(CS2[6:6]),
        .s(co)
    );
endmodule
