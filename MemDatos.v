module DataMemory (
    input wire clk,
    input wire [31:0] DataIn,
    input wire [31:0] Address,  // Dirección de 32 bits (usa los 7 LSBs)
    input wire W, R,
    output reg [31:0] DataOut
);
    reg [31:0] memoria [0:127]; // 128 palabras de 32 bits

    always @(posedge clk) begin
        if (W) memoria[Address[6:0]] <= DataIn;  // Escritura
        if (R) DataOut <= memoria[Address[6:0]];  // Lectura
    end
endmodule
