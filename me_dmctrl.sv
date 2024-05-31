module me_dmctrl(
    input logic clk,
    input logic rst,
    input logic [2:0] me_dmctrl_in = 3'b0, 
    output logic [2:0] me_dmctrl_out
     
);

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            me_dmctrl_out <= 3'b0; 
        end else begin
            me_dmctrl_out <= me_dmctrl_in; 
        end
    end
endmodule