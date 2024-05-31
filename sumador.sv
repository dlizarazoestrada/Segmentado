module sumador(
    input logic [31:0] pcInstruction,
    output logic [31:0] sumOut
);
    assign sumOut = pcInstruction + 32'd4;

endmodule