
module top
#(parameter
	n     = 16 //length of original number
)

(
   input  wire [n-1  :0] a,
   input  wire [n-1  :0] b,
   output wire [2*n-1:0] result
);

   wire [15:0] PP [15:0];

   genvar i, j;
   generate
      for (i=0; i<16; i=i+1) 
      begin
         for (j=0; j<16; j=j+1)
         begin
            if ( i+j<8 )
               assign PP[i][j] = 0;
            else
               assign PP[i][j] = a[i] & b[j];   
         end
      end
   endgenerate

   wire [15:0] APP [15:0];
   genvar k;
   /* ann */
   generate
      for (k=0; k<16; k=k+1) 
      begin
         assign APP[k][k] = PP[k][k];   
      end
   endgenerate
   /* gij */
   generate
      for (i=0; i<16; i=i+1) 
      begin
         for (j=0; j<i; j=j+1)
         begin
            if ( i+j<8 )
               assign APP[i][j] = 0;
            else if (i==1&&j==0 || i==2&&j==0 || i==15&&j==13 || i==15&&j==14)
               assign APP[i][j] = PP[i][j];
            else
               assign APP[i][j] = a[i] & b[j] & a[j] & b[i];      
         end
      end
   endgenerate
   /* pij */
   generate
      for (j=0; j<16; j=j+1) 
      begin
         for (i=0; i<j; i=i+1)
         begin
            if ( i+j<8 )
               assign APP[i][j] = 0;
            else if (i==0&&j==1 || i==0&&j==2 || i==13&&j==15 || i==14&&j==15)
               assign APP[i][j] = PP[i][j];
            else
               assign APP[i][j] = a[i] & b[j] | a[j] & b[i];      
         end
      end
   endgenerate

   
   /*------------------------------------Layer 1------------------------------------------- */
   wire [2:0] one8;
   wire [4:0] one9, one10;
   wire [5:0] one11, one12, one13, one14, one15, one16,
              one17, one18, one19, one20, one21;
   wire [3:0] one22;
   wire [2:0] one23, one24;
   wire [3:0] one25, one26, one27, one28;
   
   /* one8 */
   ACP ACP0 (.sum(one8[0]), .cout(one9[1]), .x1(APP[7][1]), .x2(APP[6][2]), .x3(APP[5][3]), .x4(APP[4][4]));
   assign         one8[1] = APP[3][5] | APP[2][6] | APP[1][7] | APP[0][8];
   assign         one8[2] = APP[8][0];
   /* one9 */
   ACP ACP1 (.sum(one9[0]), .cout(one10[1]), .x1(APP[8][1]), .x2(APP[7][2]), .x3(APP[6][3]), .x4(APP[5][4]));
   // one9[1] has got value in 'one8'
   assign         one9[2] = APP[4][5] | APP[3][6] | APP[2][7];
   assign         one9[3] = APP[1][8] | APP[0][9];
   assign         one9[4] = APP[9][0];
   /* one10 */
   AFA AFA0 (.sum(one10[0]), .cout(one11[1]), .x1(APP[10][0]), .x2(APP[9][1]), .cin(APP[8][2])) ;
   // 
   assign         one10[2] = APP[4][6] | APP[3][7] | APP[2][8];
   assign         one10[3] = APP[1][9] | APP[0][10];
   AFA AFA1 (.sum(one10[4]), .cout(one11[5]), .x1(APP[7][3]), .x2(APP[6][4]), .cin(APP[5][5])) ;
   /* one11 */
   AFA AFA2 (.sum(one11[0]), .cout(one12[1]), .x1(APP[11][0]), .x2(APP[10][1]), .cin(APP[9][2])) ;
   //1
   assign         one11[2] = APP[5][6] | APP[4][7] | APP[3][8];
   assign         one11[3] = APP[2][9] | APP[11][0] | APP[0][11];
   AFA AFA3 (.sum(one11[4]), .cout(one12[5]), .x1(APP[8][3]), .x2(APP[7][4]), .cin(APP[6][5])) ;
   //5
   /* one12 */
   ACP ACP2 (.sum(one12[0]), .cout(one13[1]), .x1(APP[12][0]), .x2(APP[11][1]), .x3(APP[10][2]), .x4(APP[9][3]));
   //1
   assign         one12[2] = APP[5][7]  | APP[4][8]  | APP[3][9];
   assign         one12[3] = APP[2][10] | APP[1][11] | APP[0][12];
   AFA AFA4 (.sum(one12[4]), .cout(one13[5]), .x1(APP[8][4]), .x2(APP[7][5]), .cin(APP[6][6])) ;
   //5
   /* one13 */
   ACP ACP3 (.sum(one13[0]), .cout(one14[1]), .x1(APP[13][0]), .x2(APP[12][1]), .x3(APP[11][2]), .x4(APP[10][3]));
   //1
   assign         one13[2] = APP[6][7]  | APP[5][8]  | APP[4][9] | APP[3][10];
   assign         one13[3] = APP[2][11] | APP[1][12] | APP[0][13];
   AFA AFA5 (.sum(one13[4]), .cout(one14[5]), .x1(APP[9][4]), .x2(APP[8][5]), .cin(APP[7][6])) ;
   //5
   /* one14 */
   ACP ACP4 (.sum(one14[0]), .cout(one15[1]), .x1(APP[14][0]), .x2(APP[13][1]), .x3(APP[12][2]), .x4(APP[11][3]));
   //1
   assign         one14[2] = APP[6][8]  | APP[5][9]  | APP[4][10] | APP[3][11];
   assign         one14[3] = APP[2][12] | APP[1][13] | APP[0][14];
   ACP ACP5 (.sum(one14[4]), .cout(one15[5]), .x1(APP[10][4]), .x2(APP[9][5]), .x3(APP[8][6]), .x4(APP[7][7]));
   //5
   /* one15 */
   ACP ACP6 (.sum(one15[0]), .cout(one16[1]), .x1(APP[15][0]), .x2(APP[14][1]), .x3(APP[13][2]), .x4(APP[12][3]));
   //1
   assign         one15[2] = APP[7][8]  | APP[6][9]  | APP[5][10] | APP[4][11];
   assign         one15[3] = APP[3][12] | APP[2][13] | APP[1][14] | APP[0][15];
   ACP ACP7 (.sum(one15[4]), .cout(one16[5]), .x1(APP[11][4]), .x2(APP[10][5]), .x3(APP[9][6]), .x4(APP[8][7]));
   //5
   /* one16 */
   ACP ACP8 (.sum(one16[0]), .cout(one17[1]), .x1(APP[15][1]), .x2(APP[14][2]), .x3(APP[13][3]), .x4(APP[12][4]));
   //1
   assign         one16[2] = APP[7][9]  | APP[6][10] | APP[5][11] | APP[4][12];
   assign         one16[3] = APP[3][13] | APP[2][14] | APP[1][15];
   ACP ACP9 (.sum(one16[4]), .cout(one17[5]), .x1(APP[11][5]), .x2(APP[10][6]), .x3(APP[9][7]), .x4(APP[8][8]));
   //5
   /* one17 */
   ACP ACP10(.sum(one17[0]), .cout(one18[1]), .x1(APP[15][2]), .x2(APP[14][3]), .x3(APP[13][4]), .x4(APP[12][5]));
   //1
   assign         one17[2] = APP[8][9]  | APP[7][10] | APP[6][11] | APP[5][12];
   assign         one17[3] = APP[4][13] | APP[3][14] | APP[2][15];
   AFA AFA6 (.sum(one17[4]), .cout(one18[5]), .x1(APP[11][6]), .x2(APP[10][7]), .cin(APP[9][8])) ;
   //5
   /* one18 */
   ACP ACP11(.sum(one18[0]), .cout(one19[1]), .x1(APP[15][3]), .x2(APP[14][4]), .x3(APP[13][5]), .x4(APP[12][6]));
   //1
   assign         one18[2] = APP[8][10] | APP[7][11] | APP[6][12];
   assign         one18[3] = APP[5][13] | APP[4][14] | APP[3][15];
   AFA AFA7 (.sum(one18[4]), .cout(one19[5]), .x1(APP[11][7]), .x2(APP[10][8]), .cin(APP[9][9])) ;
   //5
   /* one19 */
   AFA AFA8 (.sum(one19[0]), .cout(one20[1]), .x1(APP[15][4]), .x2(APP[14][5]), .cin(APP[13][6])) ;
   //1
   assign         one19[2] = APP[9][10] | APP[8][11] | APP[7][12];
   assign         one19[3] = APP[6][13] | APP[5][14] | APP[4][15];
   AFA AFA9 (.sum(one19[4]), .cout(one20[5]), .x1(APP[12][7]), .x2(APP[11][8]), .cin(APP[10][9])) ;
   //5
   /* one20 */
   AFA AFA10(.sum(one20[0]), .cout(one21[1]), .x1(APP[15][5]), .x2(APP[14][6]), .cin(APP[13][7])) ;
   //1
   assign         one20[2] = APP[9][11] | APP[8][12] | APP[7][13];
   assign         one20[3] = APP[6][14] | APP[5][15];
   AFA AFA11(.sum(one20[4]), .cout(one21[5]), .x1(APP[12][8]), .x2(APP[11][9]), .cin(APP[10][10])) ;
   //5
   /* one21 */
   ACP ACP12(.sum(one21[0]), .cout(one22[1]), .x1(APP[14][7]), .x2(APP[13][8]), .x3(APP[12][9]), .x4(APP[11][10]));
   //1
   assign         one21[2] = APP[10][11] | APP[9][12] | APP[8][13];
   assign         one21[3] = APP[7][14]  | APP[6][15];
   assign         one21[4] = APP[15][6];
   //5
   /* one22 */
   ACP ACP13(.sum(one22[0]), .cout(one23[1]), .x1(APP[14][8]), .x2(APP[13][9]), .x3(APP[12][10]), .x4(APP[11][11]));
   //1
   assign         one22[2] = APP[10][12] | APP[9][13] | APP[8][14] | APP[7][15];
   assign         one22[3] = APP[15][7];
   /* one23 */
   wire cone23;
   ACP ACP14(.sum(one23[0]), .cout(cone23), .x1(APP[15][8]), .x2(APP[14][9]), .x3(APP[13][10]), .x4(APP[12][11]));
   //1
   assign         one23[2] = APP[11][12] | APP[10][13] | APP[9][14] | APP[8][15];
   /* -------Accurate Region-------- */
   /* one24 */
   wire cone24;
   ECP ECP0 (.sum(one24[0]), .carry(one25[1]), .cin(cone23), .cout(cone24), .x1(APP[15][9]), .x2(APP[14][10]), .x3(APP[13][11]), .x4(APP[12][12]));
   assign         one24[1] = APP[11][13];
   EHA EHA0 (.sum(one24[2] ), .cout(one25[3] ), .x1(APP[10][14]), .x2(APP[9][15])) ;
   /* one25 */
   wire cone25;
   ECP ECP1 (.sum(one25[0]), .carry(one26[1]), .cin(cone24), .cout(cone25), .x1(APP[15][10]), .x2(APP[14][11]), .x3(APP[13][12]), .x4(APP[12][13]));
   //1
   EHA EHA1 (.sum(one25[2] ), .cout(one26[3] ), .x1(APP[11][14]), .x2(APP[10][15])) ;
   //3
   /* one26 */
   wire cone26;
   ECP ECP2 (.sum(one26[0]), .carry(one27[1]), .cin(cone25), .cout(cone26), .x1(APP[15][11]), .x2(APP[14][12]), .x3(APP[13][13]), .x4(APP[12][14]));
   //1
   assign         one26[2] = APP[11][15]; 
   //3
   /* one27 */
   EFA EFA0 (.sum(one27[0]), .cout(one28[1]), .x1(APP[15][12]), .x2(APP[14][13]), .cin(cone26)) ;
   //1
   assign         one27[2] = APP[13][14]; 
   assign         one27[3] = APP[12][15]; 
   /* one28 */
   assign         one28[0] = APP[15][13]; 
   //1
   assign         one28[2] = APP[14][14]; 
   assign         one28[3] = APP[13][15]; 


    /*------------------------------------Layer 2------------------------------------------- */
   wire two8;
   wire [2:0] two9, two10, two11;  /* two11 should be here!([2:0]) */
   wire [3:0] two12, two13, two14, two15, two16, two17, two18, two19, two20, two21;
   wire [2:0] two22;
   wire [1:0] two23, two24, two25, two26, two27, two28, two29, two30;

   /* two8 */
   AFA AFA12(.sum(two8), .cout(two9[1]), .x1(one8[0]), .x2(one8[1]), .cin(one8[2])) ;
   /* two9 */
   ACP ACP15(.sum(two9[0]), .cout(two10[1]), .x1(one9[0]), .x2(one9[1]), .x3(one9[2]), .x4(one9[3]));
   //1
   assign         two9[2] = one9[4];
   /* two10 */
   ACP ACP16(.sum(two10[0]), .cout(two11[1]), .x1(one10[0]), .x2(one10[1]), .x3(one10[2]), .x4(one10[3]));
   //1
   assign         two10[2] = one10[4];
   /* two11 */
   AFA AFA13(.sum(two11[0]), .cout(two12[1]), .x1(one11[0]), .x2(one11[1]), .cin(one11[2])) ;
   //1
   AFA AFA14(.sum(two11[2]), .cout(two12[3]), .x1(one11[3]), .x2(one11[4]), .cin(one11[5])) ;

   /* two12 */
   AFA AFA15(.sum(two12[0]), .cout(two13[1]), .x1(one12[0]), .x2(one12[1]), .cin(one12[2])) ;
   //1
   AFA AFA16(.sum(two12[2]), .cout(two13[3]), .x1(one12[3]), .x2(one12[4]), .cin(one12[5])) ;
   //3
   /* two13-21 */
   AFA AFA17(.sum(two13[0]), .cout(two14[1]), .x1(one13[0]), .x2(one13[1]), .cin(one13[2])) ;
   AFA AFA18(.sum(two13[2]), .cout(two14[3]), .x1(one13[3]), .x2(one13[4]), .cin(one13[5])) ;

   AFA AFA19(.sum(two14[0]), .cout(two15[1]), .x1(one14[0]), .x2(one14[1]), .cin(one14[2])) ;
   AFA AFA20(.sum(two14[2]), .cout(two15[3]), .x1(one14[3]), .x2(one14[4]), .cin(one14[5])) ;

   AFA AFA21(.sum(two15[0]), .cout(two16[1]), .x1(one15[0]), .x2(one15[1]), .cin(one15[2])) ;
   AFA AFA22(.sum(two15[2]), .cout(two16[3]), .x1(one15[3]), .x2(one15[4]), .cin(one15[5])) ;

   AFA AFA23(.sum(two16[0]), .cout(two17[1]), .x1(one16[0]), .x2(one16[1]), .cin(one16[2])) ;
   AFA AFA24(.sum(two16[2]), .cout(two17[3]), .x1(one16[3]), .x2(one16[4]), .cin(one16[5])) ;

   AFA AFA25(.sum(two17[0]), .cout(two18[1]), .x1(one17[0]), .x2(one17[1]), .cin(one17[2])) ;
   AFA AFA26(.sum(two17[2]), .cout(two18[3]), .x1(one17[3]), .x2(one17[4]), .cin(one17[5])) ;

   AFA AFA27(.sum(two18[0]), .cout(two19[1]), .x1(one18[0]), .x2(one18[1]), .cin(one18[2])) ;
   AFA AFA28(.sum(two18[2]), .cout(two19[3]), .x1(one18[3]), .x2(one18[4]), .cin(one18[5])) ;

   AFA AFA29(.sum(two19[0]), .cout(two20[1]), .x1(one19[0]), .x2(one19[1]), .cin(one19[2])) ;
   AFA AFA30(.sum(two19[2]), .cout(two20[3]), .x1(one19[3]), .x2(one19[4]), .cin(one19[5])) ;

   AFA AFA31(.sum(two20[0]), .cout(two21[1]), .x1(one20[0]), .x2(one20[1]), .cin(one20[2])) ;
   AFA AFA32(.sum(two20[2]), .cout(two21[3]), .x1(one20[3]), .x2(one20[4]), .cin(one20[5])) ;

   AFA AFA33(.sum(two21[0]), .cout(two22[1]), .x1(one21[0]), .x2(one21[1]), .cin(one21[2])) ;
   AFA AFA34(.sum(two21[2]), .cout(two22[2]),/*notice[2]*/ .x1(one21[3]), .x2(one21[4]), .cin(one21[5])) ;

   /* two22 */
   ACP ACP17(.sum(two22[0]), .cout(two23[1]), .x1(one22[0]), .x2(one22[1]), .x3(one22[2]), .x4(one22[3]));
   //1
   //2

   /* two23 */
   wire ctwo23;
   AFA AFA35(.sum(two23[0]), .cout(ctwo23), .x1(one23[0]), .x2(one23[1]), .cin(one23[2])) ;
   //1

   /* -------Accurate Region-------- */
   /* two24 */
   EFA EFA1 (.sum(two24[0]), .cout(two25[1]), .x1(one24[0]), .x2(one24[1]), .cin(ctwo23)) ;
   assign two24[1] = one24[2];
   /* two25-28 */
   wire ctwo24, ctwo25, ctwo26, ctwo27, ctwo28;
   assign ctwo24 = 0;
   ECP ECP3 (.sum(two25[0]), .carry(two26[1]), .cin(ctwo24), .cout(ctwo25), .x1(one25[0]), .x2(one25[1]), .x3(one25[2]), .x4(one25[3]));

   ECP ECP4 (.sum(two26[0]), .carry(two27[1]), .cin(ctwo25), .cout(ctwo26), .x1(one26[0]), .x2(one26[1]), .x3(one26[2]), .x4(one26[3]));

   ECP ECP5 (.sum(two27[0]), .carry(two28[1]), .cin(ctwo26), .cout(ctwo27), .x1(one27[0]), .x2(one27[1]), .x3(one27[2]), .x4(one27[3]));

   ECP ECP6 (.sum(two28[0]), .carry(two29[1]), .cin(ctwo27), .cout(ctwo28), .x1(one28[0]), .x2(one28[1]), .x3(one28[2]), .x4(one28[3]));

   /* two29 */
   EFA EFA2 (.sum(two29[0]), .cout(two30[1]), .x1(APP[15][14]), .x2(APP[14][15]), .cin(ctwo28)) ;
   //1

   /* two30 */
   assign two30[0] = APP[15][15];
   //1

   /*------------------------------------Layer 3------------------------------------------- */
   wire [19:0] the1, the2;
   wire rst8, rst9;
   assign         rst8 = two8;
   AFA AFA36(.sum(rst9   ), .cout(the2[0]), .x1(two9[0]), .x2(two9[1]), .cin(two9[2])) ;
   AFA AFA37(.sum(the1[0]), .cout(the2[1]), .x1(two10[0]), .x2(two10[1]), .cin(two10[2])) ;
   AFA AFA38(.sum(the1[1]), .cout(the2[2]), .x1(two11[0]), .x2(two11[1]), .cin(two11[2])) ;

   ACP ACP18(.sum(the1[2]), .cout(the2[3]), .x1(two12[0]), .x2(two12[1]), .x3(two12[2]), .x4(two12[3]));
   ACP ACP19(.sum(the1[3]), .cout(the2[4]), .x1(two13[0]), .x2(two13[1]), .x3(two13[2]), .x4(two13[3]));
   ACP ACP20(.sum(the1[4]), .cout(the2[5]), .x1(two14[0]), .x2(two14[1]), .x3(two14[2]), .x4(two14[3]));
   ACP ACP21(.sum(the1[5]), .cout(the2[6]), .x1(two15[0]), .x2(two15[1]), .x3(two15[2]), .x4(two15[3]));
   ACP ACP22(.sum(the1[6]), .cout(the2[7]), .x1(two16[0]), .x2(two16[1]), .x3(two16[2]), .x4(two16[3]));
   ACP ACP23(.sum(the1[7]), .cout(the2[8]), .x1(two17[0]), .x2(two17[1]), .x3(two17[2]), .x4(two17[3]));
   ACP ACP24(.sum(the1[8]), .cout(the2[9]), .x1(two18[0]), .x2(two18[1]), .x3(two18[2]), .x4(two18[3]));
   ACP ACP25(.sum(the1[9]), .cout(the2[10]), .x1(two19[0]), .x2(two19[1]), .x3(two19[2]), .x4(two19[3]));
   ACP ACP26(.sum(the1[10]), .cout(the2[11]), .x1(two20[0]), .x2(two20[1]), .x3(two20[2]), .x4(two20[3]));
   ACP ACP27(.sum(the1[11]), .cout(the2[12]), .x1(two21[0]), .x2(two21[1]), .x3(two21[2]), .x4(two21[3]));

   AFA AFA39(.sum(the1[12]), .cout(the2[13]), .x1(two22[0]), .x2(two22[1]), .cin(two22[2])) ;
   AHA AHA0 (.sum(the1[13]), .cout(the2[14]), .x1(two23[0]), .x2(two23[1]));
   /* -------Accurate Region-------- */
   EHA EHA2 (.sum(the1[14]), .cout(the2[15]), .x1(two24[0]), .x2(two24[1]));
   EHA EHA3 (.sum(the1[15]), .cout(the2[16]), .x1(two25[0]), .x2(two25[1]));
   EHA EHA4 (.sum(the1[16]), .cout(the2[17]), .x1(two26[0]), .x2(two26[1]));
   EHA EHA5 (.sum(the1[17]), .cout(the2[18]), .x1(two27[0]), .x2(two27[1]));
   EHA EHA6 (.sum(the1[18]), .cout(the2[19]), .x1(two28[0]), .x2(two28[1]));

   wire the1_20, the2_20, the2_21;
   EHA EHA7 (.sum(the1[19]), .cout(the2_20), .x1(two29[0]), .x2(two29[1]));
   EHA EHA8 (.sum(the1_20 ), .cout(the2_21), .x1(two30[0]), .x2(two30[1]));


   /*-----------------------------Layer 4( CLA )----------------------------- */
   wire [20:0] temp_rst;
   
   MCLA_20_c MCLA_20_c
   (
   .a(the1),  /* [19:0] */ 
   .b(the2),  /* [19:0] */
   .s(temp_rst)
   );

   wire crst30, rst30, rst31;
   EFA EFA3 (
   .sum(rst30), 
   .cout(crst30), 
   .x1(the1_20), 
   .x2(the2_20), 
   .cin(temp_rst[20])
   );

   assign rst31 = the2_21 | crst30;

   assign result = {rst31, rst30, temp_rst[19:0], rst9, rst8, 8'b0};


endmodule 
