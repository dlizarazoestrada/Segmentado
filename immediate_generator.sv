module immediate_generator (
    input logic [24:0] inmGen,
    input logic [2:0] immSrc,
    output logic [31:0] immExt = 32'b0
);

    always@* begin
        case (immSrc)
            3'b000: immExt = {{20{inmGen[24]}}, inmGen[24:13]}; // Tipo I
            3'b001: immExt = {{20{inmGen[24]}} , inmGen[24:18], inmGen[4:0]}; // Tipo S
            3'b101: immExt = {{20{inmGen[24]}} , inmGen[24:21] , inmGen[0],inmGen[20:18], inmGen[4:1], 1'b0}; // Tipo B
            3'b010: immExt = {inmGen[24:5], {12{inmGen[24]}}}; // Tipo U
            3'b110: immExt = {{11{inmGen[24]}} , inmGen[24],inmGen[12:5],inmGen[13], inmGen[23:14], 1'b0}; // Tipo J
            default: immExt = 32'b0;
        endcase
    end
endmodule