module me_dmwr(
    input logic clk,
    input logic rst,
    input logic me_dmwr_in = 1'b0, 
    output logic me_dmwr_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            me_dmwr_out <= 1'b0; 
        end else begin
            me_dmwr_out <= me_dmwr_in; 
        end
    end
endmodule