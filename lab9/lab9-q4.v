//Uses btn[0] and btn[1] as clocks
//set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets btn[0]];
//set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets btn[1]];

module adder16(
input [15:0] sw,
input [3:0] btn,
output reg [15:0] led
);
    reg [15:0] operand_a;
    reg [15:0] operand_b;
    always @ (*) begin
        if(btn[0]) operand_a <= sw;
        if(btn[1]) operand_b <= sw;
        led <= operand_a + operand_b;
    end
endmodule