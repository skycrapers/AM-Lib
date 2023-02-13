module booth_enc (
    input [3:0] code,
    output neg,
    output f0,
    output f1,
    output f2,
    output f3,
    output f4
);
    assign neg = code[3];
    assign f0=(code==4'b0000) || (code==4'b1111);
    assign f1=(code==4'b0001) || (code==4'b0010) || (code==4'b1101)||(code==4'b1110);
    assign f2=(code[2:0]==3'b011) || (code[2:0]==3'b100) ;
    assign f3=(code==4'b0101) || (code==4'b0110) || (code==4'b1001)||(code==4'b1010);
    assign f4=(code==4'b0111) || (code==4'b1000);

endmodule