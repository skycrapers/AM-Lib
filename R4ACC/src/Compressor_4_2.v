//连续的两个高低位5-3计数器之间cin和cout级联构成4-2压缩加法器
module Compressor_4_2 
#(parameter
	n     = 32
)
(
   input [n-1:0] op0,
   input [n-1:0] op1,
   input [n-1:0] op2,
   input [n-1:0] op3,
   output [n-1:0] S,
   output [n-1:0] C,
   output cout
);

	wire [n-1:0] cin;
	
	genvar i;
	generate
		for (i = 0; i < n; i=i+1) begin
			if(i == 0)
				Counter_5_3 u_Counter_5_30(
				.x0      (   op0[i]    ),
				.x1      (   op1[i]    ),
				.x2      (   op2[i]    ),
				.x3      (   op3[i]    ),
				.cin    (   1'b0      ),
				.cout   (   cin[i]	  ),
				.sum      (   S[i]      ),
				.carry      (   C[i]      )			
			);
			else
				Counter_5_3 u_Counter_5_31(
				.x0      (   op0[i]    ),
				.x1      (   op1[i]    ),
				.x2      (   op2[i]    ),
				.x3      (   op3[i]    ),
				.cin    (   cin[i-1]    ),
				.cout   (   cin[i]	  ),
				.sum      (   S[i]      ),
				.carry      (   C[i]      )			
			);
		end
	endgenerate
	
	assign cout = cin[n-1];

	
endmodule