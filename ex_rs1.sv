module ex_rs1(
    input logic clk,
    input logic rst,
    input logic [4:0] ex_rs1_in = 5'b0, 
    output logic [4:0] ex_rs1_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_rs1_out <= 5'b0; 
        end else begin
            ex_rs1_out <= ex_rs1_in; 
        end
    end
endmodule