module mux_one (
    input sel,
    input a,
    input b,
    output s
);
    reg SR;
    always @(sel or a or b)
    begin
        if(sel == 1'b0)
        SR=a;
        else
        SR=b;
    end
    assign s=SR;
endmodule