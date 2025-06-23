`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module riscv_cpu (
    input clk,
    input reset
);
    // PC wires
    wire [31:0] pc, pc_next;
    wire [31:0] instruction;

    // Instruction fields
    wire [6:0] opcode = instruction[6:0];
    wire [4:0] rd     = instruction[11:7];
    wire [2:0] funct3 = instruction[14:12];
    wire [4:0] rs1    = instruction[19:15];
    wire [4:0] rs2    = instruction[24:20];
    wire [6:0] funct7 = instruction[31:25];

    // Register file wires
    wire [31:0] reg_data1, reg_data2;

    // Immediate
    wire [31:0] imm;

    // Control signals
    wire alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch;
    wire [1:0] alu_op;

    // ALU
    wire [31:0] alu_input2, alu_result;
    wire [3:0] alu_ctrl;
    wire zero_flag;

    // Data memory
    wire [31:0] mem_read_data;

    // PC Logic
    assign pc_next = (branch && zero_flag) ? pc + (imm << 1) : pc + 4;

    // Modules
    program_counter PC (
        .clk(clk), .reset(reset), .pc_next(pc_next), .pc(pc)
    );

    instruction_memory IMEM (
        .address(pc), .instruction(instruction)
    );

    control_unit CU (
        .opcode(opcode),
        .alu_src(alu_src), .mem_to_reg(mem_to_reg), .reg_write(reg_write),
        .mem_read(mem_read), .mem_write(mem_write), .branch(branch),
        .alu_op(alu_op)
    );

    register_file RF (
        .clk(clk), .rs1(rs1), .rs2(rs2), .rd(rd),
        .wd(mem_to_reg ? mem_read_data : alu_result),
        .reg_write(reg_write),
        .rd1(reg_data1), .rd2(reg_data2)
    );

    imm_generator IMMGEN (
        .instruction(instruction), .imm_out(imm)
    );

    alu_control ALUCTRL (
        .alu_op(alu_op), .funct3(funct3), .funct7_bit(funct7[5]), .alu_ctrl(alu_ctrl)
    );

    assign alu_input2 = (alu_src) ? imm : reg_data2;

    alu ALU (
        .a(reg_data1), .b(alu_input2), .alu_control(alu_ctrl),
        .result(alu_result), .zero(zero_flag)
    );

    data_memory DMEM (
        .clk(clk), .mem_read(mem_read), .mem_write(mem_write),
        .addr(alu_result), .write_data(reg_data2),
        .read_data(mem_read_data)
    );

endmodule