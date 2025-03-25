module Buffer1 (
    input wire clk,
    input wire [31:0] DR1, DR2,
    input wire demux_sel_in, WE_in, W_in, R_in,
    input wire [3:0] alucode_in,
    output reg [31:0] DR1_out, DR2_out,
    output reg demux_sel_out, WE_out, W_out, R_out,
    output reg [3:0] alucode_out
);
    always @(posedge clk) begin
        DR1_out <= DR1;
        DR2_out <= DR2;
        demux_sel_out <= demux_sel_in;
        WE_out <= WE_in;
        W_out <= W_in;
        R_out <= R_in;
        alucode_out <= alucode_in;
    end
endmodule
