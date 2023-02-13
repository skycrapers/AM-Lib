module mux2
#(parameter
	n     = 16//length of original number
)
(
    input [2*n-1 :0] ina,
    input [2*n-1 :0] inb,
    input sel,
    output reg [2*n-1 :0] outy
);
	
    always@ (*)
    begin
    if (sel == 0)
        outy = ina;
    else
        outy = inb;
    end
	
endmodule
