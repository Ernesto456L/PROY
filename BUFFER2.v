module Buffer2 (
    input wire clk,
    input wire [31:0] DR1_buf, DR2_buf, dataAluIn,
    input wire WE_in, W_in, R_in,
    output reg [31:0] DR1_final, DR2_final, dataAluOut,
    output reg WE_final, W_final, R_final
);
    always @(posedge clk) begin
        DR1_final <= DR1_buf;
        DR2_final <= DR2_buf;
        dataAluOut <= dataAluIn;
        WE_final <= WE_in;
        W_final <= W_in;
        R_final <= R_in;
    end
endmodule
