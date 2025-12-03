module lightchaser #(
    parameter int WIDTH          = 8,
    parameter int TICKS_PER_STEP = 4
) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic              enable,
    output logic [WIDTH-1:0]  led_out
);

    localparam int CW = (TICKS_PER_STEP <= 1) ? 1 : $clog2(TICKS_PER_STEP);
    logic [CW:0] tick_cnt;

    function automatic [WIDTH-1:0] rol1(input [WIDTH-1:0] x);
        rol1 = {x[WIDTH-2:0], x[WIDTH-1]};
    endfunction

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            led_out  <= '0;
            led_out[0] <= 1'b1;
            tick_cnt <= '0;
        end else if (enable) begin
            if (TICKS_PER_STEP == 1) begin
                led_out  <= rol1(led_out);
                tick_cnt <= '0;
            end else if (tick_cnt == TICKS_PER_STEP-1) begin
                led_out  <= rol1(led_out);
                tick_cnt <= '0;
            end else begin
                tick_cnt <= tick_cnt + 1;
            end
        end
    end
endmodule
