module testb_data_memory;
    // Tiempo
    timeunit 1ns;
    timeprecision 1ps;

    // Dumbvars
    reg [31:0] address;
    reg [31:0] dataWr;
    reg [2:0] dmCtrl;
    reg dmWr;
    wire [31:0] dataRd;

    // Dumbvarfile
    initial begin
        $dumpfile("testb_data_memory.vcd");
        $dumpvars(0, testb_data_memory);
    end

    // Instancia del módulo
    data_memory uut (
        .address(address),
        .dataWr(dataWr),
        .dmCtrl(dmCtrl),
        .dmWr(dmWr),
        .dataRd(dataRd)
    );

    // Test
    initial begin
        // Inicialización
        address = 32'h0;
        dataWr = 32'h0;
        dmCtrl = 3'b000;
        dmWr = 1'b0;

        // Test 1: Escritura y lectura de un byte
        #10 address = 32'h6E; dataWr = 32'h9; dmCtrl = 3'b000; dmWr = 1'b1;
        #10 dmWr = 1'b0; $display("dataRd: %h", dataRd);

        // Test 2: Escritura y lectura de una halfword
        #10 address = 32'h20; dataWr = 32'hBCDE; dmCtrl = 3'b001; dmWr = 1'b1;
        #10 dmWr = 1'b0; $display("dataRd: %h", dataRd);

        // Test 3: Escritura y lectura de una word
        #10 address = 32'h30; dataWr = 32'h12345678; dmCtrl = 3'b010; dmWr = 1'b1;
        #10 dmWr = 1'b0; $display("dataRd: %h", dataRd);

        // Fin de la simulación
        #10 $finish;
    end
endmodule
