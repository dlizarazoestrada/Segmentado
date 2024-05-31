module ex_ruwr(
    input logic clk,
    input logic rst,
    input logic ex_ruwr_in = 1'b0, 
    output logic ex_ruwr_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_ruwr_out <= 1'b0; 
        end else begin
            ex_ruwr_out <= ex_ruwr_in; 
        end
    end
endmodule