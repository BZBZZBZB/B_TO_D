module B_to_D_tb();
reg clk;
reg rst_n;
reg [7:0] bin_data;
wire [9:0]decimal;
initial begin
    clk = 0;
    rst_n = 0;
    bin_data = 8'h3c;
    #20
    rst_n = 1;
end
always #5 clk = ~clk;
B_to_D u_B_to_D(
    .clk      (clk      ),
    .rst_n    (rst_n    ),
    .bin_data (bin_data ),
    .decimal  (decimal  )
);

endmodule
