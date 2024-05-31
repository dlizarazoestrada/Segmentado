module testb_branch_unit;
    // Tiempo
    timeunit 1ns;
    timeprecision 1ps;

    // Dumbvars
    reg [4:0] brOp;
    reg [31:0] ruRs1;
    reg [31:0] ruRs2;
    wire nextPcSrc;

    // Dumbvarfile
    initial begin
        $dumpfile("testb_branch_unit.vcd");
        $dumpvars(0, testb_branch_unit);
    end

    // Instancia del módulo
    branch_unit uut (
        .brOp(brOp),
        .ruRs1(ruRs1),
        .ruRs2(ruRs2),
        .nextPcSrc(nextPcSrc)
    );

    // Test
    initial begin
        // Inicialización
        brOp = 5'b00000;
        ruRs1 = 32'h0;
        ruRs2 = 32'h0;

        // Test 1: brOp = 5'b00xxx
        #10 brOp = 5'b01000; ruRs1 = 32'h7; ruRs2 = 32'h3;
        #10 $display("nextPcSrc: %b", nextPcSrc);

        // Test 2: brOp = 5'b1xxxx
        #10 brOp = 5'b01101; ruRs1 = 32'h7; ruRs2 = 32'h3;
        #10 $display("nextPcSrc: %b", nextPcSrc);

        // Fin de la simulación
        #10 $finish;
    end
endmodule