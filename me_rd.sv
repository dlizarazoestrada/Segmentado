module me_rd(
    input logic clk,
    input logic rst,
    input logic [4:0] me_rd_in = 5'b0, 
    output logic [4:0] me_rd_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            me_rd_out <= 5'b0; 
        end else begin
            me_rd_out <= me_rd_in; 
        end
    end
endmodule