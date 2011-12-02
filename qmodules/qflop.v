module q_flop(rst, clk, data, ack, out);
    input clk, rst, data;
    output ack, out;
    wire res_clk, rl_l, rh_l;

    q_out qo(.rst(rst), .rl_l(rl_l), .rh_l(rh_l), .clk(clk),
        .ack(ack), .out(out), .res_clk(res_clk));
    q_resolver qi(.data(data), .clk(res_clk), .rh_l(rh_l), .rl_l(rl_l));

endmodule   // q_flop

module q_out(rst, rl_l, rh_l, clk, ack, out, res_clk);
    input rst, rl_l, rh_l, clk;
    output ack, out, res_clk;
    wire out1, out2, out3, out_net, res_clk1, res_clk2;

    and
        (ack, rl_l, rh_l),
        (out1, ~rh_l, clk),
        (out2, ~clk, out_net),
        (out3, rl_l, out_net),
        (res_clk1, out_net, rl_l, clk),
        (res_clk2, ~out_net, rh_l, clk);
    or
        (out_net, rst, out1, out2, out3),
        (res_clk, rst, res_clk1, res_clk2);
    buf
    #1  (out, out_net);

endmodule   // q_output

module q_resolver(data, clk, rh_l, rl_l);
    input data, clk;
    output rh_l, rl_l;
    wire data_bar, a_net, b_net, or_1, or_2;

    not
        (data_bar, data);
    nor
        (or_1, data, a_net),
        (a_net, or_1, clk, b_net),
        (b_net, or_2, clk, a_net),
        (or_2, data_bar, b_net);
    nand
    #1  (rh_l, a_net, ~b_net),
        (rl_l, b_net, ~a_net);

endmodule   // q_resolver

module q_clock(ack, clk);
    input ack;
    output clk;
    wire clk_net;

    not
    #4  (clk, ack); // Delay for combinational logic

endmodule   // q_clock
