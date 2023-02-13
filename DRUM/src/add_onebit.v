module add_onebit
(
input wire a,
input wire b,
input wire ci,
output wire sum,
output wire co);
//(sum,cout,a,b,cin);
//input a,b,cin;
//output sum;
//output cout;

assign sum=a^b^ci;
assign co=a&b|b&ci|a&ci;

endmodule
