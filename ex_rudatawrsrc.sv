module ex_rudatawrsrc(
    input logic clk,
    input logic rst,
    input logic [1:0] ex_rudatawrsrc_in = 2'b0, 
    output logic [1:0] ex_rudatawrsrc_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_rudatawrsrc_out <= 2'b0; 
        end else begin
            ex_rudatawrsrc_out <= ex_rudatawrsrc_in; 
        end
    end
endmodule