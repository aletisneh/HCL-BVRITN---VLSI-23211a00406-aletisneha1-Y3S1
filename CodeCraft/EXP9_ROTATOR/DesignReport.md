1. Introduction
The RotatorUnit is a parametric-width register that supports synchronous load and single-bit rotation operations. It is designed to operate under clock control with enable gating, direction selection, and asynchronous active-low reset. The module is flexible, allowing different register widths via a parameter.

2. Design Specifications
Language: SystemVerilog

Parameter:

WIDTH (default = 8) → defines the bit-width of the register.

Inputs:

clk → Clock signal.

rst_n → Asynchronous active-low reset.

enable → Enables load/rotate operations.

load → When high, loads data_in into the register.

dir → Rotation direction (0 = left, 1 = right).

data_in [WIDTH-1:0] → Input data bus.

Output:

data_out [WIDTH-1:0] → Register output after load/rotate operations.

3. Functional Description
Reset Behavior:

When rst_n = 0, the register clears to all zeros (data_out = 0).

Enable Behavior:

When enable = 0, the register holds its current state (pause mode).

When enable = 1:

If load = 1, the register synchronously loads data_in.

If load = 0, the register rotates by one bit:

dir = 0 → Rotate left (ROL1).

dir = 1 → Rotate right (ROR1).
4. Design Features
Parametric Width: Can be configured for any bit-width (default 8).

Synchronous Load: Ensures deterministic state initialization.

Single-bit Rotation: Efficient circular shift operation.

Enable Gating: Supports pause/resume functionality.

Asynchronous Reset: Provides immediate clearing of state independent of clock.

5. Verification Strategy
Testbench Features:

Clock generation (10 ns period).

Reset assertion/deassertion.

Stimulus tasks for load and rotate operations.

Reference model (scoreboard) to mirror DUT behavior.

Assertions to check DUT output against reference.

Deterministic test cases: reset, load, rotate left/right, pause, wrap-around, all-zeros, all-ones.

Critical Test Cases:

Reset and hold state.

Load specific value and rotate left multiple steps.

Pause with enable=0 (state must hold).

Rotate right multiple steps.

Toggle direction each cycle.

Load mid-run and rotate.

Attempt load with enable=0 (ignored).

Edge cases: all-zeros and all-ones.

Wrap-around check after WIDTH rotations.