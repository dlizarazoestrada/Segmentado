module ex_brop(
    input logic clk,
    input logic rst,
    input logic [4:0] ex_brop_in = 5'b0, 
    output logic [4:0] ex_brop_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_brop_out <= 5'b0; 
        end else begin
            ex_brop_out <= ex_brop_in; 
        end
    end
endmodule