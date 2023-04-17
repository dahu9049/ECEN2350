module test_gcd #(parameter N = 8, DEBUG = 0);
    reg C, S;
    reg [N-1:0] A, B;
    wire D;
    wire [N-1:0] G;
    gcd #(.N(N)) dut(.clock(C), .start(S), .a(A), .b(B), .done(D), .g(G));
    always #10 C = ~C;

    initial begin
        if (DEBUG)
          $monitor("%6d: C=%b, S=%b, D=%b, G=%d, X=%d, Y=%d, L=%d",
                   $time, C, S, D, G, dut.x, dut.y, dut.lsb);
        else
          $monitor("%6d: S=%b, A=%d, B=%d, D=%b, G=%d", $time, S, A, B, D, G);
        C = 'b0;
        S = 'b1;
        A = 'd24;
        B = 'd60;
        #20 S = 'b0;
        @(posedge D); // wait for completion signal
        #10 //assert(G == 'd12);
        S = 'b1;
        A = 'd27;
        B = 'd9;
        #20 S = 'b0;
        @(posedge D);
        #10 //assert(G == 'd9);
        S = 'b1;
        A = 'd144;
        B = 'd233;
        #20 S = 'b0;
        @(posedge D);
        #10 //assert(G == 'd1);
        S = 'b1;
        A = 'd3;
        B = 'd0;
        #20 S = 'b0;
        @(posedge D);
        #10 //assert(G == 'd3);
        S = 'b1;
        A = 'd3;
        B = 'd233;
        #20 S = 'b0;
        @(posedge D);
        #10 //assert(G == 'd1);
        $finish;
    end
    
endmodule

module gcd #(parameter N = 8)
    (input clock, start, input [N-1:0] a, b,
     output reg done, output reg [N-1:0] g);

    reg [$clog2(N)-1:0] lsb;
    reg [N-1:0]         x, y;

    always @(posedge clock) begin
      if (start) begin
          done <= 'b0;
          x    <= a;
          y    <= b;
          lsb  <= 'b0;
      end else if (x != y && x && y) begin
          case ({x[lsb], y[lsb]})
            'b00:        lsb <= lsb + 'b1;
            'b01:        x   <= x >> 'b1;
            'b10:        y   <= y >> 'b1;
            'b11:
              if (x < y) y   <= (y - x) >> 'b1;
              else       x   <= (x - y) >> 'b1;
          endcase
      end
      else begin
          done <= 'b1;
          g    <= x ? x : y;
      end
    end
endmodule
