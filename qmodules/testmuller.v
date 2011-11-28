module testmuller;
    reg a, b, c, d, e;
    wire out;
    reg expected;

    muller_c_five myc(a, b, c, d, e, out);

    initial
        begin
            #0      a=0; b=0; c=0; d=0; e=0; expected=0;
            #20     a=0; b=0; c=0; d=0; e=0; expected=0;
            #20     a=0; b=0; c=0; d=0; e=0; expected=0;
            #20     a=1; b=0; c=0; d=0; e=0; expected=0;
            #20     a=1; b=1; c=0; d=0; e=0; expected=0;
            #20     a=1; b=1; c=1; d=0; e=0; expected=0;
            #20     a=1; b=1; c=1; d=1; e=0; expected=0;
            #20     a=1; b=1; c=1; d=1; e=1; expected=1;
            #20     a=0; b=1; c=1; d=1; e=1; expected=1;
            #20     a=0; b=0; c=1; d=1; e=1; expected=1;
            #20     a=0; b=0; c=0; d=1; e=1; expected=1;
            #20     a=0; b=0; c=0; d=0; e=1; expected=1;
            #20     a=0; b=0; c=0; d=0; e=0; expected=0;
        end
    initial
        $monitor(
            "a=%b b=%b c=%b d=%b e=%b out=%b    expected=%b time=%d",
            a, b, c, d, e, out, expected, $time);

endmodule // testmuller
