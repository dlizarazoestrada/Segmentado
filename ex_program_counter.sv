module ex_program_counter(
    input logic clk,
    input logic rst,
    input logic [31:0] ex_pc_in = 32'b0, 
    output logic [31:0] ex_pc_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_pc_out <= 32'b0; 
        end else begin
            ex_pc_out <= ex_pc_in; 
        end
    end
endmodule