module multi
#(parameter
	m     = 8//selecting m bits
)
(
    input [m-1:0] ina,
    input [m-1:0] inb,
    output [2*m-1:0] outy
);
	
    assign outy=ina*inb;
	
endmodule //普通8*8乘法器
