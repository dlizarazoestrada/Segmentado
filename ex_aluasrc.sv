module ex_aluasrc(
    input logic clk,
    input logic rst,
    input logic ex_aluasrc_in = 1'b0, 
    output logic ex_aluasrc_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            ex_aluasrc_out <= 1'b0; 
        end else begin
            ex_aluasrc_out <= ex_aluasrc_in; 
        end
    end
endmodule