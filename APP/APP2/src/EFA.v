/*
Exact Full Adder
*/

module EFA (
    input  x1, x2, cin,
    output sum, cout
);
    wire s, c1, c2;
    EHA HA0(.x1(x1), .x2(x2) , .sum(s)  , .cout(c1));
    EHA HA1(.x1(s) , .x2(cin), .sum(sum), .cout(c2));
    assign cout = c1 | c2;

endmodule