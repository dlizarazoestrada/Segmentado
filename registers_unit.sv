module registers_unit (
    input logic clk,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [31:0] dataWr,
    input logic ruWr,
    output logic [31:0] ruRs1 = 32'b0,
    output logic [31:0] ruRs2 = 32'b0
);

    logic [31:0] ru [31:0];
    always_ff @(negedge clk) begin
        if (ruWr) begin
            ru[rd] <= dataWr;
            ruRs1 = 32'b0;
            ruRs2 = 32'b0;
        end 
        else begin
            ruRs1 = ru[rs1];
            ruRs2 = ru[rs2];
        end
    end
    
endmodule