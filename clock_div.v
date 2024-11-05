module dff(
    input reset,
    input clock,
    input D,
    output reg Q,
    output NotQ
);

    always @(posedge reset, posedge clock) begin
        if (reset) begin
            Q <= 0;
        end else if (clock) begin
            Q <= D;
        end
    end
     assign NotQ = ~Q;
endmodule

module clock_div
#(
    parameter DIVIDE_BY = 17 // Or 100,000 for counter implementation
)
(
    input clock,
    input reset,
    output reg div_clock
);

    wire [DIVIDE_BY:0] qOut;
    wire [DIVIDE_BY:1] qin;

   assign qOut[0] = clock;

    genvar i;

    generate
        for (i = 1; i <= DIVIDE_BY; i = i + 1) begin
            dff dff_inst(
                .reset(reset),
                .clock(qOut[i-1]),
                .D(qin[i]),
                .Q(qOut[i]),
                .NotQ(qin[i])
            );

        end
    endgenerate
always @(*) begin
    div_clock = qOut[DIVIDE_BY];
end
endmodule
