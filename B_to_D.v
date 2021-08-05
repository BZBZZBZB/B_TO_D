module B_to_D(
    input clk,
    input rst_n,
    input [7:0]bin_data,
    output [9:0]decimal,
    output en
);
//移位寄存器
reg [17:0] shift_reg;
//十进制的个位，十位，百位
reg [3:0] one_reg;
reg [3:0] ten_reg;
reg [1:0] hun_reg;
reg [3:0] count;
//用于技术，移位八次
always @(posedge clk)begin
    if(~rst_n)begin
        count <= 0;
    end
    else if(count == 4'd8) begin
        count <= count;
    end
    else begin
        count <= count + 1'b1;
    end
end

always @(*)begin
    if(~rst_n)begin
        one_reg = 0;
        ten_reg = 0;
        hun_reg = 0;
        shift_reg = {10'b0,bin_data};
    end
    else if(count == 4'd8) begin
        one_reg = shift_reg[11:8];
        ten_reg = shift_reg[15:12];
        hun_reg = shift_reg[17:16];
    end
    else begin
        if(shift_reg[11:8] >= 5)begin
            shift_reg[11:8] = shift_reg[11:8] + 3'b11;
            if(shift_reg[15:12] >= 5)begin
                shift_reg[15:12] = shift_reg[15:12] + 3'b11;
                shift_reg = shift_reg << 1;
            end
            else begin
                shift_reg[15:12] = shift_reg[15:12];
                shift_reg = shift_reg << 1;
            end
        end
        else begin
            shift_reg[11:8] = shift_reg[11:8];
            shift_reg = shift_reg << 1;
        end
    end
end

assign decimal = {hun_reg,ten_reg,one_reg};
assign en = count == 4'd8 ? 1 : 0;


endmodule