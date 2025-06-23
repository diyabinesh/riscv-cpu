`timescale 1ns / 1ps
`timescale 1ns / 1ps

module tb_riscv;

    reg clk;
    reg reset;

    riscv_cpu uut (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        
        clk = 0;
        forever #5 clk = ~clk;  
    end

    initial begin
        
        reset = 1;
        #10;
        reset = 0;

        
        #200;

        $finish;
    end

endmodule
