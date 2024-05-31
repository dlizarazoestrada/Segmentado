module wb_rd(
    input logic clk,
    input logic rst,
    input logic [4:0] wb_rd_in = 5'b0, 
    output logic [4:0] wb_rd_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            wb_rd_out <= 5'b0; 
        end else begin
            wb_rd_out <= wb_rd_in; 
        end
    end
endmodule