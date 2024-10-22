module clock_div
#(
    parameter BIT_COUNT = 17
)
(
    input clock,
    input reset,
    output reg div_clock
);

    reg intreset;
    wire [16:0] intcount;

    counter #(.WIDTH(BIT_COUNT)) count(
        .clock(clock),
        .reset(intreset),
        .count(intcount)
    );

    // Want to create logic that
    // is synchronous to the rest
    // and count signals
    always @(reset, intcount) begin
        if (reset) begin
            // If we get reset, pass it through
            // to the counter
            // and reset out clock output
            intreset = 1;
            div_clock = 0;
        end else if (intcount == 100000) begin
            // Otherwise, if the count is equal
            // to our tickover point, then we
            // need to reset the counter and
            // toggle our output
            intreset = 1;
            div_clock = ~div_clock;
        end else begin
            // Otherwise, just let it count
            intreset = 0;
        end
        
    end

    // 100 MHz input clock Divide by either 2^17 or use a counter based divider
    // to output to div_clock

    // Use the reset signal to set the initial state of your div_clock as well
    // as reset whatever div method you are using

    // If you use the 2^N divider, try instantiating the flip flops with a
    // genvar and generate block

    // If you use the counter block, try using parameters in the counter module
    // to specify the number of bits
    
    // IMPORTANT NOTE!! If you do a counter based divider, make sure to only
    // divide clock by 2 during test bench runs or your tests will fail. This
    // will automatically happen for you if you use 2^N divider and the
    // BIT_COUNT parameter

endmodule
