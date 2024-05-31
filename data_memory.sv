module data_memory(
    input logic [31:0] address,
    input logic [31:0] dataWr,
    input logic [2:0] dmCtrl,
    input logic dmWr,
    output logic [31:0] dataRd = 32'b0
);
    // Memoria
    logic [31:0] mem [1023:0];

    // Dirección LSB
    logic [7:0] address_lsb;
    assign address_lsb = address[7:0];

    // Lectura continua
    always @* begin
        case (dmCtrl)
            3'b000: dataRd = $signed({24'b0, mem[address_lsb]});
            3'b001: dataRd = $signed({16'b0, mem[address_lsb + 1], mem[address_lsb]});
            3'b010: dataRd = $signed({mem[address_lsb + 3], mem[address_lsb + 2], 
            mem[address_lsb + 1], mem[address_lsb]});
            3'b100: dataRd = mem[address_lsb];
            3'b101: dataRd = mem[address_lsb + 1];
            default: dataRd = 32'b0;
        endcase
    end

    // Escritura
    always @(posedge dmWr) begin
        case (dmCtrl)
            3'b000: mem[address_lsb] <= dataWr[7:0];
            3'b001: begin
                mem[address_lsb] <= dataWr[7:0]; 
                mem[address_lsb + 1] <= dataWr[15:8];
            end
            3'b010: begin
                mem[address_lsb] <= dataWr[7:0]; 
                mem[address_lsb + 1] <= dataWr[15:8]; 
                mem[address_lsb + 2] <= dataWr[23:16]; 
                mem[address_lsb + 3] <= dataWr[31:24];
            end
            default: ; // No hacer nada
        endcase
    end
endmodule