`timescale 1ns/1ps

// -------------------------
// DUT: evenoddfsm
// -------------------------
// Functionality:
// - On reset: outputs cleared (even=0, odd=0)
// - On each positive clock edge:
//   * If in_valid = 1 → check LSB of data_in
//       - If data_in[0] == 0 → even=1, odd=0
//       - If data_in[0] == 1 → even=0, odd=1
//   * If in_valid = 0 → hold previous outputs (no change)
// -------------------------
module evenoddfsm (
    input  wire       clk,       // Clock input
    input  wire       reset,     // Active-high reset
    input  wire       in_valid,  // Input valid signal
    input  wire [7:0] data_in,   // 8-bit input data
    output reg        even,      // Output high if input is even
    output reg        odd        // Output high if input is odd
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            even <= 1'b0;
            odd  <= 1'b0;
        end else if (in_valid) begin
            if (data_in[0] == 1'b0) begin
                // Even number
                even <= 1'b1;
                odd  <= 1'b0;
            end else begin
                // Odd number
                even <= 1'b0;
                odd  <= 1'b1;
            end
        end else begin
            // Hold previous state when in_valid = 0
            even <= even;
            odd  <= odd;
        end
    end

endmodule
