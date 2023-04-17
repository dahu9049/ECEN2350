module ClkDivider (
    input mclk, rst,
    output reg mclk_div
    );
	
localparam terminalcount = 50000000;
reg [15:0] count;
wire tc;

assign tc = (count == terminalcount);	// Place a comparator on the counter output

always @ (posedge(mclk), posedge(rst))
begin
    if (rst) count <= 0;
    else if (tc) count <= 0;		// Reset counter when terminal count reached
    else count <= count + 1;
end

always @ (posedge(mclk), posedge(rst))
begin
    if (rst) mclk_div <= 0;
    else if (tc) mclk_div = !mclk_div;	// T-FF with tc as input signal
end
endmodule

