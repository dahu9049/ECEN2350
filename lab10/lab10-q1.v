module ClkDivider(
input mclk,
output led [15:0];
);
reg [26:0] count = 0;
always @(posedge mclk) begin
if(count == 100000000 - 1) begin
    count <= 0;
    led <= -led
end
    else begin
        count <= count + 1;
    end
end
endmodule