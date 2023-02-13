module mux2
#(parameter
	n     = 32
)
(
    input [n-1 :0] ina,
    input [n-1 :0] inb,
    input sel,
    output reg [n-1 :0] outy
);
	
    always@ (*)
    begin
	case(sel)
	1'b0: outy = ina;
	1'b1: outy = inb;
	default: outy = ina;
	endcase
	end
	
endmodule
