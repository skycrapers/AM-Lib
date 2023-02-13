/* truncated BLC, binary-logarithm converter */

module TBLC_11
#(parameter
    M     = 11
)
(
    input  wire [15:0] o,
    input  wire [15:0] x,
    
    output wire  [16+3-1-M+1:0] tlog /* truncated logarithm, M=11, tlog[8:0] */
);
    reg [ 3:0] k;
    reg [16-1-M-1+1:0] y; /* M=11, y[4:0] */
    assign tlog = {k, y};

    always@(*)
    begin
        case (o)
            /*1.*/
            16'b1000_0000_0000_0000: begin
                k = 4'b1111;
                y = x[14:10];
            end
            16'b0100_0000_0000_0000: begin
                k = 4'b1110;
                y = x[13: 9];
            end
            16'b0010_0000_0000_0000: begin
                k = 4'b1101;
                y = x[12: 8];
            end
            16'b0001_0000_0000_0000: begin
                k = 4'b1100;
                y = x[11: 7];
            end
            /*2.*/
            16'b0000_1000_0000_0000: begin
                k = 4'b1011;
                y = x[10: 6];
            end
            16'b0000_0100_0000_0000: begin
                k = 4'b1010;
                y = x[ 9: 5];
            end
            16'b0000_0010_0000_0000: begin
                k = 4'b1001;
                y = x[ 8: 4];
            end
            16'b0000_0001_0000_0000: begin
                k = 4'b1000;
                y = x[ 7: 3];
            end
            /*3.*/
            16'b0000_0000_1000_0000: begin
                k = 4'b0111;
                y = x[ 6: 2];
            end
            16'b0000_0000_0100_0000: begin
                k = 4'b0110;
                y = x[ 5: 1];
            end
            16'b0000_0000_0010_0000: begin
                k = 4'b0101;
                y = x[ 4: 0];
            end
            16'b0000_0000_0001_0000: begin
                k = 4'b0100;
                y = {x[3:0], 1'b0};
            end
            /*4.*/
            16'b0000_0000_0000_1000: begin
                k = 4'b0011;
                y = {x[2:0], 2'b0};
            end
            16'b0000_0000_0000_0100: begin
                k = 4'b0010;
                y = {x[1:0], 3'b0};
            end
            16'b0000_0000_0000_0010: begin
                k = 4'b0001;
                y = {x[0]  , 4'b0};
            end
            16'b0000_0000_0000_0001: begin
                k = 4'b0000;
                y = 5'b0  ;
            end
            default: begin
                k = 4'b0000;
                y = 5'b0  ;
            end
        endcase
    end
    
    


endmodule