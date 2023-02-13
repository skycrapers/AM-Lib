module Err_detect (
    input wire x1,x2,x3,x4,
    output wire D
);
    assign D = (x1 & x2)+(x3 & x4);
    
endmodule
