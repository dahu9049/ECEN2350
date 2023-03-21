module priorityEncoder32(input [31:0] in, output[4:0] out, output valid);
wire [3:0] outA, outB;
wire validA, validB;

priorityEncoder16 d0(in[15:0], outB, validB);
priorityEncoder16 d1(in[31:16], outA, validA);
assign out = validA ? {1'b1, outA}:{1'b0, outB};
assign valid = |in;

endmodule

module priorityEncoder16(input [15:0] in, output[3:0] out, output valid);
  wire [2:0] outA, outB;
  wire validA, validB;
  priorityEncoder8 d0(in[7:0], outB, validB);
  priorityEncoder8 d1(in[15:8], outA, validA);
  assign out = validA ? {1'b1, outA}:{1'b0, outB};
  assign valid = |in;
  
endmodule

module priorityEncoder8(input [7:0] in, output [2:0] out, output valid);
  assign out = in[7] ? 3'b111 : in[6] ? 3'b110 : in[5] ? 3'b101 : in[4] ? 3'b100 : in[3] ? 3'b011 : in[2] ? 3'b010 : in[1] ? 3'b001 : in[0] ? 3'b000 : 3'b000;
  assign valid = |in;
endmodule

// module decoder16a(input [3:0] in, output [15:0] out);
//   wire [15:0] tmp;
//   decoder8a d0(in[2:0], tmp[7:0]);
//   decoder8a d1(in[2:0], tmp[15:8]);
  
//   assign out[7:0] = in[3] ? 8'b00000000 : tmp[7:0];
//   assign out[15:8] = in[3] ? tmp[15:8] : 8'b00000000;
// endmodule

// module decoder8b(input [2:0] in, output [7:0] out);
//     wire [7:0] tmp;
//     // Make two decoders, both input low 2-bits of in
//     // If in[2] is 0, then we take first decoder (tmp[3:0]) -> out[3:0]
//     // If in[2] is 1, then we take second decoder (tmp[7:4]) -> out[7:4]
//     decoder4b d0(in[1:0], tmp[3:0]);
//     decoder4b d1(in[1:0], tmp[7:4]);
//     assign out[3:0] = in[2] ? 4'b0000 : tmp[3:0];
//     assign out[7:4] = in[2] ? tmp[7:4] : 4'b0000;
// endmodule