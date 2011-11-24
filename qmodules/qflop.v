module q_flop(rst, data, ack, out);
    input rst, data;
    output ack, out;
    wire clk, res_clk, rl_l, rh_l;

    q_out qo(.rst(rst), .rl_l(rl_l), .rh_l(rh_l), .clk(clk), .ack(ack), .out(out), .res_clk(res_clk));
    q_resolver qi(.data(data), .clk(res_clk), .rh_l(rh_l), .rl_l(rl_l));
    q_clock qc(.rst(rst), .clk(clk), .ack(ack));

endmodule   // q_flop

module q_out(rst, rl_l, rh_l, clk, ack, out, res_clk);
    input rst, rl_l, rh_l, clk;
    output ack, out, res_clk;
    wire out1, out2, out3, out_net, res_clk1, res_clk2;

    and
    #1  (ack, rl_l, rh_l),
        (out1, ~rh_l, clk),
        (out2, ~clk, out_net),
        (out3, rl_l, out_net),
        (res_clk1, out_net, rl_l, clk),
        (res_clk2, ~out_net, rh_l, clk);
    or
    #1  (out_net, rst, out1, out2, out3),
        (res_clk, rst, res_clk1, res_clk2);
    buf
        (out, out_net);

endmodule   // q_output

module q_resolver(data, clk, rh_l, rl_l);
    input data, clk;
    output rh_l, rl_l;
    wire data_bar, a_net, b_net, or_1, or_2;

    not
    #1  (data_bar, data);
    nor
    #1  (or_1, data, a_net),
        (a_net, or_1, clk, b_net),
        (b_net, or_2, clk, a_net),
        (or_2, data_bar, b_net);
    nand
    #1  (rh_l, a_net, ~b_net),
        (rl_l, b_net, ~a_net);

endmodule   // q_resolver

module q_clock(rst, ack, clk);
    input rst, ack;
    output clk;
    wire clk_net;

    not
    #1  (clk_net, ack);
    or
    #1  (clk, clk_net, rst);

endmodule   // q_clock
