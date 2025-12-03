Design Report: EdgeHighlighter
1. Introduction
The EdgeHighlighter is a digital design module that detects rising and falling edges of an input signal and generates one‑cycle pulses corresponding to those transitions. It optionally includes a two‑flip‑flop synchronizer to safely bring asynchronous signals into the clock domain. This design is widely applicable in event detection, control logic, and digital communication systems.

2. Design Specifications
Language: SystemVerilog

Parameter:

USE_SYNC (default = 1) → enables/disables 2FF synchronizer.

Inputs:

clk → Clock signal.

rst_n → Asynchronous active‑low reset.

in_sig → Input signal (may be asynchronous).

Outputs:

rise_pulse → One‑cycle pulse on rising edge of in_sig.

fall_pulse → One‑cycle pulse on falling edge of in_sig.

3. Functional Description
Reset Behavior:

When rst_n = 0, all internal registers and outputs are cleared.

Synchronization (optional):

If USE_SYNC = 1, in_sig passes through a 2FF synchronizer (s1, s2) to avoid metastability.

If USE_SYNC = 0, in_sig is treated as synchronous directly.

Edge Detection:

Rising edge: rise_pulse = cur & ~prev

Falling edge: fall_pulse = ~cur & prev

prev stores the previous cycle’s value of cur.

Pulse Behavior:

Both rise_pulse and fall_pulse are asserted for exactly one clock cycle.

Mutual exclusion: only one of them can be high in a given cycle.

4. Design Features
Configurable Synchronization: Parameterized option to handle asynchronous inputs.

One‑Cycle Pulse Generation: Ensures clean edge detection without glitches.

Asynchronous Reset: Provides immediate clearing of state independent of clock.

Compact Logic: Minimal hardware footprint (few flip‑flops and simple combinational logic).

5. Verification Strategy
Testbench Features:

Clock generation (10 ns period).

Reset assertion/deassertion.

Stimulus tasks to generate pulses of varying widths.

Reference model mirroring DUT behavior.

Assertions to check DUT outputs against reference.

Mutual exclusion check (rise and fall pulses never overlap).

Critical Test Cases:

Single short pulse → expect one rise then one fall.

Wide high pulse → one rise at start, one fall at end.

Back‑to‑back pulses separated by low cycles.

Long low period → no pulses.

Alternating input (0101…) → rise/fall pulses every cycle.

Reset mid‑stream → clears history, next edge treated fresh.