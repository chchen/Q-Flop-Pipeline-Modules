module testqstage;
    reg rst, pi, si;
    wire po, so, f;

    q_stage mystage(rst, pi, si, po, so, f);

    initial
        begin 
            $dumpfile("testqstage.vcd");
            $dumpvars(0,testqstage);
            #0      rst=1; pi=0; si=0;
            #10     rst=0; pi=0; si=0;
            #10     rst=0; pi=0; si=0;
            #10     rst=0; pi=1; si=0;
        end
    initial
        $monitor(
            "rst=%b pi=%b si=%b po=%b so=%b f=%b    time=%d",
            rst, pi, si, po, so, f, $time);

endmodule // testqstage
