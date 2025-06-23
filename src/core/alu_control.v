`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module alu_control (
    input [1:0] alu_op,
    input [2:0] funct3,
    input funct7_bit,
    output reg [3:0] alu_ctrl
);
    always @(*) begin
        case (alu_op)
            2'b00: alu_ctrl = 4'b0010;  // LW/SW
            2'b01: alu_ctrl = 4'b0110;  // BEQ
            2'b10: begin  // R-type
                case ({funct7_bit, funct3})
                    4'b0000: alu_ctrl = 4'b0010;  // ADD
                    4'b1000: alu_ctrl = 4'b0110;  // SUB
                    4'b0111: alu_ctrl = 4'b0000;  // AND
                    4'b0110: alu_ctrl = 4'b0001;  // OR
                    default: alu_ctrl = 4'b1111;
                endcase
            end
            default: alu_ctrl = 4'b1111;
        endcase
    end
endmodule