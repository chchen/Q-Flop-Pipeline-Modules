module testqflop;
    reg data, rst;
    wire ack, out;
    reg expected;

    q_flop myflop(.rst(rst), .data(data), .ack(ack), .out(out));

    initial
        begin
            #0      rst=1; data=1; expected=1;
            #10     rst=0; data=1; expected=1;
            #10     rst=0; data=0; expected=0;
            #10     rst=0; data=1; expected=1;
            #10     rst=0; data=0; expected=0;
        end
    initial
        $monitor(
            "[%d] data=%b rst=%b ack=%b out=%b, expected out=%b",
            $time, data, rst, ack, out, expected);

endmodule // testqflop
