module Proyecto (
    input wire clk,
    input wire [18:0] instruccion,
    output wire [31:0] DATAOUT
);
    //=== Parámetros y señales ===//
    // Decodificación de la instrucción
    wire [3:0] opcode = instruccion[18:15];
    wire [4:0] WA = instruccion[14:10];
    wire [4:0] RA1 = instruccion[9:5];
    wire [4:0] RA2 = instruccion[4:0];

    // Señales intermedias
    wire [31:0] DR1, DR2, DW;
    wire WE, demux_sel, W, R;
    wire [3:0] alucode_control;          // 4 bits (desde Control)
    wire [3:0] alucode_buffer_to_alu;    // 4 bits (desde Buffer1)
    
    wire [31:0] DR1_buf, DR2_buf;
    wire demux_sel_buf, WE_buf, W_buf, R_buf;
    
    wire [31:0] demux_to_ALU, demux_to_Mem;
    wire [31:0] dataAluIn, dataAluOut_buf;
    wire [31:0] memAddr, memDataIn;
    wire WE_final, W_mem, R_mem;

    //=== Instancias de módulos ===//
    // Banco de Registros
    BR banco_registros (
        .clk(clk),
        .RA1(RA1),
        .RA2(RA2),
        .WA(WA),
        .WE(WE_final),
        .DW(dataAluOut_buf),
        .DR1(DR1),
        .DR2(DR2)
    );

    // Módulo de Control
    Control control (
        .opcode(opcode),
        .WE(WE),
        .demux_sel(demux_sel),
        .W(W),
        .R(R),
        .alucode(alucode_control)        // 4 bits
    );

    // Buffer1
    Buffer1 buffer1 (
        .clk(clk),
        .DR1(DR1),
        .DR2(DR2),
        .demux_sel_in(demux_sel),
        .WE_in(WE),
        .W_in(W),
        .R_in(R),
        .alucode_in(alucode_control),    // 4 bits
        .DR1_out(DR1_buf),
        .DR2_out(DR2_buf),
        .demux_sel_out(demux_sel_buf),
        .WE_out(WE_buf),
        .W_out(W_buf),
        .R_out(R_buf),
        .alucode_out(alucode_buffer_to_alu) // 4 bits
    );

    // Demux
    Demux demux (
        .demux_sel(demux_sel_buf),
        .DR1_buffered(DR1_buf),
        .to_ALU(demux_to_ALU),
        .to_Memory(demux_to_Mem)
    );

	assign DW = dataAluOut_buf;
    // ALU
    ALU alu (
        .data1(demux_to_ALU),
        .data2(DR2_buf),
        .alucode(alucode_buffer_to_alu),  // 4 bits
        .dataOut(dataAluIn)
    );

    // Buffer2
    Buffer2 buffer2 (
        .clk(clk),
        .DR1_buf(demux_to_Mem),
        .DR2_buf(DR2_buf),
        .dataAluIn(dataAluIn),
        .WE_in(WE_buf),
        .W_in(W_buf),
        .R_in(R_buf),
        .DR1_final(memAddr),
        .DR2_final(memDataIn),
        .dataAluOut(dataAluOut_buf),
        .WE_final(WE_final),
        .W_final(W_mem),
        .R_final(R_mem)
    );

    // Memoria de Datos
    DataMemory memoria (
        .clk(clk),
        .DataIn(memDataIn),
        .Address(memAddr),               // 32 bits
        .W(W_mem),
        .R(R_mem),
        .DataOut(DATAOUT)
    );

endmodule
