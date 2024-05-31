module de_immsrc(
    input logic clk,
    input logic rst,
    input logic enable,
    input logic [2:0] de_immsrc_in = 3'b0, 
    output logic [2:0] de_immsrc_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            de_immsrc_out <= 3'b0; 
        end else begin
            if (enable) begin
                de_immsrc_out <= de_immsrc_in; 
            end
        end
    end
endmodule