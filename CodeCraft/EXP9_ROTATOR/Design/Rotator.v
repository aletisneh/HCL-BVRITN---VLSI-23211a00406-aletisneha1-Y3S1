`timescale 1ns/1ps

// -----------------------------------------------------------
// DUT: RotatorUnit
// - Parametric-width rotate register
// - On each clk when enable=1:
//       if load=1: state <= data_in  (no rotate this cycle)
//       else     : state <= rotate-by-1 based on dir
//   dir=0 -> rotate-left; dir=1 -> rotate-right
// - When enable=0: state holds (pause)
// - Async active-low reset clears state to 0
// -----------------------------------------------------------
module rotatorunit #(
    parameter int WIDTH = 8
) (
    input  logic              clk,
    input  logic              rst_n,      // async active-low
    input  logic              enable,     // gate for load/rotate
    input  logic              load,       // synchronous load
    input  logic              dir,        // 0: left, 1: right
    input  logic [WIDTH-1:0]  data_in,
    output logic [WIDTH-1:0]  data_out
);

    // Rotate helpers
    function automatic [WIDTH-1:0] rol1(input [WIDTH-1:0] x);
        rol1 = {x[WIDTH-2:0], x[WIDTH-1]};
    endfunction

    function automatic [WIDTH-1:0] ror1(input [WIDTH-1:0] x);
        ror1 = {x[0], x[WIDTH-1:1]};
    endfunction

    // Sequential logic with async active-low reset
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= '0;
        end else if (enable) begin
            if (load) begin
                data_out <= data_in;                             // load when enabled
            end else begin
                data_out <= (dir ? ror1(data_out) : rol1(data_out)); // rotate by 1
            end
        end
        // enable=0 -> hold state
    end

endmodule
