module adder_4bits(
    input [3:0] a,
    input [3:0] b,
    input ci,
    output [3:0] s,
    output  co
);
    reg [3:0] P,G,C;
    reg [3:0]Sum;
    reg Cout;
    always @(a or b or ci)
    begin
    G[0] =a[0] & b[0];      
    P[0] =a[0] | b[0];      
    C[0] =ci;               
    Sum[0] =G[0]^ P[0] ^ C[0];
    G[1] =a[1] & b[1];
    P[1] =a[1] | b[1];
    C[1] =G[0] |(P[0] & C[0]);
    Sum[1] =G[1] ^ P[1] ^ C[1];
    G[2] =a[2] & b[2];
    P[2] =a[2] | b[2];
    C[2] =G[1] |(P[1] & C[1]);
    Sum[2] =G[2] ^ P[2] ^ C[2];
    G[3] =a[3] & b[3];
    P[3] =a[3] | b[3];
    C[3] =G[2] |(P[2] & C[2]);
    Sum[3] =G[3] ^ P[3] ^ C[3];
    Cout =G[3] | (P[3] & C[3]);
    end
    assign s=Sum;
    assign co=Cout;
endmodule