Title: Design and Verification of a DebouncerLite Module

Prepared by: [ALETI SNEHA]

1. Introduction
Digital systems interfacing with external environments often encounter noisy or asynchronous signals that can cause metastability or false triggering. The DebouncerLite module addresses this by synchronizing the input using a two-stage flip-flop synchronizer and implementing a counter-based debounce mechanism. It ensures the output only toggles after the input has remained stable for a configurable number of consecutive clock cycles (parameter N), filtering out short glitches while preventing metastability issues.

The module is implemented in Verilog with an asynchronous active-low reset. A comprehensive testbench verifies its debouncing behavior under various noise patterns, confirming reliable operation.

2. Design Objective
The primary objective of the DebouncerLite module is to:

Accept a noisy asynchronous input signal (noisy_in)
Synchronize it using a two-stage flip-flop to avoid metastability
Debounce the synchronized signal by requiring it to remain stable for N consecutive cycles before updating the output (debounced)
Reset all internal states on active-low reset
This is essential for applications such as:

Button debouncing in user interfaces
Signal conditioning in noisy environments
Reliable edge detection in control systems.

3. Design Methodology
The module combines synchronization and debouncing in a single sequential block.

Synchronization: A two-stage flip-flop (sync1 and sync2) synchronizes the asynchronous noisy_in to the clock domain, reducing metastability risks.
Debouncing Logic: A counter tracks consecutive cycles where the synchronized input (sync2) differs from the current debounced output. If they match, the counter resets. If they differ and the counter reaches N-1, the output updates to match sync2, and the counter resets.
Reset Behavior: On active-low reset, all flip-flops and the counter are cleared to 0.
This design ensures the output changes only after confirmed stability, with a latency of N cycles for transitions.

4. Conclusion
The DebouncerLite module provides a robust solution for debouncing asynchronous signals in digital systems, combining synchronization and counter-based stability checks. Its parameterized design allows flexibility for different noise tolerances.

The testbench validates all aspects, ensuring correct filtering and timing. This design is ideal for FPGA/ASIC applications requiring noise-immune inputs, underscoring the importance of metastability mitigation and sequential logic in HDL. The project demonstrated advanced synchronization techniques.