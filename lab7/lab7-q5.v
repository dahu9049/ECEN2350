module hexEncode(input [3:0] sw, output reg [7:0] D1_seg, D0_seg, output [3:0] D1_a, D0_a);
    always @(sw) begin
        case(sw)
            4'b0000 : D1_seg = 8'b11000000; // 0
            4'b0001 : D1_seg = 8'b11111001; // 1
            4'b0010 : D1_seg = 8'b10100100; // 2
            4'b0011 : D1_seg = 8'b10110000; // 3
            4'b0100 : D1_seg = 8'b10011001; // 4
            4'b0101 : D1_seg = 8'b10010010; // 5
            4'b0110 : D1_seg = 8'b10000010; // 6 
            4'b0111 : D1_seg = 8'b11111000; // 7
            4'b1000 : begin D1_seg = 8'b10000000; // -8
                            assign D1_seg[6] = 0;
                        end
            4'b1001 : begin D1_seg = 8'b11111000; // -7
                            assign D1_seg[6] = 0;              
                        end
            4'b1010 : begin D1_seg = 8'b10000010; // -6
                            assign D1_seg[6] = 0;
                        end
            4'b1011 : begin D1_seg = 8'b10010010; // -5
                            assign D1_seg[6] = 0;
                        end
            4'b1100 : begin D1_seg = 8'b10011001; // -4
                            assign D1_seg[6] = 0;
                        end
            4'b1101 : begin D1_seg = 8'b10110000; // -3
                            assign D1_seg[6] = 0;
                        end
            4'b1110 :begin D1_seg = 8'b10100100; // -2
                            assign D1_seg[6] = 0;
                        end
            4'b1111 :begin D1_seg = 8'b11111001; // -1
                            assign D1_seg[6] = 0;
                        end
        endcase
    end

    assign D1_a = {1'b1, 1'b1, 1'b1, 1'b0};
    assign D0_a = {1'b1, 1'b1, 1'b1, 1'b0};

endmodule