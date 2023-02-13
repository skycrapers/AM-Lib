module mux4
#(parameter
	n     = 16//length of original number
)
(
    input [2*n-1 :0] ina,
    input [2*n-1 :0] inb,
    input [2*n-1 :0] inc,
    input [2*n-1 :0] ind,
    input [1:0] sel,	
    output reg [2*n-1 :0] outy
);
    
    always @ (*)
    if (sel == 2'b00) outy = ina;
    else if (sel == 2'b01) outy = inb;
    else if (sel == 2'b10) outy = inc;
    else outy = ind;
    
endmodule
