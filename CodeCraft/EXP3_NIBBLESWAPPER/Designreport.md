Title: Design and Verification of a NibbleSwapper Module

Prepared by: [ALETI SNEHA]

1. Introduction
In digital systems, data manipulation often requires efficient operations on byte-level data, such as rearranging bits or nibbles (4-bit groups). The NibbleSwapper module addresses this by providing a simple, clocked mechanism to swap the upper and lower nibbles of an 8-bit input signal when enabled, or to hold the previous output value otherwise. This design is particularly useful in applications involving data formatting, encryption preprocessing, or signal processing where nibble-level operations are needed.

The module is implemented in Verilog and includes reset functionality for initialization. A comprehensive testbench verifies its behavior under various conditions, ensuring correct swapping, holding, and reset operations.

2. Design Objective
The primary objective of the NibbleSwapper module is to:

Accept an 8-bit input signal (in)
On each positive clock edge, swap the upper nibble (bits [7:4]) with the lower nibble (bits [3:0]) if the enable signal (swap_en) is asserted
Hold the previous output value if swap_en is deasserted
Clear the output to zero on active-high reset
This functionality supports scenarios such as:

Data rearrangement in communication protocols
Bit manipulation in cryptographic modules
Controlled output updates in sequential logic
3. Module Description
Module Name: NibbleSwapper

Parameters: None (fixed 8-bit width)

I/O Ports:

Port

Direction

Description

clk

Input

Clock input

reset

Input

Active-high reset

in

Input

8-bit input data

swap_en

Input

Enable signal for swapping

out

Output

8-bit output data

4. Design Methodology
The module uses a synchronous design with an asynchronous reset. The core logic is implemented in a single always block triggered on the positive edge of the clock or the positive edge of reset.

Reset Behavior: When reset is asserted, the output is immediately cleared to 8'h00, ensuring a known initial state.
Swapping Logic: If reset is not asserted and swap_en is high, the module concatenates the lower nibble of in (bits [3:0]) with the upper nibble (bits [7:4]) to form the output.
Holding Logic: If swap_en is low, the output retains its previous value, effectively acting as a register.
This approach ensures minimal latency (one clock cycle for updates) and prevents unintended changes when swapping is disabled.

Reset correctly initializes the output to zero.
Swapping occurs accurately, exchanging nibbles as expected.
Holding preserves the output when swap_en is low.
Edge cases with identical nibbles produce no effective change.
Asynchronous reset overrides other operations instantly.
The module performs as designed, with no timing violations or unexpected behaviors.

5. Conclusion
The NibbleSwapper module offers a straightforward solution for nibble swapping and output holding in digital systems. Its synchronous design with asynchronous reset ensures reliability and ease of integration into larger circuits, such as data processors or control units.

The testbench thoroughly validates all functional aspects, confirming correct operation under reset, enable, and hold conditions. This design is well-suited for FPGA/ASIC implementations requiring simple data manipulation. The project reinforced principles of sequential logic and verification in HDL programming.