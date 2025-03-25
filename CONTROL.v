module Control (
    input wire [3:0] opcode,
    output reg WE, demux_sel, W, R,
    output reg [3:0] alucode
);
    always @(*) begin
        case (opcode)
            4'd1: begin WE=1; demux_sel=0; W=0; R=0; alucode=4'b0000; end
            4'd2: begin WE=1; demux_sel=0; W=0; R=0; alucode=4'b0001; end
            4'd3: begin WE=1; demux_sel=0; W=0; R=0; alucode=4'b0010; end
            4'd4: begin WE=1; demux_sel=0; W=0; R=0; alucode=4'b0110; end
            4'd5: begin WE=1; demux_sel=0; W=0; R=0; alucode=4'b0111; end
            4'd6: begin WE=1; demux_sel=0; W=0; R=0; alucode=4'b1100; end
            4'd7: begin WE=0; demux_sel=1; W=1; R=0; alucode=4'b0000; end // SW
            default: begin WE=0; demux_sel=0; W=0; R=0; alucode=4'b0000; end
        endcase
    end
endmodule
