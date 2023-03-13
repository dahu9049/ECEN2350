module tb;
    reg [7:0] in;
    wire [2:0] out;
    reg [2:0] check;
    wire valid;
    integer i;

    priorityEncoder8 test(in, out, valid);
    initial begin
    for(i = 0; i < 256; i = i + 1) begin
        assign in = i;
        #5;
        casex(in)
            8'b1xxxxxxx:check = 3'b111;
            8'bx1xxxxxx:check = 3'b110;
            8'bxx1xxxxx:check = 3'b101;
            8'bxxx1xxxx:check = 3'b100;
            8'bxxxx1xxx:check = 3'b011;
            8'bxxxxx1xx:check = 3'b010;
            8'bxxxxxx1x:check = 3'b001;
            8'bxxxxxxx1:check = 3'b000;
        endcase
        #5;
        if((out !== check) & (out !== 000))
            $display("Err: input %b produced %b, expected %b", in, out, check);
        #5;
    end
    end

endmodule

