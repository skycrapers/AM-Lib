`timescale 1ns / 1ps

module top
#(parameter
    HOR   = 8, //要舍弃的行数
    VER   = 16  //要舍弃的列数
)
(
    input   [15:0]a,
    input   [15:0]b,
    output  [31:0]result
);

wire [15:0] A,B;
    wire [15:0]c0,out1;
    wire [14:0]Co1;
assign A = a;
assign B = b;
    genvar i;
    if(HOR==0)begin
        for(i=VER; i<16; i=i+1)
        begin: gen1
            assign c0[i]=A[i]&B[0];
        end
        for(i=0; i<VER; i=i+1)
        begin: len1
            assign c0[i]=1'b0;
        end  
    end
    else 
        assign c0=16'b0000000000000000;


    genvar m1;
    genvar n1;
    generate
        assign out1[15]=A[15]&B[1];
        if(HOR==0 && VER>1)begin
            for(m1=VER-1; m1<15; m1=m1+1)
            begin:gen2
                mul_one u(A[m1],B[1],1'b0,c0[m1+1],out1[m1],Co1[m1]);
            end
            for(n1=0; n1<VER-1; n1=n1+1)
            begin:zen1
                assign out1[n1]=1'b0;
                assign Co1[n1]=1'b0;
            end
        end
        else if (HOR==0 && VER<=1) begin
            for(m1=0; m1<15; m1=m1+1)
            begin:pen1
                mul_one u(A[m1],B[1],1'b0,c0[m1+1],out1[m1],Co1[m1]);  
            end 
        end
        else if(HOR==1 && VER<2) begin
            for(m1=0; m1<15; m1=m1+1)
            begin: len1
                assign out1[m1]=A[m1]&B[HOR];
            end     
            assign Co1=15'b000000000000000; 
        end
        else if (HOR==1 && VER>=2) begin
            for(m1=VER-1; m1<15; m1=m1+1)
            begin: ken1
                assign out1[m1]=A[m1]&B[HOR];
            end  
            for(n1=0; n1<VER-1; n1=n1+1)
            begin: jen1
                assign out1[n1]=1'b0;
            end     
            assign Co1=15'b000000000000000; 
        end
        else begin
            assign out1[14:0]=15'b000000000000000;
            assign Co1=15'b000000000000000;
        end  
    endgenerate

    wire [15:0]out2;
    wire [14:0]Co2;


    genvar m2;
    genvar n2;
    generate
        assign out2[15]=A[15]&B[2];
        if(HOR<=1&& VER>2)begin
            for(m2=VER-2; m2<15; m2=m2+1)
            begin:gen3
                mul_one u(A[m2],B[2],Co1[m2],out1[m2+1],out2[m2],Co2[m2]);
            end
            for(n2=0; n2<VER-2; n2=n2+1)
            begin:zen2
                assign out2[n2]=1'b0;
                assign Co2[n2]=1'b0;
            end
        end
        else if (HOR<=1 && VER<=2) begin
            for(m2=0; m2<15; m2=m2+1)
            begin:pen2
                mul_one u(A[m2],B[2],Co1[m2],out1[m2+1],out2[m2],Co2[m2]);  
            end 
        end
        else if(HOR==2 && VER<3) begin
            for(m2=0; m2<15; m2=m2+1)
            begin: len2
                assign out2[m2]=A[m2]&B[HOR];
            end     
            assign Co2=15'b000000000000000; 
        end
        else if (HOR==2 && VER>=3) begin
            for(m2=VER-2; m2<15; m2=m2+1)
            begin: ken2
                assign out2[m2]=A[m2]&B[HOR];
            end  
            for(n2=0; n2<VER-2; n2=n2+1)
            begin: jen2
                assign out2[n2]=1'b0;
            end     
            assign Co2=15'b000000000000000; 
        end
        else begin
            assign out2[14:0]=15'b000000000000000;
            assign Co2=15'b000000000000000;
        end  
    endgenerate

    wire [15:0]out3;
    wire [14:0]Co3;

    genvar m3;
    genvar n3;
    generate
        assign out3[15]=A[15]&B[3];
        if(HOR<=2&& VER>3)begin
            for(m3=VER-3; m3<15; m3=m3+1)
            begin:gen4
                mul_one u(A[m3],B[3],Co2[m3],out2[m3+1],out3[m3],Co3[m3]);
            end
            for(n3=0; n3<VER-3; n3=n3+1)
            begin:zen3
                assign out3[n3]=1'b0;
                assign Co3[n3]=1'b0;
            end
        end
        else if (HOR<=2 && VER<=3) begin
            for(m3=0; m3<15; m3=m3+1)
            begin:pen3
                mul_one u(A[m3],B[3],Co2[m3],out2[m3+1],out3[m3],Co3[m3]);  
            end 
        end
        else if(HOR==3 && VER<4) begin
            for(m3=0; m3<15; m3=m3+1)
            begin: len3
                assign out3[m3]=A[m3]&B[HOR];
            end     
            assign Co3=15'b000000000000000; 
        end
        else if (HOR==3 && VER>=4) begin
            for(m3=VER-3; m3<15; m3=m3+1)
            begin: ken3
                assign out3[m3]=A[m3]&B[HOR];
            end  
            for(n3=0; n3<VER-3; n3=n3+1)
            begin: jen3
                assign out3[n3]=1'b0;
            end     
            assign Co3=15'b000000000000000; 
        end
        else begin
            assign out3[14:0]=15'b000000000000000;
            assign Co3=15'b000000000000000;
        end  
    endgenerate

    wire [15:0]out4;
    wire [14:0]Co4;

    genvar m4;
    genvar n4;
    generate
        assign out4[15]=A[15]&B[4];
        if(HOR<=3&& VER>4)begin
            for(m4=VER-4; m4<15; m4=m4+1)
            begin:gen5
                mul_one u(A[m4],B[4],Co3[m4],out3[m4+1],out4[m4],Co4[m4]);
            end
            for(n4=0; n4<VER-4; n4=n4+1)
            begin:zen4
                assign out4[n4]=1'b0;
                assign Co4[n4]=1'b0;
            end
        end
        else if (HOR<=3 && VER<=4) begin
            for(m4=0; m4<15; m4=m4+1)
            begin:pen4
                mul_one u(A[m4],B[4],Co3[m4],out3[m4+1],out4[m4],Co4[m4]);  
            end 
        end
        else if(HOR==4 && VER<5) begin
            for(m4=0; m4<15; m4=m4+1)
            begin: len4
                assign out4[m4]=A[m4]&B[HOR];
            end     
            assign Co4=15'b000000000000000; 
        end
        else if (HOR==4 && VER>=5) begin
            for(m4=VER-4; m4<15; m4=m4+1)
            begin: ken4
                assign out4[m4]=A[m4]&B[HOR];
            end  
            for(n4=0; n4<VER-4; n4=n4+1)
            begin: jen4
                assign out4[n4]=1'b0;
            end     
            assign Co4=15'b000000000000000; 
        end
        else begin
            assign out4[14:0]=15'b000000000000000;
            assign Co4=15'b000000000000000;
        end  
    endgenerate


    wire [15:0] out5;
    wire [14:0] Co5;

    genvar m5;
    genvar n5;
    generate
        assign out5[15]=A[15]&B[5];
        if(HOR<=4&& VER>5)begin
            for(m5=VER-5; m5<15; m5=m5+1)
            begin:gen6
                mul_one u(A[m5],B[5],Co4[m5],out4[m5+1],out5[m5],Co5[m5]);
            end
            for(n5=0; n5<VER-5; n5=n5+1)
            begin:zen5
                assign out5[n5]=1'b0;
                assign Co5[n5]=1'b0;
            end
        end
        else if (HOR<=4 && VER<=5) begin
            for(m5=0; m5<15; m5=m5+1)
            begin:pen5
                mul_one u(A[m5],B[5],Co4[m5],out4[m5+1],out5[m5],Co5[m5]);  
            end 
        end
        else if(HOR==5 && VER<6) begin
            for(m5=0; m5<15; m5=m5+1)
            begin: len5
                assign out5[m5]=A[m5]&B[HOR];
            end     
            assign Co5=15'b000000000000000; 
        end
        else if (HOR==5 && VER>=6) begin
            for(m5=VER-5; m5<15; m5=m5+1)
            begin: ken5
                assign out5[m5]=A[m5]&B[HOR];
            end  
            for(n5=0; n5<VER-5; n5=n5+1)
            begin: jen5
                assign out5[n5]=1'b0;
            end     
            assign Co5=15'b000000000000000; 
        end
        else begin
            assign out5[14:0]=15'b000000000000000;
            assign Co5=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out6;
    wire [14:0] Co6;

    genvar m6;
    genvar n6;
    generate
        assign out6[15]=A[15]&B[6];
        if(HOR<=5&& VER>6)begin
            for(m6=VER-6; m6<15; m6=m6+1)
            begin:gen7
                mul_one u(A[m6],B[6],Co5[m6],out5[m6+1],out6[m6],Co6[m6]);
            end
            for(n6=0; n6<VER-6; n6=n6+1)
            begin:zen6
                assign out6[n6]=1'b0;
                assign Co6[n6]=1'b0;
            end
        end
        else if (HOR<=5 && VER<=6) begin
            for(m6=0; m6<15; m6=m6+1)
            begin:pen6
                mul_one u(A[m6],B[6],Co5[m6],out5[m6+1],out6[m6],Co6[m6]);  
            end 
        end
        else if(HOR==6 && VER<7) begin
            for(m6=0; m6<15; m6=m6+1)
            begin: len6
                assign out6[m6]=A[m6]&B[HOR];
            end     
            assign Co6=15'b000000000000000; 
        end
        else if (HOR==6 && VER>=7) begin
            for(m6=VER-6; m6<15; m6=m6+1)
            begin: ken6
                assign out6[m6]=A[m6]&B[HOR];
            end  
            for(n6=0; n6<VER-6; n6=n6+1)
            begin: jen6
                assign out6[n6]=1'b0;
            end     
            assign Co6=15'b000000000000000; 
        end
        else begin
            assign out6[14:0]=15'b000000000000000;
            assign Co6=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out7;
    wire [14:0] Co7;

    genvar m7;
    genvar n7;
    generate
        assign out7[15]=A[15]&B[7];
        if(HOR<=6&& VER>7)begin
            for(m7=VER-7; m7<15; m7=m7+1)
            begin:gen8
                mul_one u(A[m7],B[7],Co6[m7],out6[m7+1],out7[m7],Co7[m7]);
            end
            for(n7=0; n7<VER-7; n7=n7+1)
            begin:zen7
                assign out7[n7]=1'b0;
                assign Co7[n7]=1'b0;
            end
        end
        else if (HOR<=6 && VER<=7) begin
            for(m7=0; m7<15; m7=m7+1)
            begin:pen7
                mul_one u(A[m7],B[7],Co6[m7],out6[m7+1],out7[m7],Co7[m7]);  
            end 
        end
        else if(HOR==7 && VER<8) begin
            for(m7=0; m7<15; m7=m7+1)
            begin: len7
                assign out7[m7]=A[m7]&B[HOR];
            end     
            assign Co7=15'b000000000000000; 
        end
        else if (HOR==7 && VER>=8) begin
            for(m7=VER-7; m7<15; m7=m7+1)
            begin: ken7
                assign out7[m7]=A[m7]&B[HOR];
            end  
            for(n7=0; n7<VER-7; n7=n7+1)
            begin: jen7
                assign out7[n7]=1'b0;
            end     
            assign Co7=15'b000000000000000; 
        end
        else begin
            assign out7[14:0]=15'b000000000000000;
            assign Co7=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out8;
    wire [14:0] Co8;

    genvar m8;
    genvar n8;
    generate
        assign out8[15]=A[15]&B[8];
        if(HOR<=7&& VER>8)begin
            for(m8=VER-8; m8<15; m8=m8+1)
            begin:gen9
                mul_one u(A[m8],B[8],Co7[m8],out7[m8+1],out8[m8],Co8[m8]);
            end
            for(n8=0; n8<VER-8; n8=n8+1)
            begin:zen8
                assign out8[n8]=1'b0;
                assign Co8[n8]=1'b0;
            end
        end
        else if (HOR<=7 && VER<=8) begin
            for(m8=0; m8<15; m8=m8+1)
            begin:pen8
                mul_one u(A[m8],B[8],Co7[m8],out7[m8+1],out8[m8],Co8[m8]);  
            end 
        end
        else if(HOR==8 && VER<9) begin
            for(m8=0; m8<15; m8=m8+1)
            begin: len8
                assign out8[m8]=A[m8]&B[HOR];
            end     
            assign Co8=15'b000000000000000; 
        end
        else if (HOR==8 && VER>=9) begin
            for(m8=VER-8; m8<15; m8=m8+1)
            begin: ken8
                assign out8[m8]=A[m8]&B[HOR];
            end  
            for(n8=0; n8<VER-8; n8=n8+1)
            begin: jen8
                assign out8[n8]=1'b0;
            end     
            assign Co8=15'b000000000000000; 
        end
        else begin
            assign out8[14:0]=15'b000000000000000;
            assign Co8=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out9;
    wire [14:0] Co9;

    genvar m9;
    genvar n9;
    generate
        assign out9[15]=A[15]&B[9];
        if(HOR<=8 && VER>9)begin
            for(m9=VER-9; m9<15; m9=m9+1)
            begin:gen10
                mul_one u(A[m9],B[9],Co8[m9],out8[m9+1],out9[m9],Co9[m9]);
            end
            for(n9=0; n9<VER-9; n9=n9+1)
            begin:zen9
                assign out9[n9]=1'b0;
                assign Co9[n9]=1'b0;
            end
        end
        else if (HOR<=8 && VER<=9) begin
            for(m9=0; m9<15; m9=m9+1)
            begin:pen9
                mul_one u(A[m9],B[9],Co8[m9],out8[m9+1],out9[m9],Co9[m9]);  
            end 
        end
        else if(HOR==9 && VER<10) begin
            for(m9=0; m9<15; m9=m9+1)
            begin: len9
                assign out9[m9]=A[m9]&B[HOR];
            end     
            assign Co9=15'b000000000000000; 
        end
        else if (HOR==9 && VER>=10) begin
            for(m9=VER-9; m9<15; m9=m9+1)
            begin: ken9
                assign out9[m9]=A[m9]&B[HOR];
            end  
            for(n9=0; n9<VER-9; n9=n9+1)
            begin: jen9
                assign out9[n9]=1'b0;
            end     
            assign Co9=15'b000000000000000; 
        end
        else begin
            assign out9[14:0]=15'b000000000000000;
            assign Co9=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out10;
    wire [14:0] Co10;

    genvar m10;
    genvar n10;
    generate
        assign out10[15]=A[15]&B[10];
        if(HOR<=9 && VER>10)begin
            for(m10=VER-10; m10<15; m10=m10+1)
            begin:gen11
                mul_one u(A[m10],B[10],Co9[m10],out9[m10+1],out10[m10],Co10[m10]);
            end
            for(n10=0; n10<VER-10; n10=n10+1)
            begin:zen10
                assign out10[n10]=1'b0;
                assign Co10[n10]=1'b0;
            end
        end
        else if (HOR<=9 && VER<=10) begin
            for(m10=0; m10<15; m10=m10+1)
            begin:pen10
                mul_one u(A[m10],B[10],Co9[m10],out9[m10+1],out10[m10],Co10[m10]);  
            end 
        end
        else if(HOR==10 && VER<11) begin
            for(m10=0; m10<15; m10=m10+1)
            begin: len10
                assign out10[m10]=A[m10]&B[HOR];
            end     
            assign Co10=15'b000000000000000; 
        end
        else if (HOR==10 && VER>=11) begin
            for(m10=VER-10; m10<15; m10=m10+1)
            begin: ken10
                assign out10[m10]=A[m10]&B[HOR];
            end  
            for(n10=0; n10<VER-10; n10=n10+1)
            begin: jen10
                assign out10[n10]=1'b0;
            end     
            assign Co10=15'b000000000000000; 
        end
        else begin
            assign out10[14:0]=15'b000000000000000;
            assign Co10=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out11;
    wire [14:0] Co11;

    genvar m11;
    genvar n11;
    generate
        assign out11[15]=A[15]&B[11];
        if(HOR<=10 && VER>11)begin
            for(m11=VER-11; m11<15; m11=m11+1)
            begin:gen12
                mul_one u(A[m11],B[11],Co10[m11],out10[m11+1],out11[m11],Co11[m11]);
            end
            for(n11=0; n11<VER-11; n11=n11+1)
            begin:zen11
                assign out11[n11]=1'b0;
                assign Co11[n11]=1'b0;
            end
        end
        else if (HOR<=10 && VER<=11) begin
            for(m11=0; m11<15; m11=m11+1)
            begin:pen11
                mul_one u(A[m11],B[11],Co10[m11],out10[m11+1],out11[m11],Co11[m11]);  
            end 
        end
        else if(HOR==11 && VER<12) begin
            for(m11=0; m11<15; m11=m11+1)
            begin: len11
                assign out11[m11]=A[m11]&B[HOR];
            end     
            assign Co11=15'b000000000000000; 
        end
        else if (HOR==11 && VER>=12) begin
            for(m11=VER-11; m11<15; m11=m11+1)
            begin: ken11
                assign out11[m11]=A[m11]&B[HOR];
            end  
            for(n11=0; n11<VER-11; n11=n11+1)
            begin: jen11
                assign out11[n11]=1'b0;
            end     
            assign Co11=15'b000000000000000; 
        end
        else begin
            assign out11[14:0]=15'b000000000000000;
            assign Co11=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out12;
    wire [14:0] Co12;

    genvar m12;
    genvar n12;
    generate
        assign out12[15]=A[15]&B[12];
        if(HOR<=11 && VER>12)begin
            for(m12=VER-12; m12<15; m12=m12+1)
            begin:gen13
                mul_one u(A[m12],B[12],Co11[m12],out11[m12+1],out12[m12],Co12[m12]);
            end
            for(n12=0; n12<VER-12; n12=n12+1)
            begin:zen12
                assign out12[n12]=1'b0;
                assign Co12[n12]=1'b0;
            end
        end
        else if (HOR<=11 && VER<=12) begin
            for(m12=0; m12<15; m12=m12+1)
            begin:pen12
                mul_one u(A[m12],B[12],Co11[m12],out11[m12+1],out12[m12],Co12[m12]);  
            end 
        end
        else if(HOR==12 && VER<13) begin
            for(m12=0; m12<15; m12=m12+1)
            begin: len12
                assign out12[m12]=A[m12]&B[HOR];
            end     
            assign Co12=15'b000000000000000; 
        end
        else if (HOR==12 && VER>=13) begin
            for(m12=VER-12; m12<15; m12=m12+1)
            begin: ken12
                assign out12[m12]=A[m12]&B[HOR];
            end  
            for(n12=0; n12<VER-12; n12=n12+1)
            begin: jen12
                assign out12[n12]=1'b0;
            end     
            assign Co12=15'b000000000000000; 
        end
        else begin
            assign out12=16'b0000000000000000;
            assign Co12=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out13;
    wire [14:0] Co13;

    genvar m13;
    genvar n13;
    generate
        assign out13[15]=A[15]&B[13];
        if(HOR<=12 && VER>13)begin
            for(m13=VER-13; m13<15; m13=m13+1)
            begin:gen14
                mul_one u(A[m13],B[13],Co12[m13],out12[m13+1],out13[m13],Co13[m13]);
            end
            for(n13=0; n13<VER-13; n13=n13+1)
            begin:zen13
                assign out13[n13]=1'b0;
                assign Co13[n13]=1'b0;
            end
        end
        else if (HOR<=12 && VER<=13) begin
            for(m13=0; m13<15; m13=m13+1)
            begin:pen13
                mul_one u(A[m13],B[13],Co12[m13],out12[m13+1],out13[m13],Co13[m13]);  
            end 
        end
        else if(HOR==13 && VER<14) begin
            for(m13=0; m13<15; m13=m13+1)
            begin: len13
                assign out13[m13]=A[m13]&B[HOR];
            end     
            assign Co13=15'b000000000000000; 
        end
        else if (HOR==13 && VER>=14) begin
            for(m13=VER-13; m13<15; m13=m13+1)
            begin: ken13
                assign out13[m13]=A[m13]&B[HOR];
            end  
            for(n13=0; n13<VER-13; n13=n13+1)
            begin: jen13
                assign out13[n13]=1'b0;
            end     
            assign Co13=15'b000000000000000; 
        end
        else begin
            assign out13=16'b0000000000000000;
            assign Co13=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out14;
    wire [14:0] Co14;

    genvar m14;
    genvar n14;
    generate
        assign out14[15]=A[15]&B[14];
        if(HOR<=13 && VER>14)begin
            for(m14=VER-14; m14<15; m14=m14+1)
            begin:gen15
                mul_one u(A[m14],B[14],Co13[m14],out13[m14+1],out14[m14],Co14[m14]);
            end
            for(n14=0; n14<VER-14; n14=n14+1)
            begin:zen14
                assign out14[n14]=1'b0;
                assign Co14[n14]=1'b0;
            end
        end
        else if (HOR<=13 && VER<=14) begin
            for(m14=0; m14<15; m14=m14+1)
            begin:pen14
                mul_one u(A[m14],B[14],Co13[m14],out13[m14+1],out14[m14],Co14[m14]);  
            end 
        end
        else if(HOR==14 && VER<15) begin
            for(m14=0; m14<15; m14=m14+1)
            begin: len14
                assign out14[m14]=A[m14]&B[HOR];
            end     
            assign Co14=15'b000000000000000; 
        end
        else if (HOR==14 && VER>=15) begin
            for(m14=VER-14; m14<15; m14=m14+1)
            begin: ken14
                assign out14[m14]=A[m14]&B[HOR];
            end  
            for(n14=0; n14<VER-14; n14=n14+1)
            begin: jen14
                assign out14[n14]=1'b0;
            end     
            assign Co14=15'b000000000000000; 
        end
        else begin
            assign out14=16'b0000000000000000;
            assign Co14=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out15;
    wire [14:0] Co15;

    genvar m15;
    genvar n15;
    generate
        assign out15[15]=A[15]&B[15];
        if(HOR<=14 && VER>15)begin
            for(m15=VER-15; m15<15; m15=m15+1)
            begin:gen16
                mul_one u(A[m15],B[15],Co14[m15],out14[m15+1],out15[m15],Co15[m15]);
            end
            for(n15=0; n15<VER-15; n15=n15+1)
            begin:zen15
                assign out15[n15]=1'b0;
                assign Co15[n15]=1'b0;
            end
        end
        else if (HOR<=14 && VER<=15) begin
            for(m15=0; m15<15; m15=m15+1)
            begin:pen15
                mul_one u(A[m15],B[15],Co14[m15],out14[m15+1],out15[m15],Co15[m15]);  
            end 
        end
        else if(HOR==15 && VER<16) begin
            for(m15=0; m15<15; m15=m15+1)
            begin: len15
                assign out15[m15]=A[m15]&B[HOR];
            end     
            assign Co15=15'b000000000000000; 
        end
        else if (HOR==15 && VER>=16) begin
            for(m15=VER-15; m15<15; m15=m15+1)
            begin: ken15
                assign out15[m15]=A[m15]&B[HOR];
            end  
            for(n15=0; n15<VER-15; n15=n15+1)
            begin: jen15
                assign out15[n15]=1'b0;
            end     
            assign Co15=15'b000000000000000; 
        end
        else begin
            assign out15=16'b0000000000000000;
            assign Co15=15'b000000000000000;
        end  
    endgenerate

    wire [15:0] out16;
    wire [14:0] Co16/*verilator split_var*/;

    add final0(Co15[0],out15[1],1'b0,out16[0],Co16[0]);
    genvar m16;
    generate
        for(m16=1; m16<15; m16=m16+1)
        begin:gen17
            add u(Co15[m16],out15[m16+1],Co16[m16-1],out16[m16],Co16[m16]);
        end
    endgenerate
 
    assign result[0]=c0[0];
    assign result[1]=out1[0];
    assign result[2]=out2[0];
    assign result[3]=out3[0];
    assign result[4]=out4[0];
    assign result[5]=out5[0];
    assign result[6]=out6[0];
    assign result[7]=out7[0];
    assign result[8]=out8[0];
    assign result[9]=out9[0];
    assign result[10]=out10[0];
    assign result[11]=out11[0];
    assign result[12]=out12[0];
    assign result[13]=out13[0];
    assign result[14]=out14[0];
    assign result[15]=out15[0];
    assign result[16]=out16[0];
    assign result[17]=out16[1];
    assign result[18]=out16[2];
    assign result[19]=out16[3];
    assign result[20]=out16[4];
    assign result[21]=out16[5];
    assign result[22]=out16[6];
    assign result[23]=out16[7];
    assign result[24]=out16[8];
    assign result[25]=out16[9];
    assign result[26]=out16[10];
    assign result[27]=out16[11];
    assign result[28]=out16[12];
    assign result[29]=out16[13];
    assign result[30]=out16[14];
    assign result[31]=Co16[14];
    
endmodule
