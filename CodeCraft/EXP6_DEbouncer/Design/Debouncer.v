`timescale 1ns/1ps

// ---------------------------------------------------------
// DUT: DebouncerLite
// - 2FF synchronizer on noisy_in
// - Output toggles only after N consecutive cycles where
//   sync2 != debounced (new level stable)
// ---------------------------------------------------------
module debouncerlite #(
    parameter int N = 5
) (
    input  logic clk,
    input  logic rst_n,      // async active-low reset
    input  logic noisy_in,
    output logic debounced
);

    // Synchronizer flip-flops
    logic sync1, sync2;

    // Counter width: enough bits to count up to N
    localparam int CW = (N <= 2) ? 1 : $clog2(N);
    logic [CW:0] cnt;

    // Sequential logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sync1     <= 1'b0;
            sync2     <= 1'b0;
            debounced <= 1'b0;
            cnt       <= '0;
        end else begin
            // 2FF synchronizer
            sync1 <= noisy_in;
            sync2 <= sync1;

            if (sync2 == debounced) begin
                // Input matches current debounced → reset counter
                cnt <= '0;
            end else begin
                // Input differs → count consecutive cycles
                if (cnt >= (N-1)) begin
                    // After N stable cycles, update debounced
                    debounced <= sync2;
                    cnt       <= '0;
                end else begin
                    cnt <= cnt + 1'b1;
                end
            end
        end
    end

endmodule
