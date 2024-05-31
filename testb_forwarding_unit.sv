module testb_forwarding_unit;
    reg [4:0] ex_rs1;
    reg [4:0] ex_rs2;
    reg [4:0] me_rd;
    reg [4:0] wb_rd;
    reg me_ruwr;
    reg wb_ruwr;
    wire [1:0] mux5_sel;
    wire [1:0] mux6_sel;

    // Instanciamos la unidad de anticipación (forwarding unit)
    ForwardingUnit uut (
        .ex_rs1(ex_rs1),
        .ex_rs2(ex_rs2),
        .me_rd(me_rd),
        .wb_rd(wb_rd),
        .me_ruwr(me_ruwr),
        .wb_ruwr(wb_ruwr),
        .mux5_sel(mux5_sel),
        .mux6_sel(mux6_sel)
    );

    initial begin
        // Configuramos el archivo de volcado de variables
        $dumpfile("testb_forwarding_unit.vcd");
        $dumpvars(0, testb_forwarding_unit);
        
        // Test case 1
        ex_rs1 = 5'd1;
        ex_rs2 = 5'd2;
        me_rd = 5'd1;
        wb_rd = 5'd2;
        me_ruwr = 1;
        wb_ruwr = 1;
        #10;
        
        // Test case 2
        ex_rs1 = 5'd3;
        ex_rs2 = 5'd4;
        me_rd = 5'd0;
        wb_rd = 5'd3;
        me_ruwr = 0;
        wb_ruwr = 1;
        #10;
        
        // Test case 3
        ex_rs1 = 5'd5;
        ex_rs2 = 5'd6;
        me_rd = 5'd5;
        wb_rd = 5'd6;
        me_ruwr = 1;
        wb_ruwr = 0;
        #10;

        // Test case 4
        ex_rs1 = 5'd7;
        ex_rs2 = 5'd8;
        me_rd = 5'd9;
        wb_rd = 5'd7;
        me_ruwr = 0;
        wb_ruwr = 1;
        #10;

        // Additional test cases can be added here

        $finish;
    end
endmodule
