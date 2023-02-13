`include "common.vh"
module MULT(a,b,result);
//accurate multiplier using Wallace Tree
//6-bit multiplier
//unsigned
parameter n=6;

input  wire  [n-1:0]     a;
input  wire  [n-1:0]     b;
output  wire [2*n-1:0]   result;

wire [n-1:0] p [0:n-1];//partial_product
genvar i,j;
generate
    for (i=0; i<n; i=i+1)
    begin:iloop
	  for (j=0; j<n; j=j+1) 
	    begin:jloop
          assign p[i][j] = a[i] & b[j];
        end
    end
endgenerate

//ha_column_step
//fa_column_step
wire [33:0] s,c;
//step 1
HA ha_11   ( .a(p[1][0]), .b( p[0][1]), .sum(s[0]), .co(c[0]) ); 
HA ha_61   ( .a(p[2][4]), .b( p[1][5]), .sum(s[5]), .co(c[5]) ); 

FA fa_21   ( .a(p[2][0]), .b( p[1][1]), .ci( p[0][2] ), .sum(s[1]), .co(c[1]) );
FA fa_31   ( .a(p[2][1]), .b( p[1][2]), .ci( p[0][3] ), .sum(s[2]), .co(c[2]) );
FA fa_41   ( .a(p[2][2]), .b( p[1][3]), .ci( p[0][4] ), .sum(s[3]), .co(c[3]) );
FA fa_51   ( .a(p[2][3]), .b( p[1][4]), .ci( p[0][5] ), .sum(s[4]), .co(c[4]) );

HA ha_41   ( .a(p[4][0]), .b( p[3][1]), .sum(s[6]), .co(c[6]) ); 
HA ha_91   ( .a(p[5][4]), .b( p[4][5]), .sum(s[11]), .co(c[11]) ); 

FA fa_51_1 ( .a(p[5][0]), .b( p[4][1]), .ci( p[3][2] ), .sum(s[7]), .co(c[7]) );
FA fa_61   ( .a(p[5][1]), .b( p[4][2]), .ci( p[3][3] ), .sum(s[8]), .co(c[8]) );
FA fa_71   ( .a(p[5][2]), .b( p[4][3]), .ci( p[3][4] ), .sum(s[9]), .co(c[9]) );
FA fa_81   ( .a(p[5][3]), .b( p[4][4]), .ci( p[3][5] ), .sum(s[10]), .co(c[10]) );

//step 2
HA ha_22   ( .a(c[0]), .b( s[1]), .sum(s[12]), .co(c[12]) ); 

FA fa_32   ( .a(p[3][0]), .b( c[1]), .ci( s[2] ), .sum(s[13]), .co(c[13]) );
FA fa_42   ( .a(s[6]), .b( c[2]), .ci( s[3] ), .sum(s[14]), .co(c[14]) );
FA fa_52   ( .a(s[7]), .b( c[3]), .ci( s[4] ), .sum(s[15]), .co(c[15]) );
FA fa_62   ( .a(s[8]), .b( c[4]), .ci( s[5] ), .sum(s[16]), .co(c[16]) );
FA fa_72   ( .a(s[9]), .b( c[5]), .ci( p[2][5] ), .sum(s[17]), .co(c[17]) );

//step 3
HA ha_33   ( .a(c[12]), .b( s[13]), .sum(s[18]), .co(c[18]) ); 
HA ha_43   ( .a(c[13]), .b( s[14]), .sum(s[19]), .co(c[19]) ); 
HA ha_93   ( .a(c[10]), .b( s[11]), .sum(s[24]), .co(c[24]) ); 
HA ha_103  ( .a(c[11]), .b( p[5][5]), .sum(s[25]), .co(c[25]) ); 

FA fa_53   ( .a(c[6]), .b( c[14]), .ci( s[15] ), .sum(s[20]), .co(c[20]) );
FA fa_63   ( .a(c[7]), .b( c[15]), .ci( s[16] ), .sum(s[21]), .co(c[21]) );
FA fa_73   ( .a(c[8]), .b( c[16]), .ci( s[17] ), .sum(s[22]), .co(c[22]) );
FA fa_83   ( .a(c[9]), .b( c[17]), .ci( s[10] ), .sum(s[23]), .co(c[23]) );

//step 4
HA ha_44   ( .a(c[18]), .b( s[19]), .sum(s[26]), .co(c[26]) ); 

FA fa_54   ( .a(c[26]), .b( c[19]), .ci( s[20] ), .sum(s[27]), .co(c[27]) );
FA fa_64   ( .a(c[27]), .b( c[20]), .ci( s[21] ), .sum(s[28]), .co(c[28]) );
FA fa_74   ( .a(c[28]), .b( c[21]), .ci( s[22] ), .sum(s[29]), .co(c[29]) );
FA fa_84   ( .a(c[29]), .b( c[22]), .ci( s[23] ), .sum(s[30]), .co(c[30]) );
FA fa_94   ( .a(c[30]), .b( c[23]), .ci( s[24] ), .sum(s[31]), .co(c[31]) );
FA fa_104  ( .a(c[31]), .b( c[24]), .ci( s[25] ), .sum(s[32]), .co(c[32]) );

HA ha_113  ( .a(c[32]), .b( c[25]), .sum(s[33]), .co(c[33]) ); 

//final result
assign result={s[33],s[32],s[31],s[30],s[29],s[28],s[27],s[26],s[18],s[12],s[0],p[0][0]};

endmodule
//-----------------------------------------
module HA(a,b,sum,co);
//Half Adder
input a,b;
output sum,co;

assign sum = a^b;
assign co = a&b;

endmodule

//--------------------------------------------
module FA(a,b,ci,sum,co);
//Full Adder
input a,b,ci;
output sum,co;
reg T1,T2,T3,co;

assign sum=a^b^ci;

always @(a or b or ci)
  begin
    T1 = a&b;
	T2 = a&ci;
	T3 = b&ci;
	co = T1|T2|T3;
  end

endmodule
