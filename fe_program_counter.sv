module fe_program_counter(
    input logic clk,
    input logic rst,
    input logic enable,
    input logic [31:0] fe_pc_in = 32'h00000004, 
    output logic [31:0] fe_pc_out
     
);

    always_ff @(posedge clk) begin
        if (rst) begin
            fe_pc_out <= 32'b0; 
        end else begin
            if (enable) begin
                fe_pc_out <= fe_pc_in; 
            end
        end
    end
endmodule