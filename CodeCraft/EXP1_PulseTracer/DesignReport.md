DESIGN REPORT
Title: Design and Verification of a Debounce-Based Pulse Tracer Module
Prepared by: [ALETI SNEHA]
DESCRIPTION:

The project kicked off with understanding the challenge—digital systems often deal with external signals that are prone to noise from things like mechanical switches, asynchronous inputs, or electromagnetic interference. These can create unwanted glitches that might falsely trigger logic. My PulseTracer module addresses this by filtering out the noise, debouncing the input, and generating a precise pulse for each valid event. I used a shift-register-based debounce mechanism paired with edge detection, and I verified everything with a comprehensive testbench that simulated various noisy scenarios.

The main goal was to create a module that accepts a noisy input signal, debounces it over a configurable number of clock cycles to ensure stability, and outputs a single-clock-cycle pulse only on valid rising edges. This is incredibly useful for applications like button press detection, signal synchronization, or triggering noise-tolerant finite state machines without false alarms.

I named the module PulseTracer, and it's designed to be flexible with a parameter that sets how many consecutive cycles the input must stay stable before it's considered valid. The module has four main connections: a clock input for timing, an active-low reset for initialization, the noisy input signal itself, and an output that produces the clean pulse.

For the design approach, I focused on debouncing first. The module uses a shift register that tracks the input over time, shifting in new values each cycle. It checks if the signal has been consistently high or low for the required duration—if all values in the register match, it declares the signal stable. This effectively ignores short glitches that don't last long enough, preventing them from causing issues.

Then, for detecting the rising edges, the module compares the current stable state to the previous one, producing a pulse only when it transitions from low to high. This ensures just one pulse per valid event, even if the input stays high for a long time—no repeats or extras.

To test it thoroughly, I built a testbench that runs on a 10-nanosecond clock cycle, applies resets, and injects a variety of noise patterns. It logs outputs for quick checks and generates waveforms for deeper analysis. I covered seven key scenarios to push the module to its limits.

In the first test, I introduced a short glitch that didn't meet the stability requirement, expecting no pulse at all. The second involved a stable high period, which should trigger exactly one pulse. For the third, I simulated random toggling that never stabilizes, resulting in no output. The fourth tested back-to-back valid pulses, aiming for two clean ones. The fifth held the input high for a long time, expecting only the initial pulse. The sixth included a glitch that interrupted stability, followed by recovery, leading to one pulse after stabilization. Finally, the seventh mixed random noise with a forced valid pulse, producing just one output at the end.

Running the simulations was eye-opening—the module successfully filtered out short glitches, only pulsed on stable rising edges, avoided multiples during long highs, handled multiple events accurately, and ignored random noise. It performed flawlessly across the board.


