module testresolver;
    reg data, clock;
    wire rh_l, rl_l;
    reg expected;

    q_resolver myres (.data(data), .clock(clock), .rh_l(rh_l), .rl_l(rl_l));

    initial
        begin
            #0      data=1; clock=1; expected=0;
            #10     data=1; clock=0; expected=0;
            #10     data=0; clock=1; expected=0;
            #10     data=1; clock=0; expected=0;
            #10     data=0; clock=0; expected=0;
            #10     data=1; clock=1; expected=0;
            #10     data=0; clock=0; expected=0;
        end
    initial
        $monitor(
            "data=%b clock=%b rh_l=%b rl_l=%b, expected out=%b time=%d",
            data, clock, rh_l, rl_l, expected, $time);

endmodule // testresolver
