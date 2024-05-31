module me_rurs2(
    input logic clk,
    input logic rst,
    input logic [31:0] me_rurs2_in = 32'b0, 
    output logic [31:0] me_rurs2_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            me_rurs2_out <= 32'b0; 
        end else begin
            me_rurs2_out <= me_rurs2_in; 
        end
    end
endmodule