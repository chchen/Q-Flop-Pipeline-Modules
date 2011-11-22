module q_output(rl_l, rh_l, clock, resolver_clock, ack, out);
    input rh_l, rl_l, clock;
    output ack, out, resolver_clock;
    wire pre_out1, pre_out2, pre_out3, post_out, pre_rc1, pre_rc2;

    and
    #1  (ack, rl_l, rh_l),
        (pre_out1, ~rh_l, clock),
        (pre_out2, ~clock, out),
        (pre_out3, rl_l, out),
        (pre_rc1, out, rl_l, clock),
        (pre_rc2, ~out, rh_l, clock);
    or
    #1  (post_out, pre_out1, pre_out2, pre_out3),
        (resolver_clock, pre_rc1, pre_rc2);
    buf
        (out, post_out);

endmodule   // q_output


module q_resolver(data, clock, rh_l, rl_l);
    input data, clock;
    output rh_l, rl_l;
    wire q4a, q4b, qc, b, a, qc_a_strong, qc_b_strong, pre_rh_l, pre_rl_l;
    reg gnd = 0;

    greater_than cmp_rh_l(.a(a), .b(b), .q(pre_rh_l));
    greater_than cmp_rl_l(.a(b), .b(a), .q(pre_rl_l));

    not
    #1  (q4b, data),
        (b, qc_b_strong),
        (a, qc_a_strong),
        (rl_l, pre_rl_l),
        (rh_l, pre_rh_l);
    rpmos
    #1  (b, gnd, q4a),
        (a, gnd, q4b);
    tranif1
    #1  (qc_b_strong, qc_a_strong, qc);
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
                assign pre_q = 1;
            else
                assign pre_q = 0;
        end

endmodule   //greater_than
