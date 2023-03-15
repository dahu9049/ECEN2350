module negate(input [3:0] in, output reg [3:0] out);
    integer i;
    always @* begin
        for(i = 0; i < 4; i = i + 1) begin
            if(in[i] == 1) out[i] = 0;
            else out[i] = 1;
            
        end
    end
endmodule