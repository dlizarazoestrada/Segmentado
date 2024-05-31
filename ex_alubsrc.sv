module ex_alubsrc(
    input logic clk,
    input logic rst,
    input logic ex_alubsrc_in = 1'b0, 
    output logic ex_alubsrc_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_alubsrc_out <= 1'b0; 
        end else begin
            ex_alubsrc_out <= ex_alubsrc_in; 
        end
    end
endmodule