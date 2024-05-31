module hazard_unit(
    input [4:0] de_rs1,          // Registro fuente 1 de la etapa de decodificación
    input [4:0] de_rs2,          // Registro fuente 2 de la etapa de decodificación
    input [4:0] ex_rd,           // Registro destino de la etapa de ejecución
    input ex_dmrd,           // Señal que indica si la instrucción en ejecución realiza lectura de memoria
    output reg enable = 1,         // Señal para detener la etapa de decodificación
    output reg clr = 0        // Señal para limpiar la etapa de ejecución
);

    reg hazard_detected;         // Señal interna para indicar la detección de una dependencia
    reg is_equal_rs1;            // Registro fuente 1 de la etapa de ejecución
    reg is_equal_rs2;             // Registro fuente 2 de la etapa de ejecución

    // Comparación de los registros fuente de la etapa de ejecución con los de la etapa de decodificación
    always @* begin
        is_equal_rs1 = ex_rd == de_rs1;
        is_equal_rs2 = ex_rd == de_rs2;
        hazard_detected = (ex_dmrd && (is_equal_rs1 | is_equal_rs2)); // Detección de dependencia

        if (hazard_detected == 1 && de_rs1 == 5'b0 && de_rs2 == 5'b0  && ex_rd == 5'b0 ) begin // Señal de control para detener la etapa de decodificación
            enable = 1'b1;
            clr = 1'b1;
        end else if (hazard_detected) begin
            enable = 1'b0;
            clr = 1'b1;
        end
    end
endmodule