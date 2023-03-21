// Code your testbench here
// or browse Examples
module testb;
  reg a, b, c;
  wire and_out, or_out, xor_out, maj_out;
  integer i;
  //reg g;
  reg ga, go, gx, gm;

  and2 a2 (a, b, and_out);
  or2  o2 (a, b, or_out);
  xor2 x2 (a, b, xor_out);
  majority m (a, b, c, maj_out);
  

  initial begin
    ga = 1;
    go = 1;
    gx = 1;
    gm = 1;
    $dumpfile("dump.vcd");
    $dumpvars;
    $monitor("%6d: a=%b, b=%b, c=%b, a&b=%b, a|b=%b, a^b=%b, maj(a,b,c)=%b, right:%b", $time, a, b, c, and_out, or_out, xor_out, maj_out, g);

    
    for (i=0; i<8; i=i+1) begin

      a = i[0];
      b = i[1];
      c = i[2];
      #1;
      ga = ga & (and_out==(a&b));
      gx = gx & (xor_out==(a^b));
      go = go & (or_out==(a|b));
      gm = gm & (maj_out==((a&b)|(b&c)|(a&c)));
      //g = (g) & (and_out==(a&b)) & (or_out==(a|b)) & (xor_out==(a^b)) & (maj_out==((a&b)|(b&c)|(a&c)));
    end
    #1;
    $display("%s", (ga)?"AND correct" : "AND incorrect");
    $display("%s", gx?"XOR correct" : "XOR incorrect");
    $display("%s", go?"OR correct" : "OR incorrect");
    $display("%s", gm?"Majority correct" : "Majority incorrect");
    
    $display("%s", (ga&gx&go&gm)?"All correct!" : "Incorrect output, see above");   
    $finish;
  end
endmodule
