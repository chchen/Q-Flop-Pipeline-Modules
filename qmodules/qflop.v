module q_flop(data, clock, ack, out);
    input data, clock;
    output ack, out;
    wire p, rl_l, rh_l;

    q_out o(.l(rl_l), .h(rh_l), .c(clock), .p(p), .a(ack), .q(out));
    q_resolver i(.data(data), .clock(p), .rh_l(rh_l), .rl_l(rl_l));

endmodule   // q_flop

module q_out(l, h, c, p, a, q);
    input l, h, c;
    output a, q, p;
    wire pre_q1, pre_q2, pre_q3, post_q, pre_p1, pre_p2;

    and
    #1  (a, l, h),
        (pre_q1, ~h, c),
        (pre_q2, ~c, q),
        (pre_q3, l, q),
        (pre_p1, q, l, c),
        (pre_p2, ~q, h, c);
    or
    #1  (post_q, pre_q1, pre_q2, pre_q3),
        (p, pre_p1, pre_p2);
    buf
        (q, post_q);

endmodule   // q_output

module q_resolver(data, clock, rh_l, rl_l);
    input data, clock;
    output rh_l, rl_l;
    wire q4a, q4b, qc, b, a, qc_a_strong, qc_b_strong;
    supply0 gnd;

    greater_than cmp_rh_l(.a(a), .b(b), .q(rh_l));
    greater_than cmp_rl_l(.a(b), .b(a), .q(rl_l));

    not
        (q4b, data),
        (b, qc_b_strong),
        (a, qc_a_strong);
    rpmos
        (b, gnd, q4a),
        (a, gnd, q4b);
    tranif1
        (qc_b_strong, qc_a_strong, qc);
    buf
        (qc_b_strong, a),
        (qc_a_strong, b),
        (q4a, data),
        (qc, clock);

endmodule   // q_resolver

module greater_than(a, b, q);
    input a, b;
    output q;
    reg pre_q;

    buf 
        (q, pre_q);

    always
    #1  begin
            if (a > b)
                assign pre_q = 0;
            else
                assign pre_q = 1;
        end

endmodule   //greater_than
