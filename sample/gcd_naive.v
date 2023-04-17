module test_gcd #(parameter N = 8, DEBUG = 0);
    reg C, S;
    reg [N-1:0] A, B
    wire D;
    wire [N-1:0] G;

    gcd #(.N(N)) dut(.clock(C), .start(S), .a(A), .b(B), .done(D), .g(G));

    always #10 C = ~C;

    initial begin
        if (DEBUG)
          $monitor("%6d: C=%b, S=%b, D=%b, G=%d, X=%d, Y=%d",
                   $time, C, S, D, G, dut.x, dut.y);
        else
          $monitor("%6d: S=%b, A=%d, B=%d, D=%b, G=%d", $time, S, A, B, D, G);
        C = 'b0;
        S = 'b1;
        A = 'd24;
        B = 'd60;
        #20 S = 'b0;
        @(posedge D); // wait for completion signal
        #10 if (G != 'd12) $display("Error: G=%d, not 12", G);
        S = 'b1;
        A = 'd27;
        B = 'd9;
        #20 S = 'b0;
        @(posedge D);
        #10 if (G != 'd9) $display("Error: G=%d, not 9", G);
        S = 'b1;
        A = 'd144;
        B = 'd233;
        #20 S = 'b0;
        @(posedge D);
        #10 if (G != 'd1) $display("Error: G=%d, not 1", G);
        S = 'b1;
        A = 'd3;
        B = 'd0;
        #20 S = 'b0;
        @(posedge D);
        #10 if (G != 'd3) $display("Error: G=%d, not 3", G);
        S = 'b1;
        A = 'd3;
        B = 'd233;
        #20 S = 'b0;
        @(posedge D);
        #10 if (G != 'd1) $display("Error: G=%d, not 1", G);
        $finish;
    end
endmodule

module gcd #(parameter N = 8)
    (input clock, start, input [N-1:0] a, b,
     output reg done, output reg [N-1:0] g);
    reg [N-1:0] x, y;

    always @(posedge clock)
      if (start) begin
          done <= 'b0;
          x    <= a;
          y    <= b;
      end else if (x != y && x && y) begin
          if (x < y) y <= y - x;
          else       x <= x - y;
      end
      else begin
          done <= 'b1;
          g    <= x ? x : y;
      end
endmodule
