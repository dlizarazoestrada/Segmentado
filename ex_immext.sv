module ex_immext(
    input logic clk,
    input logic rst,
    input logic [31:0] ex_immext_in = 32'b0, 
    output logic [31:0] ex_immext_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_immext_out <= 32'b0; 
        end else begin
            ex_immext_out <= ex_immext_in; 
        end
    end
endmodule