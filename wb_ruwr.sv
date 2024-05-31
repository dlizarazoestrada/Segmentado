module wb_ruwr(
    input logic clk,
    input logic rst,
    input logic wb_ruwr_in = 1'b0, 
    output logic wb_ruwr_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            wb_ruwr_out <= 1'b0; 
        end else begin
            wb_ruwr_out <= wb_ruwr_in; 
        end
    end
endmodule