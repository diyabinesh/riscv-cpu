# RISC-V CPU in Verilog

This project is a modular implementation of a 32-bit RISC-V CPU (RV32I) written in Verilog. It includes essential components such as the ALU, control unit, register file, instruction and data memory, and an immediate generator. A testbench is provided to simulate the CPU using preloaded instructions.

## Features

- Supports the base RV32I instruction set
- Modular design for clarity and extensibility
- Instruction and data memory implemented using simple Verilog modules
- Testbench included for simulation and verification

## How to Run

1. Open the project in your Verilog simulator (e.g., ModelSim, Icarus Verilog).
2. Compile all Verilog files.
3. Run the `tbriscvcpu.v` testbench.
4. View waveform output (optional) using GTKWave or your preferred tool.

## Files

- `riscv_cpu.v` – Top-level CPU module
- Submodules: ALU, Control Unit, Register File, Immediate Generator, etc.
- `tbriscvcpu.v` – Testbench
- `instructions.mem` – Preloaded instruction memory contents

