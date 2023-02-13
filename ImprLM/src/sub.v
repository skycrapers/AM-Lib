module sub (
    input [15:0] a,
    input [15:0] diff,
    output [15:0] s,
    output co
);
    wire [15:0] inverse;
    wire [15:0] b;
    wire [11:0] S1,S2;
    wire C1,C2,C3;
    wire  [2:0] CS1,CS2;
    
    assign inverse = ~diff;
    assign b = inverse + 1;
    adder_4bits u1
    (
        .a(a[3:0]),
        .b(b[3:0]),
        .ci(1'b0),
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
        .s(co)
    );

endmodule
