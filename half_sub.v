module half_sub (
  // Declare AB inputs
  input A, B,
  // Declare Y and borrow outputs
  output Y, borrow
);
  // Enter logic equation
  assign Y = A ^ B;
  assign borrow = ~A & B;

endmodule
