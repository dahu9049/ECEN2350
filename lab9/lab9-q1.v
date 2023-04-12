module testbench;
    reg C, D;
    wire Q, Qn;

    ff dut(.c(C), .d(D), .q(Q), .qn(Qn));

    always #10 C = ~C;

    initial begin
        $monitor("%6d: C=%b, D=%b, Q=%b, Qn=%b", $time, C, D, Q, Qn);
        C = 0;
        D = 0;
        #20 D = 1;
        #4  D = 0;
        #2  D = 1;
        #9  D = 0;
        #25 $finish;
    end
endmodule

module ff(input c, d, output q, qn);
    wire n1, n2, n3, n4;
    nand #1 (n1, n4, n2);
    nand #1 (n2, n1, c);
    nand #1 (n3, c, n2);
    nand #1 (n4, d, n3);
    nand #1 (q, n2, qn);
    nand #1 (qn, q, n3);
endmodule
