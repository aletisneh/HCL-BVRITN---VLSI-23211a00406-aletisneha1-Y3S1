Title: Design and Verification of a LightChaser Module

Prepared by: [ALETI SNEHA]

1. Introduction
In digital systems, visual indicators like LED arrays are often used for status display or entertainment. The LightChaser module creates a "chasing light" effect by rotating a single active LED across an array of LEDs at a controlled speed. It uses a counter to pace the rotation, ensuring smooth transitions based on clock ticks. This design is ideal for applications such as decorative lighting, status indicators, or simple animations in embedded systems.

The module is implemented in Verilog with an asynchronous active-low reset and enable control. A comprehensive testbench verifies the rotation behavior, speed control, and reset functionality under various conditions.

2. Design Objective
The primary objective of the LightChaser module is to:

Generate a rotating LED pattern where only one LED is active at a time, starting from the least significant bit
Control the rotation speed using a parameter TICKS_PER_STEP, which specifies the number of clock cycles between each shift
Support an enable signal to pause or resume the chasing effect
Reset the pattern to the initial state (LED 0 active) on active-low reset
Allow configurability via parameters for array width (WIDTH) and timing (TICKS_PER_STEP)
This supports uses such as:

Visual feedback in user interfaces
Sequential lighting effects in displays
Timing demonstrations in educational projects
3. Module Description
Module Name: LightChaser

Parameters:

WIDTH: Number of LEDs in the array (default: 8)
TICKS_PER_STEP: Clock cycles per rotation step (default: 4).
4. Design Methodology
The module employs a synchronous design with an asynchronous reset. A counter (tick_cnt) regulates the timing of rotations, and a rotate-left function (rol1) shifts the active LED position.

Reset Behavior: On active-low reset, led_out is set to all zeros except the least significant bit (position 0), and the counter is cleared.
Rotation Logic: When enabled, the counter increments each clock cycle. Upon reaching TICKS_PER_STEP-1, the LED pattern rotates left by one position using the rol1 function, and the counter resets. If TICKS_PER_STEP is 1, rotation occurs every cycle.
Enable Control: Rotation only proceeds when enable is high; otherwise, the state holds.
This ensures precise timing and prevents unwanted shifts when disabled.
5. Conclusion
The LightChaser module offers an engaging solution for LED rotation effects in digital systems, with configurable speed and width for versatility. Its synchronous operation with asynchronous reset ensures reliable performance.

The testbench validates timing, control, and parameterization, confirming accurate rotation. This design is well-suited for FPGA/ASIC applications in visual displays, emphasizing the use of counters and functions in HDL. The project highlighted creative applications of sequential logic.

