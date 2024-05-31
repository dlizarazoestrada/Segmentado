module testb_immediate_generator;
    // Tiempo
    timeunit 1ns;
    timeprecision 1ps;

    // Dumbvars
    reg [24:0] inmGen;
    reg [2:0] immSrc;
    wire [31:0] immExt;

    // Dumbvarfile
    initial begin
        $dumpfile("testb_immediate_generator.vcd");
        $dumpvars(0, testb_immediate_generator);
    end

    // Instancia del módulo
    immediate_generator uut (
        .inmGen(inmGen),
        .immSrc(immSrc),
        .immExt(immExt)
    );

    // Test
    initial begin
        // Inicialización
        inmGen = 25'b0;
        immSrc = 3'b000;

        // Test 1: Tipo I
        #10 inmGen = 25'h12345; immSrc = 3'b000;
        #10 $display("immExt: %h", immExt);

        // Test 2: Tipo U
        #10 inmGen = 25'h6789A; immSrc = 3'b010;
        #10 $display("immExt: %h", immExt);

        // Fin de la simulación
        #10 $finish;
    end
endmodule