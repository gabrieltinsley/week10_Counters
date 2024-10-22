module twos_complement (
  input [3:0] A,
  input [3:0] B,
  output [3:0] Y
);

  wire [3:0] B_ones_complement;
  wire [3:0] B_twos_complement;
  wire [3:0] sum1;
  wire [3:0] carry1;
  wire [3:0] carry2;

  // inverts number B to ones compliment
  assign B_ones_complement = ~B;

  // adds one to number B to get two's compliment of B
  full_adder adder_twos_lsb (
    .A(B_ones_complement[0]),
    .B(1'b1),   // Adding 1 to one's complement of B
    .Cin(1'b0), 
    .Y(B_twos_complement[0]),
    .Cout(carry1[0])
  );

  full_adder adder_twos_1 (
    .A(B_ones_complement[1]),
    .B(1'b0),   
    .Cin(carry1[0]), // Carry from LSB
    .Y(B_twos_complement[1]),
    .Cout(carry1[1])
  );

  full_adder adder_twos_2 (
    .A(B_ones_complement[2]),
    .B(1'b0),  
    .Cin(carry1[1]), // Carry from previous bit
    .Y(B_twos_complement[2]),
    .Cout(carry1[2])
  );

  full_adder adder_twos_3 (
    .A(B_ones_complement[3]),
    .B(1'b0),   
    .Cin(carry1[2]), // Carry from previous bit
    .Y(B_twos_complement[3]),
    .Cout(carry1[3])
  );

  // Adds A and two's compliment of B
  full_adder adder_lsb (
    .A(A[0]),
    .B(B_twos_complement[0]),
    .Cin(1'b0), // No initial carry
    .Y(Y[0]),
    .Cout(carry2[0])
  );

  full_adder adder_1 (
    .A(A[1]),
    .B(B_twos_complement[1]),
    .Cin(carry2[0]),
    .Y(Y[1]),
    .Cout(carry2[1])
  );

  full_adder adder_2 (
    .A(A[2]),
    .B(B_twos_complement[2]),
    .Cin(carry2[1]),
    .Y(Y[2]),
    .Cout(carry2[2])
  );

  full_adder adder_3 (
    .A(A[3]),
    .B(B_twos_complement[3]),
    .Cin(carry2[2]),
    .Y(Y[3]),
    .Cout(carry2[3])
  );
endmodule
    
