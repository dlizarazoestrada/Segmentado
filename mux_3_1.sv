module mux_3_1(
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [31:0] C,
    input logic [1:0] sel,
    output logic [31:0] Y
);
    always_comb begin
        case (sel)
            2'b00: Y = A; // aluRes
            2'b01: Y = B; // dataRd
            2'b10: Y = C; // sumOut
            default: Y = 32'b0;
        endcase
    end

endmodule