module branch_unit(
    input logic [31:0] ruRs1,
    input logic [31:0] ruRs2,
    input logic [4:0] brOp,
    output logic nextPcSrc = 1'b0
);
    always_comb begin
        case (brOp)
            5'b00xxx: nextPcSrc = 0;
            5'b1xxxx: nextPcSrc = 1;
            5'b01000: if (ruRs1 == ruRs2) nextPcSrc = 1; else nextPcSrc = 0;
            5'b01001: if (ruRs1 !== ruRs2) nextPcSrc = 1; else nextPcSrc = 0;
            5'b01100: if ($signed(ruRs1) < $signed(ruRs2)) nextPcSrc = 1; else nextPcSrc = 0;
            5'b01101: if ($signed(ruRs1) >= $signed(ruRs2)) nextPcSrc = 1; else nextPcSrc = 0;
            5'b01110: if (ruRs1 < ruRs2) nextPcSrc = 1; else nextPcSrc = 0;
            5'b01111: if (ruRs1 >= ruRs2) nextPcSrc = 1; else nextPcSrc = 0;
            default: nextPcSrc = 0;
        endcase
    end
endmodule