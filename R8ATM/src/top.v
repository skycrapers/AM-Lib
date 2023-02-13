//Date		: 2020/05/26
//Author	: zhishangtanxin 
//Function	: 
//read more, please refer to wechat public account "zhishangtanxin"
module top(
	input [15:0] a,
	input [15:0] b,
	output [31:0] result
);
wire [5:0] neg;
wire [5:0] f0;
wire [5:0] f1;
wire [5:0] f2;
wire [5:0] f3;
wire [5:0] f4;

genvar i;
generate 
	for(i=0; i<5; i=i+1)begin
		if(i==0)
			booth_enc u_booth_enc(
				.code ({b[2:0],1'b0}),
				.neg  (neg[i]),
				.f0  (f0[i]),
				.f1  (f1[i]),
				.f2  (f2[i]),
				.f3  (f3[i]),
				.f4  (f4[i])
			);
		else
			booth_enc u_booth_enc(
				.code (b[i*3+2:i*3-1]),
				.neg  (neg[i]),
				.f0  (f0[i]),
				.f1  (f1[i]),
				.f2  (f2[i]),
				.f3  (f3[i]),
				.f4  (f4[i])
			);
	end
		booth_enc u_booth_enc(
				.code ({b[15],b[15],b[15:14]}),
				.neg  (neg[5]),
				.f0  (f0[5]),
				.f1  (f1[5]),
				.f2  (f2[5]),
				.f3  (f3[5]),
				.f4  (f4[5])
			);
endgenerate

wire [31:0] prod [5:0];
generate 
	for(i=0; i<6; i=i+1)begin
		choose_prod u_choose_prod (
			.A    ( a       ),
			.neg  ( neg[i]  ),
			.f0  (f0[i]),
			.f1  (f1[i]),
			.f2  (f2[i]),
			.f3  (f3[i]),
			.f4  (f4[i]),
			.prod ( prod[i] )
		);

	end
endgenerate
//=====================================================================
//                            wallace tree
//=====================================================================
wire [31:0] s_lev01;
wire [31:0] c_lev01;
wire [31:0] s_lev02;
wire [31:0] c_lev02;
wire [31:0] s_lev11;
wire [31:0] c_lev11;
wire [31:0] s_lev21;
wire [31:0] c_lev21;

//level 0
csa #(32) csa_lev01(
	.op1( prod[0]      ),
	.op2( prod[1] << 3 ),
	.op3( prod[2] << 6 ),
	.S	( s_lev01      ),
	.C	( c_lev01      )
);

csa #(32) csa_lev02(
	.op1( prod[3] << 9 ),
	.op2( prod[4] << 12 ),
	.op3( prod[5] << 15 ),
	.S	( s_lev02      ),
	.C	( c_lev02      )
);

//level 1
csa #(32) csa_lev11(
	.op1( s_lev01      ),
	.op2( c_lev01 << 1 ),
	.op3( s_lev02      ),
	.S	( s_lev11      ),
	.C	( c_lev11      )
);

//level 2
csa #(32) csa_lev21(
	.op1( s_lev11      ),
	.op2( c_lev11 << 1 ),
	.op3( c_lev02 << 1  ),
	.S	( s_lev21      ),
	.C	( c_lev21      )
);

//adder
rca #(32) u_rca (
    .op1 ( s_lev21  ), 
    .op2 ( c_lev21 << 1  ),
    .cin ( 1'b0   ),
    .sum ( result      ),
    .cout(        )
);

endmodule
