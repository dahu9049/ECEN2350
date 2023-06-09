module msStopwatch(
    input mclk,
    input [1:0] btn, //[0] is reset, [1] is start
    output reg [3:0] D1_a,
    output reg [7:0] D1_seg
);
reg [26:0] count = 0;
reg [2:0] digitSelect = 0;
reg [3:0] digit0, digit1, digit2, digit3;
reg start = 1;

wire [7:0] seg0, seg1, seg2, seg3;
binEncode be0(digit0, seg0); 
binEncode be1(digit1, seg1);     
binEncode be2(digit2, seg2);     
binEncode be3(digit3, seg3);

always @(posedge mclk) begin //multiplexor
    if(count == 100000 - 1) begin
        digitSelect <= digitSelect + 1;
        case(digitSelect)
            2'b00 : begin
                        D1_seg <= seg0;
                        D1_a <= 4'b1110;
                    end
            2'b01 : begin
                        D1_seg <= seg1;
                        D1_a <= 4'b1101;
                    end
            2'b10 : begin
                        D1_seg <= seg2;
                        D1_a <= 4'b1011;
                    end
            2'b11 : begin
                        D1_seg = seg3;
                        D1_seg[7] = 0;
                        D1_a <= 4'b0111;
                    end
        endcase
    end
end

always@(posedge btn[1])begin //pause on btn[1] press
    start <= ~start;
end

always@(posedge mclk) begin //counter
        if(count == 100000 - 1) count <= 0;
        else count <= count + 1;
end

always@(posedge mclk or posedge btn[0]) begin //actual numbers increment 
    if(btn[0]) begin
        digit0 <= 0;
        digit1 <= 0;
        digit2 <= 0;
        digit3 <= 0;
    end
    else if((start) & (count == 100000 - 1)) begin
        digit0 <= digit0 + 1;
        if(digit0 == 10) begin
            digit0 <= 0;
            digit1 <= digit1 + 1;
        end
        if(digit1 == 10) begin
            digit1 <= 0;
            digit2 <= digit2 + 1;
            end
        if(digit2 == 10) begin
            digit2 <= 0;
            digit3 <= digit3 + 1;
        end
        if(digit3 == 10) digit3 <= 0;
    end
end

endmodule

module binEncode(input [3:0] switch, output reg [7:0] segment);
    always @(switch) begin
        case(switch)
            4'b0000 : segment = 8'b11000000; // 0
            4'b0001 : segment = 8'b11111001; // 1
            4'b0010 : segment = 8'b10100100; // 2
            4'b0011 : segment = 8'b10110000; // 3
            4'b0100 : segment = 8'b10011001; // 4
            4'b0101 : segment = 8'b10010010; // 5
            4'b0110 : segment = 8'b10000010; // 6 
            4'b0111 : segment = 8'b11111000; // 7
            4'b1000 : segment = 8'b10000000; // 8
            4'b1001 : segment = 8'b10010000; // 9
        endcase
    end
endmodule