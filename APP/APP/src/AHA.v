/*
Approximate Half Adder
*/

module AHA (
    input x1, x2,
    output sum, cout
);

    assign sum = x1 | x2;
    assign cout = x1 & x2;

endmodule