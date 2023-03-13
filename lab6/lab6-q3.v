module buttonHexEncode(input [15:0] sw, input [3:0] btn, output reg [7:0] D1_seg, output reg [3:0] D1_a, output [3:0] D0_a);
    always @* begin
        if(btn[3] == 1) begin
            D1_a = {1'b0, 1'b1, 1'b1, 1'b1};
            case(sw[15:12])
                4'b0000 : D1_seg = 8'b11000000; // 0
                4'b0001 : D1_seg = 8'b11111001; // 1
                4'b0010 : D1_seg = 8'b10100100; // 2
                4'b0011 : D1_seg = 8'b10110000; // 3
                4'b0100 : D1_seg = 8'b10011001; // 4
                4'b0101 : D1_seg = 8'b10010010; // 5
                4'b0110 : D1_seg = 8'b10000010; // 6 
                4'b0111 : D1_seg = 8'b11111000; // 7
                4'b1000 : D1_seg = 8'b10000000; // 8
                4'b1001 : D1_seg = 8'b10010000; // 9
                4'b1010 : D1_seg = 8'b10001000; // 10
                4'b1011 : D1_seg = 8'b10000011; // 11
                4'b1100 : D1_seg = 8'b11000110; // 12
                4'b1101 : D1_seg = 8'b10100001; // 13
                4'b1110 : D1_seg = 8'b10000110; // 14
                4'b1111 : D1_seg = 8'b10001110; // 15
            endcase
        end
        else if((btn[2] == 1) & (btn[3] == 0)) begin
            D1_a = {1'b1, 1'b0, 1'b1, 1'b1};
            case(sw[11:8])
                4'b0000 : D1_seg = 8'b11000000; // 0
                4'b0001 : D1_seg = 8'b11111001; // 1
                4'b0010 : D1_seg = 8'b10100100; // 2
                4'b0011 : D1_seg = 8'b10110000; // 3
                4'b0100 : D1_seg = 8'b10011001; // 4
                4'b0101 : D1_seg = 8'b10010010; // 5
                4'b0110 : D1_seg = 8'b10000010; // 6 
                4'b0111 : D1_seg = 8'b11111000; // 7
                4'b1000 : D1_seg = 8'b10000000; // 8
                4'b1001 : D1_seg = 8'b10010000; // 9
                4'b1010 : D1_seg = 8'b10001000; // 10
                4'b1011 : D1_seg = 8'b10000011; // 11
                4'b1100 : D1_seg = 8'b11000110; // 12
                4'b1101 : D1_seg = 8'b10100001; // 13
                4'b1110 : D1_seg = 8'b10000110; // 14
                4'b1111 : D1_seg = 8'b10001110; // 15
            endcase
        end
        else if((btn[1] == 1) & (btn[2] == 0) & (btn[3] == 0)) begin
            D1_a = {1'b1, 1'b1, 1'b0, 1'b1};
            case(sw[7:4])
                4'b0000 : D1_seg = 8'b11000000; // 0
                4'b0001 : D1_seg = 8'b11111001; // 1
                4'b0010 : D1_seg = 8'b10100100; // 2
                4'b0011 : D1_seg = 8'b10110000; // 3
                4'b0100 : D1_seg = 8'b10011001; // 4
                4'b0101 : D1_seg = 8'b10010010; // 5
                4'b0110 : D1_seg = 8'b10000010; // 6 
                4'b0111 : D1_seg = 8'b11111000; // 7
                4'b1000 : D1_seg = 8'b10000000; // 8
                4'b1001 : D1_seg = 8'b10010000; // 9
                4'b1010 : D1_seg = 8'b10001000; // 10
                4'b1011 : D1_seg = 8'b10000011; // 11
                4'b1100 : D1_seg = 8'b11000110; // 12
                4'b1101 : D1_seg = 8'b10100001; // 13
                4'b1110 : D1_seg = 8'b10000110; // 14
                4'b1111 : D1_seg = 8'b10001110; // 15
            endcase
        end
        else if((btn[0] == 1) &(btn[1] == 0) &  (btn[2] == 0) &  (btn[3] == 0)) begin
            D1_a = {1'b1, 1'b1, 1'b1, 1'b0};
            case(sw[3:0])
                4'b0000 : D1_seg = 8'b11000000; // 0
                4'b0001 : D1_seg = 8'b11111001; // 1
                4'b0010 : D1_seg = 8'b10100100; // 2
                4'b0011 : D1_seg = 8'b10110000; // 3
                4'b0100 : D1_seg = 8'b10011001; // 4
                4'b0101 : D1_seg = 8'b10010010; // 5
                4'b0110 : D1_seg = 8'b10000010; // 6 
                4'b0111 : D1_seg = 8'b11111000; // 7
                4'b1000 : D1_seg = 8'b10000000; // 8
                4'b1001 : D1_seg = 8'b10010000; // 9
                4'b1010 : D1_seg = 8'b10001000; // 10
                4'b1011 : D1_seg = 8'b10000011; // 11
                4'b1100 : D1_seg = 8'b11000110; // 12
                4'b1101 : D1_seg = 8'b10100001; // 13
                4'b1110 : D1_seg = 8'b10000110; // 14
                4'b1111 : D1_seg = 8'b10001110; // 15
            endcase
        end
        else D1_a = {1'b1, 1'b1, 1'b1, 1'b1};
    end
    assign D0_a = {1'b1, 1'b1, 1'b1, 1'b1};
endmodule