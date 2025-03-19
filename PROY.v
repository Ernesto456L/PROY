module PROY (
    input [16:0] instruction,  // Entrada de 17 bits que contiene las instrucciones
    output [31:0] dataOut, // Salida de 32 bits (proveniente de la RAM)
	input clk
);

