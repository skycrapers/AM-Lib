/* output the revise of the LM*/
module REV 
(
    input wire [31:0] rst,
    input wire [3:0] k1, 
    input wire [3:0] k2,
    
    output reg [31:0] revise
);
    wire [4:0] sumk;

    MCLA_4_c MCLA_4_c (
    .a(k1), 
    .b(k2),
    
    .s(sumk)
    );

    always@(*)
    begin
        case (sumk) /* move right 30-sumk bits*/
            /* the efficient width of rst is 30, so >> 30 means revise = 0 */
            5'd0 : revise = 32'b0     ;
            5'd1 : revise = rst >> 29 ;
            5'd2 : revise = rst >> 28 ;
            5'd3 : revise = rst >> 27 ;
            5'd4 : revise = rst >> 26 ;
            5'd5 : revise = rst >> 25 ;
            5'd6 : revise = rst >> 24 ;
            5'd7 : revise = rst >> 23 ;
            5'd8 : revise = rst >> 22 ;
            5'd9 : revise = rst >> 21 ;
            5'd10: revise = rst >> 20 ;
            5'd11: revise = rst >> 19 ;
            5'd12: revise = rst >> 18 ;
            5'd13: revise = rst >> 17 ;
            5'd14: revise = rst >> 16 ;

            5'd15: revise = rst >> 15 ;

            5'd16: revise = rst >> 14 ;
            5'd17: revise = rst >> 13 ;
            5'd18: revise = rst >> 12 ;
            5'd19: revise = rst >> 11 ;
            5'd20: revise = rst >> 10 ;
            5'd21: revise = rst >> 9  ;
            5'd22: revise = rst >> 8  ;
            5'd23: revise = rst >> 7  ;
            5'd24: revise = rst >> 6  ;
            5'd25: revise = rst >> 5  ;
            5'd26: revise = rst >> 4  ;
            5'd27: revise = rst >> 3  ;
            5'd28: revise = rst >> 2  ;
            5'd29: revise = rst >> 1  ;
            5'd30: revise = rst       ;
            5'd31: revise = 32'b0     ;  /* impossible, because 0 <= sumk <= 30 */
            
            default: revise = 32'b0   ;
        endcase
    end


    
endmodule