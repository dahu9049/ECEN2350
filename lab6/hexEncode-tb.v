
module testHex;
  integer i;
  wire [7:0] hex;
  wire [7:0] s0, s1;

  // These just here to make it (slightly) harder to RE patterns from :)
  assign s0 = (i[7:0]^hex) & 170;
  assign s1 = (i[7:0]^hex) & 85;

  hexEncode h0(.bin(i[3:0]), .hex(hex));

  initial begin
    $monitor("%6d: %d => %b", $time, i, hex);

    for (i=0; i<16; i=i+1) begin
      #1;
      case (i)
		0: if (s0 != 128 || s1 != 64) $error("Incorrect %d, got %b", i, hex);
		1: if (s0 != 168 || s1 != 80) $error("Incorrect %d, got %b", i, hex);
		2: if (s0 != 162 || s1 != 4) $error("Incorrect %d, got %b", i, hex);
		3: if (s0 != 162 || s1 != 17) $error("Incorrect %d, got %b", i, hex);
		4: if (s0 != 136 || s1 != 21) $error("Incorrect %d, got %b", i, hex);
		5: if (s0 != 130 || s1 != 21) $error("Incorrect %d, got %b", i, hex);
		6: if (s0 != 128 || s1 != 4) $error("Incorrect %d, got %b", i, hex);
		7: if (s0 != 170 || s1 != 85) $error("Incorrect %d, got %b", i, hex);
		8: if (s0 != 136 || s1 != 0) $error("Incorrect %d, got %b", i, hex);
		9: if (s0 != 136 || s1 != 17) $error("Incorrect %d, got %b", i, hex);
		10: if (s0 != 130 || s1 != 0) $error("Incorrect %d, got %b", i, hex);
		11: if (s0 != 136 || s1 != 0) $error("Incorrect %d, got %b", i, hex);
		12: if (s0 != 138 || s1 != 64) $error("Incorrect %d, got %b", i, hex);
		13: if (s0 != 168 || s1 != 4) $error("Incorrect %d, got %b", i, hex);
		14: if (s0 != 136 || s1 != 0) $error("Incorrect %d, got %b", i, hex);
		15: if (s0 != 128 || s1 != 1) $error("Incorrect %d, got %b", i, hex);
      endcase
    end
    $finish;
  end
endmodule
