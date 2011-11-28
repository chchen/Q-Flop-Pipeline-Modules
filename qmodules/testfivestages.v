module testfivestages;
    reg start, rst;
    wire pi1, si1, po1, so1, f1;
    wire pi2, si2, po2, so2, f2;
    wire pi3, si3, po3, so3, f3;
    wire pi4, si4, po4, so4, f4;
    wire pi5, si5, po5, so5, f5;

    q_stage stage1(start, rst, pi1, si1, po1, so1, f1);
    q_stage stage2(start, rst, pi2, si2, po2, so2, f2);
    q_stage stage3(start, rst, pi3, si3, po3, so3, f3);
    q_stage stage4(start, rst, pi4, si4, po4, so4, f4);
    q_stage stage5(start, rst, pi5, si5, po5, so5, f5);

    buf
        (pi2, so1),
        (si1, po2),
        (pi3, so2),
        (si2, po3),
        (pi4, so3),
        (si3, po4),
        (pi5, so4),
        (si4, po5);
    buf
    #10 (si5, so5);
    not
    #10 (pi1, po1);

    initial
        begin 
            $dumpfile("testfivestages.vcd");
            $dumpvars(0,testfivestages);
            #0      start=1; rst=1;
            #20     start=0; rst=1;
            #20     start=0; rst=0;
        end

endmodule // testqstage
