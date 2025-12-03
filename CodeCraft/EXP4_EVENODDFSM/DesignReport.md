Title: Design and Verification of an EvenOddFSM Module

Prepared by: [ALETI SNEHA]

1. Introduction
In digital systems, processing data often requires classifying numerical values, such as determining if a number is even or odd based on its least significant bit (LSB). The EvenOddFSM module provides a clocked mechanism to evaluate an 8-bit input data word when a valid signal is asserted, setting output flags to indicate even or odd status, or holding previous states otherwise. This design is valuable in applications like parity checking, arithmetic processing, or control logic in data pipelines.

The module is implemented in Verilog with reset functionality for initialization. A comprehensive testbench verifies its behavior, ensuring correct classification and holding under various conditions.

2. Design Objective
The primary objective of the EvenOddFSM module is to:

Accept an 8-bit input data word (data_in) and a validity signal (in_valid)
On each positive clock edge, if in_valid is asserted, check the LSB of data_in:
If LSB is 0, set even to 1 and odd to 0 (indicating even number)
If LSB is 1, set even to 0 and odd to 1 (indicating odd number)
Hold previous output values if in_valid is deasserted
Clear both outputs to 0 on active-high reset
This supports tasks such as:

Binary number classification in computational units
Error detection in data streams
Sequential decision-making in state-based systems.

3.4. Design Methodology
The module uses a synchronous design with an asynchronous reset. The core logic is implemented in a single always block triggered on the positive edge of the clock or the positive edge of reset.

Reset Behavior: When reset is asserted, both even and odd are immediately cleared to 0, ensuring a known initial state.
Classification Logic: If reset is not asserted and in_valid is high, the module examines the LSB of data_in. Based on whether it's 0 or 1, it sets the appropriate output flags.
Holding Logic: If in_valid is low, the outputs retain their previous values, acting as a register to preserve state.
This approach provides one-clock-cycle updates when valid data is present and maintains stability when inputs are invalid.

4.Conclusion
The EvenOddFSM module offers a simple yet effective solution for classifying binary numbers as even or odd in digital systems. Its synchronous design with asynchronous reset ensures predictable operation and seamless integration into data processing pipelines.

The testbench thoroughly validates all functional aspects, confirming correct classification and holding. This design is suitable for FPGA/ASIC applications requiring basic arithmetic checks, highlighting the role of sequential logic in HDL programming. The project emphasized the importance of validity signals in controlling state updates.



