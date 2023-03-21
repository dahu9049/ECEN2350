module test;
  reg a, b, sel;
  wire out;
  integer i;

  selector2 s2(a, b, sel, out);

  initial begin
  	$monitor("%6d: a=%b, b=%b, sel=%b, out=%b", $time, a, b, sel, out);  
    for (i=0; i<8; i=i+1) begin
      sel = i[0];
      b = i[1];
      a = i[2];
      #1;
      if ((!sel && out!=a) || (sel && out!=b))
        $display("ERROR wrong output!");
    end
    $finish;
  end
 endmodule
