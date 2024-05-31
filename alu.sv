module alu (
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [3:0] aluOp,
    output logic [31:0] aluRes = 32'b0
);
    always@* begin
        case (aluOp)
            4'b0000: aluRes = A + B; // add
            4'b1000: aluRes = A - B; // sub
            4'b0001: aluRes = A << B[4:0]; // sll
            4'b0010: aluRes = $signed(A) < $signed(B); // slt
            4'b0011: aluRes = A < B; // sltu
            4'b0100: aluRes = A ^ B; // xor
            4'b0101: aluRes = A >> B[4:0]; // srl
            4'b1101: aluRes = $signed(A) >>> B[4:0]; // sra
            4'b0110: aluRes = A | B; // or
            4'b0111: aluRes = A & B; // and
            default: aluRes = 0;
        endcase
    end
endmodule