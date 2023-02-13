module top
#(parameter
	m     = 8, //selecting m bits
	n     = 16//length of original number
)
(
   input  wire [n-1  :0] a,
   input  wire [n-1  :0] b,
   output wire [2*n-1:0] result
);

	wire [m-1 :0] AH;
	wire [m-1 :0] AM;
	wire [m-1 :0] AL;
	wire [m-1 :0] BH;
	wire [m-1 :0] BM;
	wire [m-1 :0] BL;
	wire A2;
	wire A1;
	wire B2;
	wire B1;
	wire [1:0] sel_A;
	wire [1:0] sel_B;
	wire [m-1 :0] seg_A;
	wire [m-1 :0] seg_B;
	wire [2*m-1 :0] Z;
	wire xor_A;
	wire [1:0]s;
	wire c;
	wire and_A2B2;
	wire [2*n-1 :0] temp1_Z;
	wire [2*n-1 :0] temp2_Z;
	wire [2*n-1 :0] temp3_Z;
	
	//每个乘数中截取出的数据段有三种情况
	assign AH = a[n-1 :n-m]; //高m位
	assign AM = a[(n+m)/2-1 :(n-m)/2]; //中m位	
	assign AL = a[m-1 :0]; //低m位
	assign BH = b[n-1 :n-m];
	assign BM = b[(n+m)/2-1 :(n-m)/2];
	assign BL = b[m-1 :0];
	
	//此处代码需根据n和m的值，对或运算操作数的个数做调整
	assign A2 = a[n-1]|a[n-2]|a[n-3]|a[n-4]; //检查leading one bit是否在高(n-m)/2位中
	assign A1 = a[(n+m)/2-1]|a[(n+m)/2-2]|a[(n+m)/2-3]|a[(n+m)/2-4]; //检查leading one bit是否在[(n+m)/2:n-m-1]位中
	assign B2 = b[n-1]|b[n-2]|b[n-3]|b[n-4];
	assign B1 = b[(n+m)/2-1]|b[(n+m)/2-2]|b[(n+m)/2-3]|b[(n+m)/2-4]; 
	
	assign sel_A = {A2,A1};
	assign sel_B = {B2,B1};
	
	//根据leading one bit的位置选择相应数据段
	mux3 #(m)segA(AH,AM,AL,sel_A,seg_A);
	mux3 #(m)segB(BH,BM,BL,sel_B,seg_B);
	
	//进行普通的m*m乘法运算
	multi #(m)multiplier(seg_A,seg_B,Z);
	
	//根据选择段的位置，对m*m乘法运算的结果选择不同补0的情况
	assign xor_A = A2^A1;
	assign and_A2B2 = A2&B2;
	adder a1(sel_A,sel_B,1'b0,s,c);
	//此处代码需根据n和m的值，对补0的个数做调整
	mux2 #(n)m1({8'b0,Z,8'b0},{4'b0,Z,12'b0},xor_A,temp1_Z);
	mux4 #(n)m2({16'b0,Z},{12'b0,Z,4'b0},{8'b0,Z,8'b0},temp1_Z,s,temp2_Z);
	mux2 #(n)m3(temp2_Z,{4'b0,Z,12'b0},c,temp3_Z);	
	mux2 #(n)m4(temp3_Z,{Z,16'b0},and_A2B2,result);	
	
endmodule
