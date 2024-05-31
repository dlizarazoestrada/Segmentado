module me_alures(
    input logic clk,
    input logic rst,
    input logic [31:0] me_alures_in = 32'b0, 
    output logic [31:0] me_alures_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            me_alures_out <= 32'b0; 
        end else begin
            me_alures_out <= me_alures_in; 
        end
    end
endmodule