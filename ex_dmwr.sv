module ex_dmwr(
    input logic clk,
    input logic rst,
    input logic ex_dmwr_in = 1'b0, 
    output logic ex_dmwr_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_dmwr_out <= 1'b0; 
        end else begin
            ex_dmwr_out <= ex_dmwr_in; 
        end
    end
endmodule