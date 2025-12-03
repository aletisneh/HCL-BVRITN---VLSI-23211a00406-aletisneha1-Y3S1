`timescale 1ns/1ps

// -------------------------
// DUT: bitbalancer
// -------------------------
module bitbalancer (
    input  wire       clk,    // Clock input
    input  wire       reset,  // Active-high reset
    input  wire [7:0] in,     // 8-bit input vector
    output reg  [3:0] count   // 4-bit output: number of 1s in 'in'
);

    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'd0;   // Reset output to 0
        end else begin
            count = 4'd0;    // Clear count before accumulation
            for (i = 0; i < 8; i = i + 1) begin
                if (in[i])   // Check each bit of input
                    count = count + 1;
            end
        end
    end

endmodule
