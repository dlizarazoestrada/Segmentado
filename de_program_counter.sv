module de_program_counter(
    input logic clk,
    input logic rst,
    input logic enable,
    input logic [31:0] de_pc_in = 32'b0, 
    output logic [31:0] de_pc_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            de_pc_out <= 32'b0; 
        end else begin
            if (enable) begin
                de_pc_out <= de_pc_in; 
            end
        end
    end
endmodule