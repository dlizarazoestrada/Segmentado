module wb_dmdatard(
    input logic clk,
    input logic rst,
    input logic [31:0] wb_dmdatard_in = 32'b0, 
    output logic [31:0] wb_dmdatard_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            wb_dmdatard_out <= 32'b0; 
        end else begin
            wb_dmdatard_out <= wb_dmdatard_in; 
        end
    end
endmodule