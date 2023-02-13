/* binary-logarithm converter */

module BLC (
    input  wire [15:0] o,
    input  wire [15:0] x,
    
    output wire  [18:0] log 
    //output wire [14:0] f /* fraction */
);
    reg [ 3:0] k;
    reg [15:0] y;
    assign log = {k, y[14:0]};

    always@(*)
    begin
        case (o)
            /*1.*/
            16'b1000_0000_0000_0000: begin
                k = 4'b1111;
                y = x      ;
            end
            16'b0100_0000_0000_0000: begin
                k = 4'b1110;
                y = x << 1 ;
            end
            16'b0010_0000_0000_0000: begin
                k = 4'b1101;
                y = x << 2 ;
            end
            16'b0001_0000_0000_0000: begin
                k = 4'b1100;
                y = x << 3 ;
            end
            /*2.*/
            16'b0000_1000_0000_0000: begin
                k = 4'b1011;
                y = x << 4 ;
            end
            16'b0000_0100_0000_0000: begin
                k = 4'b1010;
                y = x << 5 ;
            end
            16'b0000_0010_0000_0000: begin
                k = 4'b1001;
                y = x << 6 ;
            end
            16'b0000_0001_0000_0000: begin
                k = 4'b1000;
                y = x << 7 ;
            end
            /*3.*/
            16'b0000_0000_1000_0000: begin
                k = 4'b0111;
                y = x << 8 ;
            end
            16'b0000_0000_0100_0000: begin
                k = 4'b0110;
                y = x << 9 ;
            end
            16'b0000_0000_0010_0000: begin
                k = 4'b0101;
                y = x << 10;
            end
            16'b0000_0000_0001_0000: begin
                k = 4'b0100;
                y = x << 11;
            end
            /*4.*/
            16'b0000_0000_0000_1000: begin
                k = 4'b0011;
                y = x << 12;
            end
            16'b0000_0000_0000_0100: begin
                k = 4'b0010;
                y = x << 13;
            end
            16'b0000_0000_0000_0010: begin
                k = 4'b0001;
                y = x << 14;
            end
            16'b0000_0000_0000_0001: begin
                k = 4'b0000;
                y = 16'b0  ;
            end
            default: begin
                k = 4'b0000;
                y = 16'b0  ;
            end
        endcase
    end
    
    


endmodule