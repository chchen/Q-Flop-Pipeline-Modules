module q_2step(start, rst, r_in, a_out, a_in, r_out, f);
    input start, rst, r_in, a_out;

    output a_in, r_out, f;

    wire clk, ack;
    wire a_and_r;
    wire r_in_net, a_out_net, a_and_r_net, f_net;
    wire ack_r_in, ack_a_out, ack_a_and_r, ack_f;
    wire a_and_r_net1, a_and_r_net2, a_and_r_net3;
    wire f_net1, f_net2, f_net3, f_net4;
    wire r_in_in, a_out_in, a_and_r_in, f_in; 

    // Inputs
    q_flop qf_r_in(.rst(start), .clk(clk), .data(r_in_in), .ack(ack_r_in), .out(r_in_net));
    q_flop qf_a_out(.rst(start), .clk(clk), .data(a_out_in), .ack(ack_a_out), .out(a_out_net));

    // Outputs
    q_flop qf_a_and_r(.rst(start), .clk(clk), .data(a_and_r_in), .ack(ack_a_and_r), .out(a_and_r));
    q_flop qf_f(.rst(start), .clk(clk), .data(f_in), .ack(ack_f), .out(f));

    // Local Clock
    q_clock qc(.clk(clk), .ack(ack));
    muller_c_four rendezvous(.a(ack_r_in), .b(ack_a_out), .c(ack_a_and_r), .d(ack_f), .out(ack));

    and
    #1  (a_and_r_net1, r_in_net, ~a_and_r, ~a_out_net),
        (a_and_r_net2, a_and_r, ~a_out_net, f),
        (a_and_r_net3, r_in_net, a_and_r, a_out_net),
        (f_net1, r_in_net, ~r_out, ~a_in, ~a_out_net),
        (f_net2, r_out, a_in, ~a_out_net, f),
        (f_net3, ~r_in_net, r_out, a_in, a_out_net),
        (f_net4, ~r_out, ~a_in, a_out_net, f);
    or
    #1  (a_and_r_net, a_and_r_net1, a_and_r_net2, a_and_r_net3),
        (f_net, f_net1, f_net2, f_net3, f_net4);
    and 
    #1  (r_in_in, r_in, ~rst),
        (a_out_in, a_out, ~rst),
        (a_and_r_in, a_and_r_net, ~rst),
        (f_in, f_net, ~rst);
    buf
        (r_out, a_and_r),
        (a_in, a_and_r);

endmodule   // q_stage

module muller_c_four(a, b, c, d, out);
    input a, b, c, d;

    output out;

    reg supply = 1;
    reg gnd = 0;

    wire a_h, b_h, c_h;
    wire a_l, b_l, c_l;
    wire out_net, out_bar;

    nmos
        (a_h, supply, a),
        (b_h, a_h, b),
        (c_h, b_h, c),
        (out_net, c_h, d);
    pmos
        (a_l, gnd, a),
        (b_l, a_l, b),
        (c_l, b_l, c),
        (out_net, c_l, d);
    not
        (out_bar, out_net);
    not (weak0, weak1)
        (out_net, out_bar);
    buf
    #1  (out, out_net);
    
endmodule   // muller_c_five
