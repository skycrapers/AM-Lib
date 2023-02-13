module full_adder(a,b,s,ci,co);
input a,b,ci;
output s,co;
wire m1,m2,m3;
and (m1,a,b),(m2,a,ci),(m3,b,ci);
xor (s,a,b,ci);
or (co,m1,m2,m3);
endmodule