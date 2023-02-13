module top
#(parameter
	n     = 16//16-bit multiplier
)
(
   input  wire [n-1  :0] a,
   input  wire [n-1  :0] b,
   output wire [2*n-1:0] result
);



	
	//generate partial products
	//approximate booth encoding with factor p and generate partial products	
	
	wire [15:0] prod0_temp,prod1_temp,prod2_temp,prod3_temp,prod4_temp,prod5_temp,prod6_temp,prod7_temp;
	genvar j;
	
	//product_0
	generate
		for(j=0; j < n; j=j+1) begin : MBE_LOOP0
			if(j == 0)
			MBE u00_MBE(.a({a[0],1'b0}),.b({b[1:0],1'b0}),.pp(prod0_temp[j]));	
			else
			MBE u01_MBE(.a(a[j:j-1]),.b({b[1:0],1'b0}),.pp(prod0_temp[j]));						
		end
	endgenerate

	
	//product_1
	generate				
		for(j=0; j < n; j=j+1) begin : MBE_LOOP1
		if(j == 0)
			MBE u10_MBE(.a({a[0],1'b0}),.b(b[3:1]),.pp(prod1_temp[j]));			
		else
			MBE u11_MBE(.a(a[j:j-1]),.b(b[3:1]),.pp(prod1_temp[j]));	
		end
	endgenerate

	
	//product_2
	generate			
		for(j=0; j < n; j=j+1) begin : MBE_LOOP2
		if(j == 0)
			MBE u20_MBE(.a({a[0],1'b0}),.b(b[5:3]),.pp(prod2_temp[j]));		
		else
			MBE u21_MBE(.a(a[j:j-1]),.b(b[5:3]),.pp(prod2_temp[j]));		
		end
	endgenerate		

	//product_3
	generate			
		for(j=0; j < n; j=j+1) begin : MBE_LOOP3
		if(j == 0)
			MBE u30_MBE(.a({a[0],1'b0}),.b(b[7:5]),.pp(prod3_temp[j]));	
		else
			MBE u31_MBE(.a(a[j:j-1]),.b(b[7:5]),.pp(prod3_temp[j]));	
		end
	endgenerate	

	//product_4	
	generate			
		for(j=0; j < n; j=j+1) begin : MBE_LOOP4
		if(j == 0)
			MBE u40_MBE(.a({a[0],1'b0}),.b(b[9:7]),.pp(prod4_temp[j]));	
		else
			MBE u41_MBE(.a(a[j:j-1]),.b(b[9:7]),.pp(prod4_temp[j]));	
		end
	endgenerate	
	
	//product_5
	generate			
		for(j=0; j < n; j=j+1) begin : MBE_LOOP5
		if(j == 0)
			MBE u50_MBE(.a({a[0],1'b0}),.b(b[11:9]),.pp(prod5_temp[j]));	
		else
			MBE u51_MBE(.a(a[j:j-1]),.b(b[11:9]),.pp(prod5_temp[j]));	
		end
	endgenerate	
	
	//product_6
	generate			
		for(j=0; j < n; j=j+1) begin : MBE_LOOP6
		if(j == 0)
			MBE u60_MBE(.a({a[0],1'b0}),.b(b[13:11]),.pp(prod6_temp[j]));	
		else
			MBE u61_MBE(.a(a[j:j-1]),.b(b[13:11]),.pp(prod6_temp[j]));	
		end
	endgenerate	
	
	//product_7
	generate			
		for(j=0; j < n; j=j+1) begin : MBE_LOOP7
		if(j == 0)
			MBE u70_MBE(.a({a[0],1'b0}),.b(b[15:13]),.pp(prod7_temp[j]));	
		else
			MBE u71_MBE(.a(a[j:j-1]),.b(b[15:13]),.pp(prod7_temp[j]));	
		end
	endgenerate	



	//sign extension
	wire [18:0] prod_0;
	wire [19:0] prod_1;
	wire [19:0] prod_2;
	wire [19:0] prod_3;
	wire [19:0] prod_4;
	wire [19:0] prod_5;
	wire [19:0] prod_6;
	wire [19:0] prod_7;	
	
	wire e0_s,e1_s,e2_s,e3_s,e4_s,e5_s,e6_s,e7_s;	

	assign e0_s =( a[n-1] ~^ (b[1]&~b[0] | b[1]))|  ~b[1]&~b[0] ;
	assign e1_s =( a[n-1] ~^ (b[3]&~b[2] | b[3] & ~b[1])) | ~b[3]&~b[2]&~b[1] | b[3] & b[2] & b[1] ;
	assign e2_s =( a[n-1] ~^ (b[5]&~b[4] | b[5] & ~b[3])) | ~b[5]&~b[4]&~b[3] | b[5] & b[4] & b[3] ;
	assign e3_s =( a[n-1] ~^ (b[7]&~b[6] | b[7] & ~b[5])) | ~b[7]&~b[6]&~b[5]| b[7] & b[6] & b[5] ;
	assign e4_s =( a[n-1] ~^ (b[9]&~b[8] | b[9] & ~b[7])) | ~b[9]&~b[8]&~b[7] | b[9] & b[8] & b[7] ;
	assign e5_s =( a[n-1] ~^ (b[11]&~b[10] | b[11] & ~b[9])) | ~b[11]&~b[10]&~b[9]| b[11] & b[10] & b[9] ;
	assign e6_s = ( a[n-1] ~^ (b[13]&~b[12] | b[13] & ~b[11]) ) | ~b[13]&~b[12]&~b[11] | b[13] & b[12] & b[11] ;
	assign e7_s = (a[n-1] ~^ (b[15]&~b[14] | b[15] & ~b[13])) | ~b[15]&~b[14]&~b[13] | b[15] & b[14] & b[13] ;
	
		//generate Neg_cin
    //neglect Neg_cin[7]
    wire [7:0] Neg_cin;    
    assign Neg_cin[0] = b[1];
    assign Neg_cin[1] = b[3]&~b[2]&~b[1]| b[3]&~b[2]&b[1] | b[3]&b[2]&~b[1];                
    assign Neg_cin[2] = b[5]&~b[4]&~b[3]| b[5]&~b[4]&b[3] | b[5]&b[4]&~b[3];
    assign Neg_cin[3] = b[7]&~b[6]&~b[5]| b[7]&~b[6]&b[5] | b[7]&b[6]&~b[5];
    assign Neg_cin[4] = b[9]&~b[8]&~b[7]| b[9]&~b[8]&b[7] | b[9]&b[8]&~b[7]; 
    assign Neg_cin[5] = b[11]&~b[10]&~b[9]| b[11]&~b[10]&b[9] | b[11]&b[10]&~b[9];
    assign Neg_cin[6] = b[13]&~b[12]&~b[11]| b[13]&~b[12]&b[11] | b[13]&b[12]&~b[11]; 
              	
	assign prod_0 = {e0_s,~e0_s,~e0_s,prod0_temp};
	assign prod_1 = {1'b1,e1_s,prod1_temp,1'b0,Neg_cin[0]};
	assign prod_2 = {1'b1,e2_s,prod2_temp,1'b0,Neg_cin[1]};	
	assign prod_3 = {1'b1,e3_s,prod3_temp,1'b0,Neg_cin[2]};	
	assign prod_4 = {1'b1,e4_s,prod4_temp,1'b0,Neg_cin[3]};	
	assign prod_5 = {1'b1,e5_s,prod5_temp,1'b0,Neg_cin[4]};
	assign prod_6 = {1'b1,e6_s,prod6_temp,1'b0,Neg_cin[5]};
	assign prod_7 = {1'b1,e7_s,prod7_temp,1'b0,Neg_cin[6]};	
	
   // wire [31:0] result_temp;
	//Wallace Tree
	wallace_tree u_watree(.prod0(prod_0),.prod1(prod_1),.prod2(prod_2),.prod3(prod_3),
							.prod4(prod_4),.prod5(prod_5),.prod6(prod_6),.prod7(prod_7),.result(result));
   // assign result = result_temp + {Neg_cin[7],14'b0};
	
	
	assign Neg_cin[7] = b[15]&~b[14]&~b[13]| b[15]&~b[14]&b[13] | b[15]&b[14]&~b[13]; 
endmodule
