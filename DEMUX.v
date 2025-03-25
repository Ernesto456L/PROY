module Demux (
    input wire demux_sel,
    input wire [31:0] DR1_buffered,
    output wire [31:0] to_ALU,
    output wire [31:0] to_Memory
);
    assign to_ALU = (demux_sel == 0) ? DR1_buffered : 32'b0;
    assign to_Memory = (demux_sel == 1) ? DR1_buffered : 32'b0;
endmodule
