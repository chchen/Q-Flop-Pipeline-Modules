module testqflop;
    reg data, rst;
    wire clk, ack, out;
    reg expected;

    q_flop qf(.rst(rst), .clk(clk), .data(data), .ack(ack), .out(out));
    q_clock qc(.rst(rst), .clk(clk), .ack(ack));

    initial
        begin
            #0      rst=1; data=1; expected=1;
            #100    rst=0; data=1; expected=1;
            #100    rst=0; data=0; expected=0;
            #100    rst=0; data=1; expected=1;
            #100    rst=0; data=0; expected=0;
        end
    initial
        $monitor(
            "[%d] data=%b clk=%b rst=%b ack=%b out=%b, expected out=%b",
            $time, data, clk, rst, ack, out, expected);

endmodule // testqflop
