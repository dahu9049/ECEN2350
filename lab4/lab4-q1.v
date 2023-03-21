

module testb;
  reg[3:0] a, b;
  wire[3:0] s;
  wire cout;
  integer bi, ai;

  fourBitAdder fba(.x(a), .y(b), .z(s), .cout(cout));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    $monitor("%6d: a=%b, b=%b, s=%b, co=%b", $time, a, b, s, cout);

    for (ai=0; ai<16; ai=ai+1) begin
      a = ai[3:0];
      for (bi=0; bi<16; bi=bi+1) begin
        #1; b = bi[3:0];
      end
    end
    $finish;
  end
endmodule


// Inputs two bits (a, b) and outputs two bits (cout, s)
// Computes a+b and ouputs 00, 01, or 10
module half_adder(input a, b, output s, cout);
  assign s = a^b;
  assign cout = a&b;
endmodule

// This implements the truth table you saw in Lab1
module full_adder(input a, b, c, output s, cout);
  assign s = a^b^c;
  assign cout = (a&b)|(a&c)|(b&c);
endmodule


module fourBitAdder(input [3:0] x, y, output [3:0] z, output cout);
  wire co0, co1, co2, co3;
  half_adder ha0 (.a(x[0]), .b(y[0]), .s(z[0]), .cout(co0));
  full_adder fa1 (.a(x[1]), .b(y[1]), .c(co0), .s(z[1]), .cout(co1));
  full_adder fa2 (.a(x[2]), .b(y[2]), .c(co1), .s(z[2]), .cout(co2));
  full_adder fa3 (.a(x[3]), .b(y[3]), .c(co2), .s(z[3]), .cout(cout));
endmodule


// This works a different way; notice 3-bit output.
// Often helpful to have carry out instead, but this works, too
module twoBitAdder(input [1:0] x, y, output [2:0] out);
  wire co0, co1;
  half_adder a0(.a(x[0]), .b(y[0]), .s(out[0]), .cout(co0));
  full_adder a1(.a(x[1]), .b(y[1]), .c(co0),
			.s(out[1]), .cout(out[2]));
endmodule
