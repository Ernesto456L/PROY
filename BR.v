module BR (
    input wire clk,
    input wire [4:0] RA1, RA2, WA,
    input wire WE,
    input wire [31:0] DW,
    output wire [31:0] DR1, DR2
);
    reg [31:0] registros [0:15]; // 15 registros de 32 bits

    initial begin
        $readmemb("datos.txt", registros); // Inicialización desde archivo
    end

    assign DR1 = registros[RA1]; // Lectura asíncrona
    assign DR2 = registros[RA2];

    always @(posedge clk) begin
        if (WE) begin registros[WA] <= DW;
        end
    end
endmodule
