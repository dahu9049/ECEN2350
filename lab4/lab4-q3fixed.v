module selector2(input a, b, s, output out);
  // assign out = (b~&s)~&(~s~&a);
  assign out = (a&~s) | (b&s);
endmodule
