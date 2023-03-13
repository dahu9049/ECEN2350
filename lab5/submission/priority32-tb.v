module tb;
    reg [31:0] in;
    wire [4:0] out;
    wire valid;

    priorityEncoder32 a0(in, out, valid);

    initial begin
        $monitor("Input %b produced %b, %b", in, out, valid);
        assign in = 2;
        #5;
        assign in = 38;
        #5;
        assign in = 457;
        #5;
        assign in = 762;
        #5;
        assign in = 3092;
        #5;
        assign in = 30984;
        #5;
        assign in = 123987;
        #5;
        assign in = 1998234;
        #5;
        assign in = 87492987;
        #5;
        assign in = 109844872;
        #5;
        assign in = 1332370113;
        #5;
        assign in = 0;
        #5;



    end

endmodule