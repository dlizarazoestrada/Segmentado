module testb_registers_unit;
    // Tiempo
    timeunit 1ns;
    timeprecision 1ps;

    // Dumbvars
    reg clk;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg [31:0] dataWr;
    reg ruWr;
    wire [31:0] ruRs1;
    wire [31:0] ruRs2;

    // Instancia del módulo
    registers_unit uut (
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .dataWr(dataWr),
        .ruWr(ruWr),
        .ruRs1(ruRs1),
        .ruRs2(ruRs2)
    );

    // Generación de la señal de reloj
    always begin
        #5 clk = ~clk;
    end

    // Test
    initial begin
        // generación de dumbvars y dumbvarfiles
        $dumpfile("testb_registers_unit.vcd");
        $dumpvars(0, testb_registers_unit);
        // Inicialización
        clk = 0;
        rs1 = 5'b00000;
        rs2 = 5'b00000;
        rd = 5'b00000;
        dataWr = 32'b0;
        ruWr = 0;

        // Test 1
        #10 rd = 5'b00001; dataWr = 32'h12345678; ruWr = 1;
        #10 rs1 = 5'b00001; ruWr = 0;
        #10 $display("ruRs1: %h", ruRs1);

        // Test 2
        #10 rd = 5'b00010; dataWr = 32'h87654321; ruWr = 1;
        #10 rs2 = 5'b00010; ruWr = 0;
        #10 $display("ruRs2: %h", ruRs2);

        // Fin de la simulación
        #10 $finish;
    end
endmodule