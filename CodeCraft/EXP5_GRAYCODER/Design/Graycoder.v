`timescale 1ns/1ps

// -----------------------------------------------------------
// DUT: GrayCoder
// - Converts 4-bit binary input into 4-bit Gray code.
// - On each positive clock edge, gray_out updates.
// - Gray code rule:
//   * MSB stays same
//   * Each next bit = XOR of current binary bit and previous binary bit
// -----------------------------------------------------------
module graycoder (
    input  logic       clk,       // Clock input
    input  logic [3:0] bin_in,    // 4-bit binary input
    output logic [3:0] gray_out   // 4-bit Gray code output
);

    always_ff @(posedge clk) begin
        // Gray code conversion
        gray_out[3] <= bin_in[3];                  // MSB unchanged
        gray_out[2] <= bin_in[3] ^ bin_in[2];      // XOR of bit3 and bit2
        gray_out[1] <= bin_in[2] ^ bin_in[1];      // XOR of bit2 and bit1
        gray_out[0] <= bin_in[1] ^ bin_in[0];      // XOR of bit1 and bit0
    end

endmodule
