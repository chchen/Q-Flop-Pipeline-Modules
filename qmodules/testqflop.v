module testqflop;
    reg data, clock;
    wire ack, out;
    reg expected;

    q_flop myflop (.data(data), .clock(clock), .ack(ack), .out(out));

    initial
        begin
            #0      data=1; clock=1; expected=0;
            #10     data=1; clock=0; expected=0;
            #10     data=1; clock=1; expected=0;
            #10     data=1; clock=0; expected=0;
        end
    initial
        $monitor(
            "data=%b clock=%b ack=%b out=%b, expected out=%b time=%d",
            data, clock, ack, out, expected, $time);

endmodule // testqflop
