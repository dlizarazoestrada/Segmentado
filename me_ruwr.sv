module me_ruwr(
    input logic clk,
    input logic rst,
    input logic me_ruwr_in = 1'b0, 
    output logic me_ruwr_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            me_ruwr_out <= 1'b0; 
        end else begin
            me_ruwr_out <= me_ruwr_in; 
        end
    end
endmodule