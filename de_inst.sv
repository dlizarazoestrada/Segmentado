module de_inst(
    input logic clk,
    input logic rst,
    input logic enable,
    input logic [31:0] de_inst_in = 32'b0, 
    output logic [31:0] de_inst_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            de_inst_out <= 32'b0; 
        end else begin
            if (enable) begin
                de_inst_out <= de_inst_in;
            end 
        end
    end
endmodule