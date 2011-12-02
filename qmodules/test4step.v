module test4step;
    reg start, rst;
    wire r_in1, a_out1, a_in1, r_out1, f1;
    wire r_in2, a_out2, a_in2, r_out2, f2;
    wire r_in3, a_out3, a_in3, r_out3, f3;
    wire r_in4, a_out4, a_in4, r_out4, f4;
    wire r_in5, a_out5, a_in5, r_out5, f5;

    q_4step stage1(start, rst, r_in1, a_out1, a_in1, r_out1, f1);
    q_4step stage2(start, rst, r_in2, a_out2, a_in2, r_out2, f2);
    q_4step stage3(start, rst, r_in3, a_out3, a_in3, r_out3, f3);
    q_4step stage4(start, rst, r_in4, a_out4, a_in4, r_out4, f4);
    q_4step stage5(start, rst, r_in5, a_out5, a_in5, r_out5, f5);

    buf
        (r_in2, r_out1),
        (a_out1, a_in2),
        (r_in3, r_out2),
        (a_out2, a_in3),
        (r_in4, r_out3),
        (a_out3, a_in4),
        (r_in5, r_out4),
        (a_out4, a_in5);
    buf
    #10 (a_out5, r_out5);   // Loopback acknowledge at the end
    not
    #10 (r_in1, a_in1);     // Always send data

    initial
        begin 
            $dumpfile("test4step.vcd");
            $dumpvars(0,test4step);
            #0      start=1; rst=1;
            #20     start=0; rst=1;
            #20     start=0; rst=0;
        end

endmodule // test4step
