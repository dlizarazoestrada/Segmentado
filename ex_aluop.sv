module ex_aluop(
    input logic clk,
    input logic rst,
    input logic [3:0] ex_aluop_in = 4'b0, 
    output logic [3:0] ex_aluop_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_aluop_out <= 4'b0; 
        end else begin
            ex_aluop_out <= ex_aluop_in; 
        end
    end
endmodule