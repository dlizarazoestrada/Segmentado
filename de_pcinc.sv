module de_pcinc(
    input logic clk,
    input logic rst,
    input logic enable,
    input logic [31:0] de_pcinc_in = 32'b0, 
    output logic [31:0] de_pcinc_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            de_pcinc_out <= 32'b0; 
        end else begin
            if(enable) begin
                de_pcinc_out <= de_pcinc_in; 
            end
        end
    end
endmodule