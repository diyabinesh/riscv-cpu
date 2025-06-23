`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module data_memory (
    input clk,
    input mem_read,
    input mem_write,
    input [31:0] addr,
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] memory [0:255];

    always @(posedge clk) begin
        if (mem_write)
            memory[addr >> 2] <= write_data;
    end

    assign read_data = (mem_read) ? memory[addr >> 2] : 32'b0;
endmodule