module q_stage(start, rst, pi, si, po, so, f);
    input start, rst, pi, si;
    output po, so, f;
    wire clk, ack;
    wire pi_net, si_net, po_net, so_net, f_net;
    wire ack_pi, ack_si, ack_po, ack_so, ack_f;
    wire so_net1, so_net2, so_net3, so_net4;
    wire po_net1, po_net2, po_net3, po_net4;
    wire f_net1, f_net2, f_net3, f_net4, f_net5, f_net6, f_net7, f_net8, f_net9, f_net10, f_net11, f_net12, f_net13, f_net14;
    wire pi_in, si_in, po_in, so_in, f_in; 

    // Inputs
    q_flop qf_pi(.rst(start), .clk(clk), .data(pi_in), .ack(ack_pi), .out(pi_net));
    q_flop qf_si(.rst(start), .clk(clk), .data(si_in), .ack(ack_si), .out(si_net));

    // Outputs
    q_flop qf_po(.rst(start), .clk(clk), .data(po_in), .ack(ack_po), .out(po));
    q_flop qf_so(.rst(start), .clk(clk), .data(so_in), .ack(ack_so), .out(so));
    q_flop qf_f(.rst(start), .clk(clk), .data(f_in), .ack(ack_f), .out(f));

    // Local Clock
    q_clock qc(.clk(clk), .ack(ack));
    muller_c_five rendezvous(.a(ack_pi), .b(ack_si), .c(ack_po), .d(ack_so), .e(ack_f), .out(ack));

    and
    #1  (so_net1, pi_net, ~so, ~si_net, ~f),
        (so_net2, so, ~si_net, f),
        (so_net3, pi_net, ~po, ~si_net, f),
        (so_net4, ~pi_net, ~so, ~po, ~si_net, f),
        (po_net1, pi_net, po, f),
        (po_net2, pi_net, ~so, ~po, ~f),
        (po_net3, pi_net, ~so, po, si_net),
        (po_net4, pi_net, ~so, po, ~si_net, ~f),
        (f_net1, pi_net, ~so, ~po, ~si_net, ~f),
        (f_net2, pi_net, so, po, ~si_net, f),
        (f_net3, pi_net, ~so, po, ~si_net, f),
        (f_net4, pi_net, ~so, ~po, si_net, ~f),
        (f_net5, pi_net, ~so, po, si_net, f),
        (f_net6, pi_net, so, ~po, si_net, f),
        (f_net7, ~pi_net, so, po, ~si_net, f),
        (f_net8, ~pi_net, ~so, ~po, ~si_net, f),
        (f_net9, pi_net, ~so, ~po, ~si_net, f),
        (f_net10, pi_net, so, ~po, ~si_net, f),
        (f_net11, ~pi_net, so, ~po, ~si_net, f),
        (f_net12, ~pi_net, ~so, po, si_net, f),
        (f_net13, ~pi_net, ~so, ~po, si_net, f),
        (f_net14, pi_net, ~so, ~po, si_net, f);
    or
    #1  (so_net, so_net1, so_net2, so_net3, so_net4),
        (po_net, po_net1, po_net2, po_net3, po_net4),
        (f_net, f_net1, f_net2, f_net3, f_net4, f_net5, f_net6, f_net7, f_net8, f_net9, f_net10, f_net11, f_net12, f_net13, f_net14);
    and 
    #1  (pi_in, pi, ~rst),
        (si_in, si, ~rst),
        (po_in, po_net, ~rst),
        (so_in, so_net, ~rst),
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
