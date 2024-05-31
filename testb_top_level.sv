`timescale 1ns / 1ps

module testb_top_level;
    // Variables de prueba
    logic clk;
    logic rst;

    // Instancia del módulo top_level
    top_level uut (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;
    // Estímulo de prueba
    initial begin
        // Archivo para guardar las formas de onda
        $dumpfile("testb_top_level.vcd");
        $dumpvars(0, testb_top_level);
        // Inicializar clk y reset
        clk = 0;
        rst = 1;

        // Ciclo de reloj y secuencia de reset
        #10 rst = 0;
        #500
        $finish;
    end
endmodule