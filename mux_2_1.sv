module mux_2_1(
    input logic [31:0] A,
    input logic [31:0] B,
    input logic sel,
    output logic [31:0] Y
);
    always_comb begin
        case (sel)
            1'b0: Y = A; //sumOut / ruRs1 / ruRs2
            1'b1: Y = B; // aluRes / pc / immExt
            default: Y = 32'b0;
        endcase
    end

endmodule