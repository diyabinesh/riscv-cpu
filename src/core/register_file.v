`timescale 1ns / 1ps

module register_file (
    input clk,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] wd,
    input reg_write,
    output [31:0] rd1,
    output [31:0] rd2
);
    reg [31:0] regs [0:31];

    assign rd1 = regs[rs1];
    assign rd2 = regs[rs2];

    always @(posedge clk) begin
        if (reg_write && rd != 0)
            regs[rd] <= wd;
    end
endmodule