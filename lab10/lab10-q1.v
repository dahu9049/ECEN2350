module ClkDivider(
input mclk,
output reg [15:0] led
);
reg [26:0] count = 0;
always @(posedge mclk) begin
    if(count == 100000000 - 1) begin
        count <= 0;
        led[0] <= ~led[0];
    end
        else begin
            count <= count + 1;
        end
end
endmodule