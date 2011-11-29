module q_4step(start, rst, r_in, a_out, a_in, r_out, f);
    input start, rst, r_in, a_out;

    output a_in, r_out, f;

    wire clk, ack;
    wire r_in_net, a_out_net, a_in_net, r_out_net, f_net;
    wire ack_r_in, ack_a_out, ack_a_in, ack_r_out, ack_f;
    wire r_out_net1, r_out_net2, r_out_net3, r_out_net4;
    wire a_in_net1, a_in_net2, a_in_net3, a_in_net4;
    wire f_net1, f_net2, f_net3, f_net4, f_net5, f_net6, f_net7;
    wire f_net8, f_net9, f_net10, f_net11, f_net12, f_net13, f_net14;
    wire r_in_in, a_out_in, a_in_in, r_out_in, f_in; 

    // Inputs
    q_flop qf_r_in(.rst(start), .clk(clk), .data(r_in_in), .ack(ack_r_in), .out(r_in_net));
    q_flop qf_a_out(.rst(start), .clk(clk), .data(a_out_in), .ack(ack_a_out), .out(a_out_net));

    // Outputs
    q_flop qf_a_in(.rst(start), .clk(clk), .data(a_in_in), .ack(ack_a_in), .out(a_in));
    q_flop qf_r_out(.rst(start), .clk(clk), .data(r_out_in), .ack(ack_r_out), .out(r_out));
    q_flop qf_f(.rst(start), .clk(clk), .data(f_in), .ack(ack_f), .out(f));

    // Local Clock
    q_clock qc(.clk(clk), .ack(ack));
    muller_c_five rendezvous(.a(ack_r_in), .b(ack_a_out), .c(ack_a_in), .d(ack_r_out), .e(ack_f), .out(ack));

    and
    #1  (r_out_net1, r_in_net, ~r_out, ~a_out_net, ~f),
        (r_out_net2, r_out, ~a_out_net, f),
        (r_out_net3, r_in_net, ~a_in, ~a_out_net, f),
        (r_out_net4, ~r_in_net, ~r_out, ~a_in, ~a_out_net, f),
        (a_in_net1, r_in_net, a_in, f),
        (a_in_net2, r_in_net, ~r_out, ~a_in, ~f),
        (a_in_net3, r_in_net, ~r_out, a_in, a_out_net),
        (a_in_net4, r_in_net, ~r_out, a_in, ~a_out_net, ~f),
        (f_net1, r_in_net, ~r_out, ~a_in, ~a_out_net, ~f),
        (f_net2, r_in_net, r_out, a_in, ~a_out_net, f),
        (f_net3, r_in_net, ~r_out, a_in, ~a_out_net, f),
        (f_net4, r_in_net, ~r_out, ~a_in, a_out_net, ~f),
        (f_net5, r_in_net, ~r_out, a_in, a_out_net, f),
        (f_net6, r_in_net, r_out, ~a_in, a_out_net, f),
        (f_net7, ~r_in_net, r_out, a_in, ~a_out_net, f),
        (f_net8, ~r_in_net, ~r_out, ~a_in, ~a_out_net, f),
        (f_net9, r_in_net, ~r_out, ~a_in, ~a_out_net, f),
        (f_net10, r_in_net, r_out, ~a_in, ~a_out_net, f),
        (f_net11, ~r_in_net, r_out, ~a_in, ~a_out_net, f),
        (f_net12, ~r_in_net, ~r_out, a_in, a_out_net, f),
        (f_net13, ~r_in_net, ~r_out, ~a_in, a_out_net, f),
        (f_net14, r_in_net, ~r_out, ~a_in, a_out_net, f);
    or
    #1  (r_out_net, r_out_net1, r_out_net2, r_out_net3, r_out_net4),
        (a_in_net, a_in_net1, a_in_net2, a_in_net3, a_in_net4),
        (f_net, f_net1, f_net2, f_net3, f_net4, f_net5, f_net6, f_net7, f_net8, f_net9, f_net10, f_net11, f_net12, f_net13, f_net14);
    and 
    #1  (r_in_in, r_in, ~rst),
        (a_out_in, a_out, ~rst),
        (a_in_in, a_in_net, ~rst),
        (r_out_in, r_out_net, ~rst),
        (f_in, f_net, ~rst);

endmodule   // q_stage

module muller_c_five(a, b, c, d, e, out);
    input a, b, c, d, e;

    output out;

    reg supply = 1;
    reg gnd = 0;

    wire a_h, b_h, c_h, d_h;
    wire a_l, b_l, c_l, d_l;
    wire out_net, out_bar;

    nmos
        (a_h, supply, a),
        (b_h, a_h, b),
        (c_h, b_h, c),
        (d_h, c_h, d),
        (out_net, d_h, e);
    pmos
        (a_l, gnd, a),
        (b_l, a_l, b),
        (c_l, b_l, c),
        (d_l, c_l, d),
        (out_net, d_l, e);
    not
        (out_bar, out_net);
    not (weak0, weak1)
        (out_net, out_bar);
    buf
    #1  (out, out_net);
    
endmodule   // muller_c_five
