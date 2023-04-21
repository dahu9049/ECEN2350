module ClkHexScroll(
    input mclk,
    input [15:0] sw,
    output reg [3:0] D0_a,
    output reg [7:0] D0_seg
);
reg [26:0] count = 0;
reg [2:0] digitSelect = 0;
wire [7:0] seg0, seg1, seg2, seg3;
hexEncode he0(sw[3:0], seg0);     
hexEncode he1(sw[7:4], seg1);     
hexEncode he2(sw[11:8], seg2);     
hexEncode he3(sw[15:12], seg3); 

always @(posedge mclk) begin
    if(count == 100000 - 1) begin
        count <= 0;
        digitSelect <= digitSelect + 1;
        case(digitSelect)
            2'b00 : begin
                        D0_seg = seg0;
                        D0_a = 4'b1110;
                    end
            2'b01 : begin
                        D0_seg = seg1;
                        D0_a = 4'b1101;
                    end
            2'b10 : begin
                        D0_seg = seg2;
                        D0_a = 4'b1011;
                    end
            2'b11 : begin
                        D0_seg = seg3;
                        D0_a = 4'b0111;
                    end
        endcase
    end
        else begin
            count <= count + 1;
        end
end
endmodule

module hexEncode(input [3:0] switch, output reg [7:0] segment);
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
            4'b1010 : segment = 8'b10001000; // 10
            4'b1011 : segment = 8'b10000011; // 11
            4'b1100 : segment = 8'b11000110; // 12
            4'b1101 : segment = 8'b10100001; // 13
            4'b1110 : segment = 8'b10000110; // 14
            4'b1111 : segment = 8'b10001110; // 15
        endcase
    end
endmodule