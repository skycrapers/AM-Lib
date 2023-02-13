module mux3
#(parameter
	m     = 8 //selecting m bits
)
(
    input [m-1 :0] ina,
    input [m-1 :0] inb,
    input [m-1 :0] inc,
    input [1:0] sel,
    output reg [m-1 :0]  outy
);
	
    always @(*)
    begin
    case(sel)
    2'b00: outy=inc;
    2'b01: outy=inb;
    2'b10: outy=ina;
    default: outy=ina;
    endcase
    end
	
endmodule
