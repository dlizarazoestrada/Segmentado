module tb_program_counter();

    // Parámetros de prueba
    logic [31:0] pc_in;
    logic rst;
    logic clk;
    logic [31:0] pc_out;

    // Instancia del módulo
    program_counter dut (
        .pc_in(pc_in),
        .rst(rst),
        .clk(clk),
        .pc_out(pc_out)
    );

    // Declaración de señales para el testbench
    logic [31:0] expected_pc_out;

    // Dumbvars para visualización de formas de onda
    initial begin
        $dumpfile("tb_program_counter.vcd");
        $dumpvars(0, tb_program_counter);
        // Configuración inicial de señales
        rst = 1'b1;
        clk = 1'b0;
        pc_in = 32'h0000_0000;
        expected_pc_out = 32'h0000_0000;

        // Reset inicial
        #5 rst = 1'b0;

        // Prueba básica con un contador ascendente
        #10;
        for (int i = 0; i < 10; i++) begin
            clk = ~clk;
            pc_in = pc_in + 32'h0000_0004;
            expected_pc_out = expected_pc_out + 32'h0000_0004;
            #5;
        end

        // Reset
        #10;
        rst = 1'b1;
        #5 rst = 1'b0;
        
        // Prueba con cambio repentino en pc_in
        #10;
        pc_in = 32'h1234_5678;
        expected_pc_out = 32'h1234_5678;
        #10;
        pc_in = 32'h9ABC_DEFF;
        expected_pc_out = 32'h9ABC_DEFF;
        
        // Finalizar simulación
        #10 $finish;
    end

endmodule
