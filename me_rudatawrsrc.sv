module me_rudatawrsrc(
    input logic clk,
    input logic rst,
    input logic [1:0] me_rudatawrsrc_in = 2'b0, 
    output logic [1:0] me_rudatawrsrc_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            me_rudatawrsrc_out <= 2'b0; 
        end else begin
            me_rudatawrsrc_out <= me_rudatawrsrc_in; 
        end
    end
endmodule