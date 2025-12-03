`timescale 1ns/1ps

// -------------------------------------------------------------
// DUT: SeqCheck
// Detect K rising edges within a sliding window of W cycles.
// Emits a 1-cycle pulse 'hit' exactly when the running count
// of rises in the last W cycles crosses >= K.
// -------------------------------------------------------------
module seqcheck #(
    parameter int W = 5,   // window length (cycles)
    parameter int K = 3    // required rising edges in window
) (
    input  logic clk,
    input  logic rst_n,    // async active-low reset
    input  logic in_sig,
    output logic hit       // 1-cycle pulse when threshold crossed
);

    // ---------------- Synchronizer + rise detection ----------------
    logic s1, s2, prev;
    logic rise;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s1   <= 1'b0;
            s2   <= 1'b0;
            prev <= 1'b0;
        end else begin
            s1   <= in_sig;
            s2   <= s1;
            prev <= s2;
        end
    end

    assign rise = s2 & ~prev;

    // ---------------- Ring buffer + running sum ----------------
    localparam int IW = (W <= 2) ? 1 : $clog2(W);
    localparam int SW = (W <= 1) ? 1 : $clog2(W+1);

    logic [SW-1:0] sum, next_sum;
    logic [IW-1:0] idx;
    logic [W-1:0]  rb;
    logic          cond_d, cond_next;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum     <= '0;
            idx     <= '0;
            rb      <= '0;
            cond_d  <= 1'b0;
            hit     <= 1'b0;
        end else begin
            // Update sum with new rise, subtract oldest entry
            next_sum = sum - rb[idx] + rise;

            sum        <= next_sum;
            rb[idx]    <= rise;
            idx        <= (idx == W-1) ? '0 : (idx + 1'b1);

            // Threshold detection
            cond_next  <= (next_sum >= K);
            hit        <= cond_next & ~cond_d;  // pulse when crossing threshold
            cond_d     <= cond_next;
        end
    end

endmodule
