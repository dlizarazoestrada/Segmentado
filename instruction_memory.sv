module instruction_memory(
    input logic [31:0] address,
    output logic [31:0] instruction
);
    logic [7:0] mem[1023:0];

    initial begin
        $readmemh("instrucciones.txt", mem);
    end

    always_comb begin
        instruction = {mem[address], mem[address+1], mem[address+2], mem[address+3]};
    end
endmodule