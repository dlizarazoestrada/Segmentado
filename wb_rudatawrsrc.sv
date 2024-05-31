module wb_rudatawrsrc(
    input logic clk,
    input logic rst,
    input logic [1:0] wb_rudatawrsrc_in = 2'b0, 
    output logic [1:0] wb_rudatawrsrc_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            wb_rudatawrsrc_out <= 2'b0; 
        end else begin
            wb_rudatawrsrc_out <= wb_rudatawrsrc_in; 
        end
    end
endmodule