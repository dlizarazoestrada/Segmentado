module forwarding_unit(
    input [4:0] ex_rs1,        
    input [4:0] ex_rs2,        
    input [4:0] me_rd,        
    input [4:0] wb_rd,         
    input me_ruwr,       
    input wb_ruwr,        
    output reg [1:0] ex_mux_rurs1 = 2'b0, // Selección de MUX5
    output reg [1:0] ex_mux_rurs2 = 2'b0 // Selección de MUX6
);

always @(*) begin
    // Inicializar las señales de selección a 0 (ningún reenvío)
    ex_mux_rurs1 = 2'b00;
    ex_mux_rurs2 = 2'b00;

    // Comparar ex_rs1 con me_rd y wb_rd
    if (me_ruwr && (me_rd != 5'b0) && (me_rd == ex_rs1)) begin
        ex_mux_rurs1 = 2'b01; // Reenvío desde MEM
        ex_mux_rurs2 = 2'b01;
    end else if (wb_ruwr && (wb_rd != 5'b0) && (wb_rd == ex_rs1)) begin
        ex_mux_rurs1 = 2'b10; // Reenvío desde WB
        ex_mux_rurs2 = 2'b10;
    end

    // Comparar ex_rs2 con me_rd y wb_rd
    if (me_ruwr && (me_rd != 5'b0) && (me_rd == ex_rs2)) begin
        ex_mux_rurs1 = 2'b01; // Reenvío desde MEM
        ex_mux_rurs2 = 2'b01;
    end else if (wb_ruwr && (wb_rd != 5'b0) && (wb_rd == ex_rs2)) begin
        ex_mux_rurs1 = 2'b10;
        ex_mux_rurs2 = 2'b10; // Reenvío desde WB
    end
end

endmodule
