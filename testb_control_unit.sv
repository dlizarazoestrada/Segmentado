`timescale 1ns / 1ps

module testb_control_unit;

    // Parámetros
    localparam CLK_PERIOD = 10; // Periodo de reloj en ns

    // Entradas
    logic [6:0] opCode;
    logic [6:0] func7;
    logic [2:0] func3;

    // Salidas
    logic ruWr_tb;
    logic [2:0] immSrc_tb;
    logic aluASrc_tb;
    logic aluBSrc_tb;
    logic [4:0] brOp_tb;
    logic [3:0] aluOp_tb;
    logic dmWr_tb;
    logic [2:0] dmCtrl_tb;
    logic [1:0] ruDataWrSrc_tb;

    // Instancia del módulo bajo test
    control_unit dut (
        .opCode(opCode),
        .func7(func7),
        .func3(func3),
        .ruWr(ruWr_tb),
        .immSrc(immSrc_tb),
        .aluASrc(aluASrc_tb),
        .aluBSrc(aluBSrc_tb),
        .brOp(brOp_tb),
        .aluOp(aluOp_tb),
        .dmWr(dmWr_tb),
        .dmCtrl(dmCtrl_tb),
        .ruDataWrSrc(ruDataWrSrc_tb)
    );

    // Clock generation
    logic clk_tb = 0;
    always #CLK_PERIOD clk_tb = ~clk_tb;

    // Testbench
    initial begin
        $dumpfile("testb_control_unit.vcd");
        $dumpvars(0, testb_control_unit);
        // Inicialización de entradas
        opCode = 7'b0;
        func7 = 7'b0;
        func3 = 3'b0;

        // Tipo R
        opCode = 7'b0110011;
        #10; // ADD
        func7 = 7'b0000000;
        func3 = 3'b000;
        #10; // SUB
        func7 = 7'b0100000;
        func3 = 3'b000;
        #10; // SLL
        func7 = 7'b0000000;
        func3 = 3'b001;
        /*#10; // SLT
        func7 = 7'b0000000;
        func3 = 3'b010;
        */#10; // SLTU
        func7 = 7'b0000000;
        func3 = 3'b011;
        #10; // XOR
        func7 = 7'b0000000;
        func3 = 3'b100;
        #10; // SRL
        func7 = 7'b0000000;
        func3 = 3'b101;
        #10; // SRA
        func7 = 7'b0100000;
        func3 = 3'b101;
        #10; // OR
        func7 = 7'b0000000;
        func3 = 3'b110;
        #10; // AND
        func7 = 7'b0000000;
        func3 = 3'b111;
        #10; // Tipo I - Aritmético Lógico
        opCode = 7'b0010011;
        // ADD
        func7 = 7'bx;
        func3 = 3'b000;
        #10; // SLL
        func7 = 7'bx;
        func3 = 3'b001;
        #10; // SLT
        func7 = 7'bx;
        func3 = 3'b010;
        #10; // SLTU
        func7 = 7'bx;
        func3 = 3'b011;
        #10; // XOR
        func7 = 7'bx;
        func3 = 3'b100;
        #10; // SRL
        func7 = 7'b0000000;
        func3 = 3'b101;
        #10; // SRA
        func7 = 7'b0100000;
        func3 = 3'b101;
        #10; // OR
        func7 = 7'bx;
        func3 = 3'b110;
        #10; // AND
        func7 = 7'bx;
        func3 = 3'b111;

        #10; // Tipo I - Load
        opCode = 7'b0000011;
        func7 = 7'bx;
        // LB
        func3 = 3'b000;
        #10; // LH
        func3 = 3'b001;
        #10; // LW
        func3 = 3'b010;
        #10; // LBU
        func3 = 3'b100;
        #10; // LHU
        func3 = 3'b101;

        #10; // Tipo I - JALR
        opCode = 7'b1100111;
        func3 = 3'b000;

        #10; // Tipo SB - Branch
        opCode = 7'b1100011;
        // BEQ
        func3 = 3'b000;
        #10; // BNE
        func3 = 3'b001;
        #10; // BLT
        func3 = 3'b100;
        #10; // BGE
        func3 = 3'b101;
        #10; // BLTU
        func3 = 3'b110;
        #10; // BGEU
        func3 = 3'b111;

        #10; // Tipo Store
        opCode = 7'b0100011;

        // SB
        func7 = 7'bx;
        func3 = 3'b000;
        #10; // SH
        func7 = 7'bx;
        func3 = 3'b001;
        #10; // SW 
        func7 = 7'bx;
        func3 = 3'b010;

        #10;
        // Tipo JAL
        opCode = 7'b1101111;
        func7 = 7'bx;
        func3 = 3'bx;
        #10; // Espera un tiempo antes de finalizar la simulación
        $finish;
    end

endmodule
