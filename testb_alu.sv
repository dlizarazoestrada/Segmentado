module testb_alu;
    // Tiempo
    timeunit 1ns;
    timeprecision 1ps;

    // Dumbvars
    reg [31:0] A;
    reg [31:0] B;
    reg [3:0] aluOp;
    wire [31:0] aluRes;

    // Dumbvarfile
    initial begin
        $dumpfile("testb_alu.vcd");
        $dumpvars(0, testb_alu);
    end

    // Instancia del módulo
    alu uut (
        .A(A),
        .B(B),
        .aluOp(aluOp),
        .aluRes(aluRes)
    );

    // Test
    initial begin
        // Inicialización
        A = 32'h0;
        B = 32'h0;
        aluOp = 4'b0000;

        // Test 1: add
        #10 A = 32'h7; B = 32'h3; aluOp = 4'b0000;
        #10 $display("aluRes: %h", aluRes);

        // Test 2: sub
        #10 A = 32'h7; B = 32'h3; aluOp = 4'b1000;
        #10 $display("aluRes: %h", aluRes);

        // Fin de la simulación
        #10 $finish;
    end
endmodule