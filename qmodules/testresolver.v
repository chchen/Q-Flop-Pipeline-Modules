module testresolver;
    reg rst, data, clk;
    wire rh_l, rl_l;
    reg expected;

    q_resolver myres (.rst(rst), .data(data), .clk(clk), .rh_l(rh_l), .rl_l(rl_l));

    initial
        begin
            #0      rst=1; data=1; clk=1; expected=0;
            #10     rst=0; data=1; clk=1; expected=0;
            #10     rst=0; data=1; clk=0; expected=0;
            #10     rst=0; data=0; clk=1; expected=0;
            #10     rst=0; data=0; clk=0; expected=0;
        end
    initial
        $monitor(
            "rst=%b data=%b clk=%b rh_l=%b rl_l=%b, expected out=%b time=%d",
            rst, data, clk, rh_l, rl_l, expected, $time);

endmodule // testresolver
