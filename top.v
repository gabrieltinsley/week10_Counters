module top
#(
    parameter BIT_COUNT = 17 // Use this when passing in to your clock div!
    // The test bench will set it appropriately
)
(
    input [7:0] sw, // A and B
    input clk, // 100 MHz board clock
    input btnC, 
    //input [1:0] addr,// Reset
    output [3:0] an, // 7seg anodes
    output [6:0] seg // 7seg segments
);

    // Instantiate the clock divider...
    // ... wire it up to the scanner
    // ... wire the scanner to the decoder

    // Wire up the math block into the decoder

    // Do not forget to wire up resets!!

    // Split switches into two 4-bit signals A and B
    wire [3:0] A = sw[3:0];
    wire [3:0] B = sw[7:4];

    // Clock divider output
    wire div_clock;

    // Scanner wires
    wire [3:0] anode;
    
    wire [1:0] addr;

    // Math block outputs
    wire [3:0] AplusB;
    wire [3:0] AminusB;

    // Instantiate the clock divider
    clock_div #(.BIT_COUNT(BIT_COUNT)) clk_div_inst (
        .clock(clk),
        .reset(btnC),
        .div_clock(div_clock)
    );

    // Instantiate the 7-segment scanner (to cycle through the anodes)
    seven_seg_scanner scanner_inst (
        .div_clock(div_clock),
        .reset(btnC),
        .anode(an)
    );

    // Instantiate the math block (performing A + B and A - B)
    math_block math_inst (
        .A(A),
        .B(B),
        .AplusB(AplusB),
        .AminusB(AminusB)
    );

    // Instantiate the seven-segment decoder
    seven_seg_decoder decoder_inst (
        .A(A),
        .B(B),
        .AplusB(AplusB),
        .AminusB(AminusB),
        .anode(an),
        .segs(seg)
    );

    // Connect the anode output to the display anode
//    assign an = anode;
//    always @(*) begin 
//        case(addr)
//        2'b00: an <= anode[0];
//        2'b01: an <= anode[1];
//        2'b10: an <= anode[2];
//        2'b11: an <= anode[3];
//        endcase
//   end

endmodule
