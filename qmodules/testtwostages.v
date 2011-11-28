module testtwostages;
    reg start, rst;
    wire pi1, si1, po1, so1, f1, pi2, si2, po2, so2, f2;

    q_stage stage1(start, rst, pi1, si1, po1, so1, f1);
    q_stage stage2(start, rst, pi2, si2, po2, so2, f2);

    buf
    #1  (pi2, so1),
        (si1, po2);
    buf
    #1  (si2, so2);
    not
    #10 (pi1, po1);

    initial
        begin 
            $dumpfile("testtwostages.vcd");
            $dumpvars(0,testtwostages);
            #0      start=1; rst=1;
            #20     start=0; rst=1;
            #20     start=0; rst=0;
        end

endmodule // testqstage
