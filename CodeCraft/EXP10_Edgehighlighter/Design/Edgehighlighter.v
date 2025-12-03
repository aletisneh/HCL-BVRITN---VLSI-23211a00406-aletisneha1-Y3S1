`timescale 1ns/1ps

// -----------------------------------------------------------
// DUT: EdgeHighlighter
// - 2FF-synchronizes the input (optional param).
// - Emits 1-cycle pulses on rising and falling edges of the
//   synchronized input.
// - Async active-low reset.
// -----------------------------------------------------------
module edgehighlighter #(
    parameter bit USE_SYNC = 1   // 1: use 2FF sync on in_sig; 0: treat as synchronous
) (
    input  logic clk,
    input  logic rst_n,          // async active-low reset
    input  logic in_sig,         // input signal
    output logic rise_pulse,     // 1-cycle pulse on rising edge
    output logic fall_pulse      // 1-cycle pulse on falling edge
);

    // Synchronizer signals
    logic s1, s2;
    logic cur, prev;

    // Optional 2FF synchronizer
    generate
        if (USE_SYNC) begin : g_sync
            (* ASYNC_REG="true" *) always_ff @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    s1 <= 1'b0;
                    s2 <= 1'b0;
                end else begin
                    s1 <= in_sig;
                    s2 <= s1;
                end
            end
            assign cur = s2;
        end else begin : g_nosync
            assign cur = in_sig;
        end
    endgenerate

    // Edge detection logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            prev       <= 1'b0;
            rise_pulse <= 1'b0;
            fall_pulse <= 1'b0;
        end else begin
            rise_pulse <=  cur & ~prev;  // rising edge
            fall_pulse <= ~cur &  prev;  // falling edge
            prev       <=  cur;          // update previous state
        end
    end

endmodule
