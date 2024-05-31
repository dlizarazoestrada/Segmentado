module ex_pcinc(
    input logic clk,
    input logic rst,
    input logic [31:0] ex_pcinc_in = 32'b0, 
    output logic [31:0] ex_pcinc_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_pcinc_out <= 32'b0; 
        end else begin
            ex_pcinc_out <= ex_pcinc_in; 
        end
    end
endmodule