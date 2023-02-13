/*
Approximate Full Adder
*/

module AFA (
    input x1, x2, cin,
    output sum, cout
);

    wire w;
    assign w = x1 | x2;
    assign sum = w ^ cin;
    assign cout = w & cin;

endmodule