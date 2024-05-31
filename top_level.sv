`include "alu.sv"
`include "branch_unit.sv"
`include "control_unit.sv"
`include "data_memory.sv"
`include "instruction_memory.sv"
`include "mux_2_1.sv"
`include "registers_unit.sv"
`include "immediate_generator.sv"
`include "mux_3_1.sv"
`include "sumador.sv"
`include "fe_program_counter.sv"
`include "de_immsrc.sv"
`include "de_inst.sv"
`include "de_pcinc.sv"
`include "de_program_counter.sv"
`include "ex_aluasrc.sv"
`include "ex_alubsrc.sv"
`include "ex_aluop.sv"
`include "ex_brop.sv"
`include "ex_dmctrl.sv"
`include "ex_dmwr.sv"
`include "ex_immext.sv"
`include "ex_pcinc.sv"
`include "ex_program_counter.sv"
`include "ex_rd.sv"
`include "ex_rs1.sv"
`include "ex_rs2.sv"
`include "ex_rudatawrsrc.sv"
`include "ex_rurs1.sv"
`include "ex_rurs2.sv"
`include "ex_ruwr.sv"
`include "me_alures.sv"
`include "me_dmctrl.sv"
`include "me_dmwr.sv"
`include "me_pcinc.sv"
`include "me_rd.sv"
`include "me_rudatawrsrc.sv"
`include "me_rurs2.sv"
`include "me_ruwr.sv"
`include "wb_alures.sv"
`include "wb_dmdatard.sv"
`include "wb_pcinc.sv"
`include "wb_rd.sv"
`include "wb_rudatawrsrc.sv"
`include "wb_ruwr.sv"
`include "hazard_unit.sv"
`include "forwarding_unit.sv"

module top_level(
    input logic clk,
    input logic rst
);

// ------------------------------------ Fetch ------------------------------------
// uso del mux_2_1 con nextPcSrc
    // llamar al modulo de mux_2_1 con nextPcSrc
    mux_2_1 mux_2_1_nextPcSrc(
        .A(sumador_out_wire),
        .B(alu_out_wire),
        .sel(nextPcSrc_wire),
        .Y(fe_pc_in_wire)
    );
// cable de entrada y salida del fe_pc
    logic [31:0] fe_pc_in_wire;
    logic [31:0] fe_pc_out_wire;

// llamar al modulo fe_program_counter
    fe_program_counter fe_program_counter(
        .clk(clk),
        .rst(rst),
        .enable(enable_hazard_wire),
        .fe_pc_in(fe_pc_in_wire),
        .fe_pc_out(fe_pc_out_wire)
    );

// cable de salida de la instruction_memory
    logic [31:0] instruction_memory_out_wire;
// llamar al módulo instruction memory
    instruction_memory instruction_memory(
        .address(fe_pc_out_wire),
        .instruction(instruction_memory_out_wire)
    );
// cable de salida del sumador
    logic [31:0] sumador_out_wire;
// llamar al modulo del sumador
    sumador sumador(
        .pcInstruction(fe_pc_out_wire),
        .sumOut(sumador_out_wire)
    );

// ------------------------------------ Fetch ------------------------------------


// ------------------------------------ Decode ------------------------------------
// cables de salida de de_inst
    logic [31:0] de_inst_out_wire;

// llamar al modulo de_inst
    de_inst de_inst(
        .de_inst_in(instruction_memory_out_wire),
        .de_inst_out(de_inst_out_wire),
        .enable(enable_hazard_wire),
        .clk(clk),
        .rst(nextPcSrc_wire)
    );

// asignar cables de salida de de_inst
    logic [6:0] opCode_wire;
    logic [2:0] func3_wire;
    logic [6:0] func7_wire;
    logic [4:0] rs1_wire;
    logic [4:0] rs2_wire;
    logic [4:0] rd_wire;
    logic [24:0] inmGen_wire;
    assign opCode_wire = de_inst_out_wire[6:0];
    assign func3_wire = de_inst_out_wire[14:12];
    assign func7_wire = de_inst_out_wire[31:25];
    assign rs1_wire = de_inst_out_wire[19:15];
    assign rs2_wire = de_inst_out_wire[24:20];
    assign rd_wire = de_inst_out_wire[11:7];
    assign inmGen_wire = de_inst_out_wire[31:7];

// cable de salida del de_pcinc
    logic [31:0] de_pcinc_out_wire;

// llamar al modulo de_pcinc
    de_pcinc de_pcinc(
        .de_pcinc_in(sumador_out_wire),
        .de_pcinc_out(de_pcinc_out_wire),
        .clk(clk),
        .rst(nextPcSrc_wire),
        .enable(enable_hazard_wire)
    );
// cable de salida de de_program_counter
    logic [31:0] de_pc_out_wire;

// llamar al modulo de_program_counter
    de_program_counter de_program_counter(
        .clk(clk),
        .rst(nextPcSrc_wire),
        .de_pc_in(fe_pc_out_wire),
        .de_pc_out(de_pc_out_wire),
        .enable(enable_hazard_wire)
    );
// cables de salida de la control unit
    logic ruWr_wire;
    logic [2:0] de_immSrc_wire;
    logic aluASrc_wire;
    logic aluBSrc_wire;
    logic [4:0] brOp_wire;
    logic [3:0] aluOp_wire;
    logic dmWr_wire;
    logic [2:0] dmCtrl_wire;
    logic [1:0] ruDataWrSrc_wire;
// llamar al modulo de control unit
    control_unit control_unit(
        .opCode(opCode_wire),
        .func7(func7_wire),
        .func3(func3_wire),
        .ruWr(ruWr_wire),
        .immSrc(de_immSrc_wire),
        .aluASrc(aluASrc_wire),
        .aluBSrc(aluBSrc_wire),
        .brOp(brOp_wire),
        .aluOp(aluOp_wire),
        .dmWr(dmWr_wire),
        .dmCtrl(dmCtrl_wire),
        .ruDataWrSrc(ruDataWrSrc_wire)
    );
    // cables de salida de la hazard_unit
    logic enable_hazard_wire;
    logic clr_hazard_wire;
    // llamar al modulo de hazard_unit
    hazard_unit hazard_unit(
        .de_rs1(rs1_wire),
        .de_rs2(rs2_wire),
        .ex_rd(ex_rd_out_wire),
        .ex_dmrd(ex_dmwr_out_wire), // preguntar señal
        .enable(enable_hazard_wire),
        .clr(clr_hazard_wire)
    );
    //cable de entrada dataWr
    logic [31:0] dataWr_wire;
    // cables de salida del registers unit
    logic [31:0] ruRs1_wire;
    logic [31:0] ruRs2_wire;
    // llamar al modulo de registers unit
    registers_unit registers_unit(
        .clk(clk),
        .rs1(rs1_wire),
        .rs2(rs2_wire),
        .rd(wb_rd_out_wire),
        .dataWr(dataWr_wire),
        .ruWr(wb_ruwr_out_wire),
        .ruRs1(ruRs1_wire),
        .ruRs2(ruRs2_wire)
    );
    // cables de salida del immediate generator
    logic [31:0] immExt_wire;
    // llamar al modulo de immediate generator
    immediate_generator immediate_generator(
        .inmGen(inmGen_wire),
        .immSrc(de_immSrc_wire),
        .immExt(immExt_wire)
    );

// ____________________________________ Decode ____________________________________

// ____________________________________ Execute ____________________________________
// cable de clr para execute
    logic ex_clr = clr_hazard_wire | nextPcSrc_wire;
// cable salida ex_dmctrl
    logic [2:0] ex_dmctrl_out_wire;
// llamar al modulo ex_dmctrl
    ex_dmctrl ex_dmctrl(
        .ex_dmctrl_in(dmCtrl_wire),
        .ex_dmctrl_out(ex_dmctrl_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );
// cable salida ex_dmwr
    logic ex_dmwr_out_wire;
// llamar al modulo ex_dmwr
    ex_dmwr ex_dmwr(
        .ex_dmwr_in(dmWr_wire),
        .ex_dmwr_out(ex_dmwr_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );
// cable salida ex_rudatawrsrc
    logic [1:0] ex_rudatawrsrc_out_wire;
// llamar al modulo ex_rudatawrsrc
    ex_rudatawrsrc ex_rudatawrsrc(
        .ex_rudatawrsrc_in(ruDataWrSrc_wire),
        .ex_rudatawrsrc_out(ex_rudatawrsrc_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );
// cable salida ex_ruwr
    logic ex_ruwr_out_wire;
// llamar al modulo ex_ruwr
    ex_ruwr ex_ruwr(
        .ex_ruwr_in(ruWr_wire),
        .ex_ruwr_out(ex_ruwr_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );
// cable de salida de ex_pcinc
    logic [31:0] ex_pcinc_out_wire;
// llamar al modulo ex_pcinc
    ex_pcinc ex_pcinc(
        .ex_pcinc_in(de_pc_out_wire),
        .ex_pcinc_out(ex_pcinc_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );

    // cable de salida de ex_program_counter
    logic [31:0] ex_pc_out_wire;
    // llamar al modulo ex_program_counter
    ex_program_counter ex_program_counter(
        .clk(clk),
        .rst(ex_clr),
        .ex_pc_in(de_pc_out_wire),
        .ex_pc_out(ex_pc_out_wire)
    );
    // cable de salida de ex_rurs1
    logic [31:0] ex_rurs1_out_wire;

    // llamar al modulo ex_rurs1
    ex_rurs1 ex_rurs1(
        .ex_rurs1_in(ruRs1_wire),
        .ex_rurs1_out(ex_rurs1_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );
    // cable de salida de ex_rurs2
    logic [31:0] ex_rurs2_out_wire;
    // llamar al modulo ex_rurs2
    ex_rurs2 ex_rurs2(
        .ex_rurs2_in(ruRs2_wire),
        .ex_rurs2_out(ex_rurs2_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );

    // cable de salida de ex_immext
    logic [31:0] ex_immext_out_wire;

    // llamar al modulo ex_immext
    ex_immext ex_immext(
        .ex_immext_in(immExt_wire),
        .ex_immext_out(ex_immext_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );

    // cable de salida de ex_aluasrc
    logic ex_aluasrc_out_wire;
    // llamar al modulo ex_aluasrc
    ex_aluasrc ex_aluasrc(
        .ex_aluasrc_in(aluASrc_wire),
        .ex_aluasrc_out(ex_aluasrc_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );

    // cable de salida de ex_alubsrc
    logic ex_alubsrc_out_wire;
    // llamar al modulo ex_alubsrc
    ex_alubsrc ex_alubsrc(
        .ex_alubsrc_in(aluBSrc_wire),
        .ex_alubsrc_out(ex_alubsrc_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );

    //cable salida de ex_brop
    logic [4:0] ex_brop_out_wire;
    // llamar al modulo ex_brop
    ex_brop ex_brop(
        .ex_brop_in(brOp_wire),
        .ex_brop_out(ex_brop_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );

    //cable de salida de ex_aluop
    logic [3:0] ex_aluop_out_wire;
    // llamar al modulo ex_aluop
    ex_aluop ex_aluop(
        .ex_aluop_in(aluOp_wire),
        .ex_aluop_out(ex_aluop_out_wire),
        .clk(clk),
        .rst(ex_clr)
    );
    // cable de salida del branch unit
    logic nextPcSrc_wire;
    // llamar al modulo de branch unit
    branch_unit branch_unit(
        .ruRs1(mux_3_1_rurs1_out_wire),
        .ruRs2(mux_3_1_rurs2_out_wire),
        .brOp(ex_brop_out_wire),
        .nextPcSrc(nextPcSrc_wire)
    );
    // uso del mux_3_1 con la forwarding unit rurs1
    // cable de salida del mux_3_1
    logic [31:0] mux_3_1_rurs1_out_wire;
    // llamar al modulo de mux_3_1 con la forwarding unit rurs1
    mux_3_1 mux_3_1_rurs1(
        .A(ex_rurs1_out_wire),
        .B(me_alures_out_wire),
        .C(dataWr_wire),
        .sel(forwarding_unit_mux_3_1_rurs1_wire),
        .Y(mux_3_1_rurs1_out_wire)
    );
    // uso del mux_3_1 con la forwarding unit rurs2
    // cable de salida del mux_3_1
    logic [31:0] mux_3_1_rurs2_out_wire;
    // llamar al modulo de mux_3_1 con la forwarding unit rurs2
    mux_3_1 mux_3_1_rurs2(
        .A(ex_rurs2_out_wire),
        .B(me_alures_out_wire),
        .C(dataWr_wire),
        .sel(forwarding_unit_mux_3_1_rurs2_wire),
        .Y(mux_3_1_rurs2_out_wire)
    );
    // uso de mux_2_1 aluASrc
    // cables de salida de los mux_2_1
    logic [31:0] A_mux_2_1_out_wire;
    logic [31:0] B_mux_2_1_out_wire;
    // llamar al modulo de mux_2_1 aluASrc
    mux_2_1 mux_2_1_aluASrc(
        .A(mux_3_1_rurs1_out_wire),
        .B(ex_pc_out_wire),
        .sel(ex_aluasrc_out_wire),
        .Y(A_mux_2_1_out_wire)
    );
    // uso de mux_2_1 aluBSrc
    // llamar al modulo de mux_2_1 aluBSrc
    mux_2_1 mux_2_1_aluBSrc(
        .A(mux_3_1_rurs2_out_wire),
        .B(ex_immext_out_wire),
        .sel(ex_alubsrc_out_wire),
        .Y(B_mux_2_1_out_wire)
    );
    // cable de salida de la alu
    logic [31:0] alu_out_wire;
    // llamar al modulo de alu
    alu alu(
        .A(A_mux_2_1_out_wire),
        .B(B_mux_2_1_out_wire),
        .aluOp(ex_aluop_out_wire),
        .aluRes(alu_out_wire)
    );

    // cable de salida de ex_rs1
    logic [4:0] ex_rs1_out_wire;
    // llamar al modulo de ex_rs1
    ex_rs1 ex_rs1(
        .clk(clk),
        .rst(rst),
        .ex_rs1_in(rs1_wire),
        .ex_rs1_out(ex_rs1_out_wire)
    );
    // cable de salida de ex_rs2
    logic [4:0] ex_rs2_out_wire;
    // llamar al modulo de ex_rs2
    ex_rs2 ex_rs2(
        .clk(clk),
        .rst(rst),
        .ex_rs2_in(rs2_wire),
        .ex_rs2_out(ex_rs2_out_wire)
    );
    // cable de salida de ex_rd
    logic [4:0] ex_rd_out_wire;
    // llamar al modulo de ex_rd
    ex_rd ex_rd(
        .clk(clk),
        .rst(rst),
        .ex_rd_in(rd_wire),
        .ex_rd_out(ex_rd_out_wire)
    );

    // cables de salida de la forwarding_unit
    logic [1:0] forwarding_unit_mux_3_1_rurs1_wire;
    logic [1:0] forwarding_unit_mux_3_1_rurs2_wire;
    // llamar al modulo de forwarding_unit
    forwarding_unit forwarding_unit(
        .ex_rs1(ex_rs1_out_wire),
        .ex_rs2(ex_rs2_out_wire),
        .me_rd(me_rd_out_wire),
        .wb_rd(wb_rd_out_wire),
        .me_ruwr(me_ruwr_out_wire),
        .wb_ruwr(wb_ruwr_out_wire),
        .ex_mux_rurs1(forwarding_unit_mux_3_1_rurs1_wire),
        .ex_mux_rurs2(forwarding_unit_mux_3_1_rurs2_wire)
    );
// ____________________________________ Execute ____________________________________

// ____________________________________ Memory ____________________________________

    // cable de salida de me_pcinc
    logic [31:0] me_pcinc_out_wire;
    // llamar al modulo de me_pcinc
    me_pcinc me_pcinc(
        .me_pcinc_in(ex_pcinc_out_wire),
        .me_pcinc_out(me_pcinc_out_wire),
        .clk(clk),
        .rst(rst)
    );

    // cable de salida de me_alures
    logic [31:0] me_alures_out_wire;
    // llamar al modulo de me_alures
    me_alures me_alures(
        .me_alures_in(alu_out_wire),
        .me_alures_out(me_alures_out_wire),
        .clk(clk),
        .rst(rst)
    );
    // cable de salida de me_rurs2
    logic [31:0] me_rurs2_out_wire;
    // llamar al modulo de me_rurs2
    me_rurs2 me_rurs2(
        .me_rurs2_in(ex_rurs2_out_wire),
        .me_rurs2_out(me_rurs2_out_wire),
        .clk(clk),
        .rst(rst)
    );

    // cable de salida de me_rd
    logic [4:0] me_rd_out_wire;
    // llamar al modulo de me_rd
    me_rd me_rd(
        .me_rd_in(ex_rd_out_wire),
        .me_rd_out(me_rd_out_wire),
        .clk(clk),
        .rst(rst)
    );

    //cable de salida de me_dmctrl
    logic [2:0] me_dmctrl_out_wire;
    // llamar al modulo de me_dmctrl
    me_dmctrl me_dmctrl(
        .me_dmctrl_in(ex_dmctrl_out_wire),
        .me_dmctrl_out(me_dmctrl_out_wire),
        .clk(clk),
        .rst(rst)
    );
    // cable de salida de me_dmwr
    logic me_dmwr_out_wire;
    // llamar al modulo de me_dmwr
    me_dmwr me_dmwr(
        .me_dmwr_in(ex_dmwr_out_wire),
        .me_dmwr_out(me_dmwr_out_wire),
        .clk(clk),
        .rst(rst)
    );
    // cable de salida de me_rudatawrsrc
    logic [1:0] me_rudatawrsrc_out_wire;
    // llamar al modulo de me_rudatawrsrc
    me_rudatawrsrc me_rudatawrsrc(
        .me_rudatawrsrc_in(ex_rudatawrsrc_out_wire),
        .me_rudatawrsrc_out(me_rudatawrsrc_out_wire),
        .clk(clk),
        .rst(rst)
    );
    // cable de salida de me_ruwr
    logic me_ruwr_out_wire;
    // llamar al modulo de me_ruwr
    me_ruwr me_ruwr(
        .me_ruwr_in(ex_ruwr_out_wire),
        .me_ruwr_out(me_ruwr_out_wire),
        .clk(clk),
        .rst(rst)
    );
    // cable de salida de la data memory
    logic [31:0] data_memory_out_wire;
    // llamar al modulo de data memory
    data_memory data_memory(
        .address(me_alures_out_wire),
        .dataWr(me_rurs2_out_wire),
        .dmCtrl(me_dmctrl_out_wire),
        .dmWr(me_dmwr_out_wire),
        .dataRd(data_memory_out_wire)
    );
// ____________________________________ Memory ____________________________________

// ____________________________________ Write Back ____________________________________

    // cable de salida de wb_dmdatard
    logic [31:0] wb_dmdatard_out_wire;
    // llamar al modulo de wb_dmdatard
    wb_dmdatard wb_dmdatard(
        .wb_dmdatard_in(data_memory_out_wire),
        .wb_dmdatard_out(wb_dmdatard_out_wire),
        .clk(clk),
        .rst(rst)
    );

    // cable de salida de wb_alures
    logic [31:0] wb_alures_out_wire;
    // llamar al modulo de wb_alures
    wb_alures wb_alures(
        .wb_alures_in(me_alures_out_wire),
        .wb_alures_out(wb_alures_out_wire),
        .clk(clk),
        .rst(rst)
    );
    // cable de salida de wb_rd
    logic [4:0] wb_rd_out_wire;
    // llamar al modulo de wb_rd
    wb_rd wb_rd(
        .wb_rd_in(me_rd_out_wire),
        .wb_rd_out(wb_rd_out_wire),
        .clk(clk),
        .rst(rst)
    );
    // cable de salida de wb_pcinc
    logic [31:0] wb_pcinc_out_wire;
    // llamar al modulo de wb_pcinc
    wb_pcinc wb_pcinc(
        .wb_pcinc_in(me_pcinc_out_wire),
        .wb_pcinc_out(wb_pcinc_out_wire),
        .clk(clk),
        .rst(rst)
    );

    // cable de salida de wb_rudatawrsrc
    logic [1:0] wb_rudatawrsrc_out_wire;
    // llamar al modulo de wb_rudatawrsrc
    wb_rudatawrsrc wb_rudatawrsrc(
        .wb_rudatawrsrc_in(me_rudatawrsrc_out_wire),
        .wb_rudatawrsrc_out(wb_rudatawrsrc_out_wire),
        .clk(clk),
        .rst(rst)
    );
    // cable de salida de wb_ruwr
    logic wb_ruwr_out_wire;
    // llamar al modulo de wb_ruwr
    wb_ruwr wb_ruwr(
        .wb_ruwr_in(me_ruwr_out_wire),
        .wb_ruwr_out(wb_ruwr_out_wire),
        .clk(clk),
        .rst(rst)
    );
    // uso del mux_3_1 con ruDataWrSrc
    // el cable de salida del mux_3_1 es dataWr
    // llamar al modulo de mux_3_1 con ruDataWrSrc
    mux_3_1 mux_3_1_ruDataWrSrc(
        .A(wb_alures_out_wire),
        .B(wb_dmdatard_out_wire),
        .C(wb_pcinc_out_wire),
        .sel(wb_rudatawrsrc_out_wire),
        .Y(dataWr_wire)
    );

endmodule