`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module alu (
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_control,
    output reg [31:0] result,
    output zero
);
    always @(*) begin
        case (alu_control)
            4'b0000: result = a & b;       // AND
            4'b0001: result = a | b;       // OR
            4'b0010: result = a + b;       // ADD
            4'b0110: result = a - b;       // SUB
            4'b0111: result = (a < b) ? 1 : 0; // SLT
            default: result = 0;
        endcase
    end

    assign zero = (result == 0);
endmodule