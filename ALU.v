module ALU (
    input wire [31:0] data1, data2,
    input wire [3:0] alucode,
    output reg [31:0] dataOut
);
    always @(*) begin
        case (alucode)
            4'b0000: dataOut = data1 & data2;
            4'b0001: dataOut = data1 | data2;
            4'b0010: dataOut = data1 + data2;
            4'b0110: dataOut = data1 - data2;
            4'b0111: dataOut = (data1 < data2) ? 32'd1 : 32'd0;
            4'b1100: dataOut = ~(data1 | data2);
            default: dataOut = 32'b0;
        endcase
    end
endmodule
