//Testbench for decoder4
module test;
  reg [1:0] in;
  wire a, b, c, d;

  decoder4a d0(in, a, b, c, d);
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    $monitor("in=%b, a=%b, b=%b, c=%b, d=%b", in, a, b, c, d);

    in = 2'b00;
    #1;
    in = 2'b01;
    #1;
    in = 2'b10;
    #1;
    in = 2'b11;
    #1;

    $finish;
  end
endmodule

////////////////////////////////////
// Design
module decoder4a(input [1:0] in, output a, b, c, d);
  assign a = ~in[1] & ~in[0];
  assign b = ~in[1] & in[0];
  assign c = in[1] & ~in[0];
  assign d = in[1] & in[0];
endmodule


// We could also define the decode 4 using case
// statements:
module decoder4b(input [1:0] in, output [3:0] out);
    reg [3:0] tmp;

    always @(in) begin
        case (in)
            2'b00: tmp = 4'b0001;
            2'b01: tmp = 4'b0010;
            2'b10: tmp = 4'b0100;
            2'b11: tmp = 4'b1000;
            default: tmp = 4'b0000; // Shouldn't happen!
        endcase
    end
    assign out = tmp;
endmodule

// We can also use bit-shifts to implement
// our decoder: (e.g. shift 0001 to the left to get 0010)
// If we shift 0001 to the left based on in, we get the decoded value.
module decoder4c(input [1:0] in, output [3:0] out);
    assign out = 1 << in;
endmodule

// Building a decoder8 from decoder4
module decoder8a(input [2:0] in, output [7:0] out);
  wire [3:0] tmpA;
  wire [3:0] tmpB;
  wire [3:0] outA;
  wire [3:0] outB;
  
  decoder4b d0(in[1:0], tmpA[0], tmpA[1], tmpA[2], tmpA[3]);
  decoder4b d1(in[1:0], tmpB[0], tmpB[1], tmpB[2], tmpB[3]);
  
  // Select each bit of outA (first 4-bits of our output)
  // based on MSB of in (in[2]). If it's 0, we output 0
  // otherwise output tmpA
  assign outA[3] = tmpA[3] & in[2];
  assign outA[2] = tmpA[2] & in[2];
  assign outA[1] = tmpA[1] & in[2];
  assign outA[0] = tmpA[0] & in[2];
  
  // Same for outB, but if in[2] is 1 we output 0
  // otherwise tmpB
  assign outB[3] = tmpB[3] & ~in[2];
  assign outB[2] = tmpB[2] & ~in[2];
  assign outB[1] = tmpB[1] & ~in[2];
  assign outB[0] = tmpB[0] & ~in[2];
  
  // 8-bit output is 4-bits from outA then 4-bits from outB.
  assign out = {outA, outB};
  
endmodule


// A slightly optimized decoder8 from decoder4
module decoder8b(input [2:0] in, output [7:0] out);
  wire [3:0] tmpA;
  wire [3:0] outA;
  wire [3:0] outB;

  // Here we realize we only need a single decoder,
  // and we can use the output twice)
  decoder4a d0(in[1:0], tmpA[0], tmpA[1], tmpA[2], tmpA[3]);
  //decoder4a d1(in[1:0], tmpB[0], tmpB[1], tmpB[2], tmpB[3]);
  
  // Ternary operator:
  //assign X = (condition) ? true_exn : false_exn;
  // X will be true_exn if (condition) is true, otherwise X will be false_exn.
  // Equivalently:
  // if (condition) X = true_exn;
  // else 			X = false_exn;

  assign outA = (in[2]) ? tmpA : 4'b0000;
  //assign outA[3] = tmpA[3] & in[2];
  //assign outA[2] = tmpA[2] & in[2];
  //assign outA[1] = tmpA[1] & in[2];
  //assign outA[0] = tmpA[0] & in[2];
  
  //assign outB = (~in[2]) : tmpA : 4'b0000;
  assign outB = (in[2]) ? 4'b0000 : tmpA;
  //assign outB[3] = tmpA[3] & ~in[2];
  //assign outB[2] = tmpA[2] & ~in[2];
  //assign outB[1] = tmpA[1] & ~in[2];
  //assign outB[0] = tmpA[0] & ~in[2];
  
  assign out = {outA, outB};
  // Equivalently
  /*assign out = (in[2]) ? {tmpA, 4'b0000} :
  						 { 4'b0000 : tmpA};
  assign out = {(in[2]) ? tmpA : 4'b0000,
                (in[2]) : 4'b0000 : tmpA};
  */
endmodule



module decoder8b(input [2:0] in, output [7:0] out);
    wire [7:0] tmp;
    // Make two decoders, both input low 2-bits of in
    // If in[2] is 0, then we take first decoder (tmp[3:0]) -> out[3:0]
    // If in[2] is 1, then we take second decoder (tmp[7:4]) -> out[7:4]
    decoder4b d0(in[1:0], tmp[3:0]);
    decoder4b d1(in[1:0], tmp[7:4]);

    assign out[3:0] = in[2] ? 4'b0000 : tmp[3:0];
    assign out[7:4] = in[2] ? tmp[7:4] : 4'b0000;

    // Could also do the previous two lines in one:
    // assign out = in[2] ? {tmp[7:4], 4'b0000} : {4'b0000, tmp[3:0]};
endmodule


// And again for a 16-bit version:
module decoder16a(input [3:0] in, output [15:0] out);
  wire [15:0] tmp;
  decoder8a d0(in[2:0], tmp[7:0]);
  decoder8a d1(in[2:0], tmp[15:8]);
  
  assign out[7:0] = in[3] ? 8'b00000000 : tmp[7:0];
  assign out[15:8] = in[3] ? tmp[15:8] : 8'b00000000;
endmodule

// Could also build from decoder4 if we wanted...
module decoder16b(input [3:0] in, output [15:0] out);
  
  wire [15:0] tmp;
  
  decoder4b d0(in[1:0], tmp[3:0]);
  decoder4b d1(in[1:0], tmp[7:4]);
  decoder4b d2(in[1:0], tmp[11:8]);
  decoder4b d3(in[1:0], tmp[15:12]);

  assign out[3:0]   = in[3:2]==2'b00 ? tmp[3:0] : 4'b0000;
  assign out[7:4]   = in[3:2]==2'b01 ? tmp[7:4] : 4'b0000;
  assign out[11:8]  = in[3:2]==2'b10 ? tmp[11:8] : 4'b0000;
  assign out[15:12] = in[3:2]==2'b11 ? tmp[15:12] : 4'b0000;
endmodule

// Finally, we can define a parameterized version:
module decoderN
  #(parameter WIDTH=16)
  (input [$clog2(WIDTH)-1:0] in, output [WIDTH-1:0] out);

  assign out = 1 << in;

endmodule



/*
module tb2;

  wire [5:0] in;
  wire [63:0] out;
  integer i;
  assign in = i[5:0];
  decoderN #(.WIDTH(64)) dd(in, out);

  initial begin
    $monitor("in: %b out: %b", in, out);
    for (i=0; i<16; i=i+1) begin
    	#1;

    end
    $finish;
  end

endmodule

*/
