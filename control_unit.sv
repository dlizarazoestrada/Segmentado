module control_unit (
    input logic [6:0] opCode,
    input logic [6:0] func7,
    input logic [2:0] func3,
    output logic ruWr = 1'b0,
    output logic [2:0] immSrc = 3'b000,
    output logic aluASrc = 1'b0,
    output logic aluBSrc = 1'b0,
    output logic [4:0] brOp = 5'b00000,
    output logic [3:0] aluOp = 4'b0000,
    output logic dmWr = 1'b0,
    output logic [2:0] dmCtrl = 3'b000,
    output logic [1:0] ruDataWrSrc = 2'b00
);
logic func5;
    assign func5 = func7[5];

    always_comb begin
        case (opCode)
            // Tipo R
            7'b0110011: begin
                case({func7,func3})

                    10'b0000000_000: aluOp = 4'b0000; // add
                    10'b0100000_000: aluOp = 4'b0110; // sub
                    10'b0000000_001: aluOp = 4'b0001; // sll
                    10'b0000000_010: aluOp = 4'b0010; // slt
                    10'b0000000_011: aluOp = 4'b0011; // sltu
                    10'b0000000_100: aluOp = 4'b0100; // 0or
                    10'b0000000_101: aluOp = 4'b0101; // srl
                    
                    10'b0000000_110: aluOp = 4'b0111; // sra
                    10'b0000000_111: aluOp = 4'b1000; // or
                    10'b0000001_000: aluOp = 4'b1001; // and

                    
                    default: brOp = 5'b00000;
                endcase

                ruWr = 1'b1;
                aluASrc = 1'b0;
                aluBSrc = 1'b0;
                ruDataWrSrc = 2'b00;
            end

            // Tipo I 
            7'b0010011: begin
                //quiero que crees el aluop de las instrucciones de tipo I
                case(func3)
                    3'b000: aluOp = 4'b0000; // addi
                    3'b010: aluOp = 4'b0010; // slti
                    3'b011: aluOp = 4'b0011; // sltiu
                    3'b100: aluOp = 4'b0100; // 0ori
                    3'b110: aluOp = 4'b1000; // ori
                    3'b111: aluOp = 4'b1001; // andi
                    3'b001: aluOp = 4'b0001; // slli
                    3'b101: begin
                        if (func7 == 7'b0100000) begin
                            aluOp = 4'b0110; // srli
                        end else begin
                            aluOp = 4'b0111; // srai
                        end
                    end
                    default: aluOp = 4'b0000;
                endcase
                    
                ruWr = 1'b1;
                immSrc = 3'b000;
                aluASrc = 1'b0;
                aluBSrc = 1'b1;
                dmWr = 1'b0;
                dmCtrl = 3'b000;
                brOp = 5'b00000;
                ruDataWrSrc = 2'b00; 
            end
            // TIPO I - carga
            7'b0000011: begin
                ruWr = 1'b1;
                aluOp = 4'b0000;
                immSrc = 3'b000;
                aluASrc = 1'b0;
                aluBSrc = 1'b1;
                dmWr = 1'b0;
                dmCtrl = func3;
                brOp = 5'b00000;
                ruDataWrSrc = 2'b01;
            end

            // Tipo B
            7'b1100011: begin
                
                case(func3)
                    3'b000: brOp = 5'b01000;
                    3'b001: brOp = 5'b01001;
                    3'b100: brOp = 5'b01100;
                    3'b101: brOp = 5'b01101;
                    3'b110: brOp = 5'b01110;
                    3'b111: brOp = 5'b01111;
                    default: brOp = 5'b00000;
                endcase
                
                ruWr = 1'b0;
                aluOp = 4'b0000;
                immSrc = 3'b101;
                aluASrc = 1'b1;
                aluBSrc = 1'b1;
                dmWr = 1'b0;
                dmCtrl = 3'b000;
                ruDataWrSrc = 2'b00;  
            end

            // TIPO J
            7'b1101111: begin
                ruWr = 1'b1;
                aluOp = 4'b0000;
                immSrc = 3'b110;
                aluASrc = 1'b1;
                aluBSrc = 1'b1;
                dmWr = 1'b0;
                dmCtrl = 3'b000;
                brOp = 5'b10000;
                ruDataWrSrc = 2'b10;
            end

            // TIPO S
            7'b0100011: begin
                ruWr = 1'b0;
                aluOp = 4'b0000;
                immSrc = 3'b001;
                aluASrc = 1'b0;
                aluBSrc = 1'b1;
                dmWr = 1'b1;
                dmCtrl = func3;
                brOp = 5'b00000;
                ruDataWrSrc = 2'b00;
            end

            // Tipo I-Salto (jalr)
            7'b1100111: begin
                ruWr = 1'b1;
                aluOp = 4'b0000;
                immSrc = 3'b000;
                aluASrc = 1'b0;
                aluBSrc = 1'b1;
                dmWr = 1'b0;
                dmCtrl = 3'b000;
                brOp = 5'b10000;
                ruDataWrSrc = 2'b10;
            end
            
            // TIPO U
            7'b1100111: begin
                ruWr = 1'b0;
                aluOp = 4'b0111;
                immSrc = 3'b010;
                aluASrc = 1'b0;
                aluBSrc = 1'b1;
                dmWr = 1'b0;
                dmCtrl = 3'b000;
                brOp = 5'b0;
                ruDataWrSrc = 2'b0;
            end
            default: begin
                ruWr = 1'b0;
                aluASrc = 1'b0;
                aluBSrc = 1'b0;
                dmCtrl = 3'b000;
                dmWr = 1'b0;
                ruDataWrSrc = 2'b00;
                immSrc = 3'b000;
                aluOp = 4'b0000;
            end
        endcase
    end
endmodule