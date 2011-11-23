module testcmp;
    reg a, b;
    wire q;
    reg expected;

    greater_than cmp (.a(a), .b(b), .q(q));

    initial
        begin
            #0      a=1; b=0; expected=1;
            #10     a=0; b=1; expected=0;
            #10     a=1; b=0; expected=1;
            #10     a=0; b=1; expected=0;
        end
    initial
        $monitor(
            "a=%b b=%b q=%b, expected out=%b time=%d",
            a, b, q, expected, $time);

endmodule // testcmp
