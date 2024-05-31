module ex_rs2(
    input logic clk,
    input logic rst,
    input logic [4:0] ex_rs2_in = 5'b0, 
    output logic [4:0] ex_rs2_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_rs2_out <= 5'b0; 
        end else begin
            ex_rs2_out <= ex_rs2_in; 
        end
    end
endmodule