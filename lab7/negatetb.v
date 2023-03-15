module tb;
reg [3:0]in;
wire [3:0] out;
negate tba(in, out);
initial begin
$monitor("in=%b, out=%b", in, out);
in = 3;
#1;
in = 0;
#1;
$finish;
end
endmodule