`timescale 1ns / 1ps
module TB_Proyecto;
    reg clk;
    reg [18:0] instruccion;
    wire [31:0] DATAOUT;

    Proyecto uut (.clk(clk), .instruccion(instruccion), .DATAOUT(DATAOUT));

    always #5 clk = ~clk;

    initial begin
    clk = 0;
    // 1. Suma: Pos0 + Pos2 → Pos4
    instruccion = 19'b0011_00100_00000_00001; // ADD
    #50;

    // 2. Resta: Pos1 - Pos2 → Pos5
    instruccion = 19'b0100_00101_00001_00010; // SUB
    #50;
    // 3. Comparación: Pos2 < Pos3 → Pos6
    instruccion = 19'b0101_00110_00010_00011; // SLT
    #50
    // 4. SW: Mem[Pos7=20] = Pos4=211
    instruccion = 19'b0111_00000_00111_00100; // SW
    #50;
    // 5. SW: Mem[Pos8=21] = Pos5=122
    instruccion = 19'b0111_00000_01000_00101; // SW
    #50;
    // 6. SW: Mem[Pos9=22] = Pos6=1
    instruccion = 19'b0111_00000_01001_00110; // SW
    #50;
	
	$dumpfile("wave.vcd");         // Nombre del archivo de wave
    $dumpvars(0, TB_Proyecto);     // Grabar todas las señales del testbench
    #100;                          // Tiempo de simulación adicional
    $finish;
	
    end
endmodule
