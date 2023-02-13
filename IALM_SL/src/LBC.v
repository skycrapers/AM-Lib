/* logarithm-binary converter */
module LBC (
    input  wire [19:0] sumlog,

    output reg [31:0] rst
);
    
    always@(*)
    begin
        rst = {17'b0000_0000_0000_0000_1, sumlog[14:0]};
        case (sumlog[19:15])
            5'd0 : rst = 32'b1    ;
            5'd1 : rst = rst >> 14;
            5'd2 : rst = rst >> 13;
            5'd3 : rst = rst >> 12;
            5'd4 : rst = rst >> 11;
            5'd5 : rst = rst >> 10;
            5'd6 : rst = rst >> 9 ;
            5'd7 : rst = rst >> 8 ;
            5'd8 : rst = rst >> 7 ;
            5'd9 : rst = rst >> 6 ;
            5'd10: rst = rst >> 5 ;
            5'd11: rst = rst >> 4 ;
            5'd12: rst = rst >> 3 ;
            5'd13: rst = rst >> 2 ;
            5'd14: rst = rst >> 1 ;

            5'd15: rst = rst;

            5'd16: rst = rst << 1 ;
            5'd17: rst = rst << 2 ;
            5'd18: rst = rst << 3 ;
            5'd19: rst = rst << 4 ;
            5'd20: rst = rst << 5 ;
            5'd21: rst = rst << 6 ;
            5'd22: rst = rst << 7 ;
            5'd23: rst = rst << 8 ;
            5'd24: rst = rst << 9 ;
            5'd25: rst = rst << 10;
            5'd26: rst = rst << 11;
            5'd27: rst = rst << 12;
            5'd28: rst = rst << 13;
            5'd29: rst = rst << 14;
            5'd30: rst = rst << 15;
            5'd31: rst = rst << 16;
            
            default: rst = rst;
        endcase
    end



endmodule