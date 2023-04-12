module shiftRegister(
    input [3:0] btn,
    input [15:0] sw, 
    output reg [15:0] led
);
    always @(posedge btn[0]) begin
        led <= {sw[15], led[15:1]};
    end
endmodule