`timescale 1ns/1ps

// -------------------------
// DUT: NibbleSwapper
// -------------------------
// Functionality:
// - On reset: output cleared to 0
// - On each positive clock edge:
//   * If swap_en = 1 → swap upper and lower nibbles of 'in'
//   * If swap_en = 0 → hold previous output (no change)
// -------------------------
module nibbleswapper (
    input  wire       clk,      // Clock input
    input  wire       reset,    // Active-high reset
    input  wire [7:0] in,       // 8-bit input
    input  wire       swap_en,  // Enable swap
    output reg  [7:0] out       // 8-bit output
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 8'h00;  // Reset clears output
        end else begin
            if (swap_en) begin
                // Swap upper nibble [7:4] with lower nibble [3:0]
                out <= {in[3:0], in[7:4]};
            end else begin
                // Hold previous output when swap_en = 0
                out <= out;
            end
        end
    end

endmodule
