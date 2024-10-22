module subtractor (
  input [3:0] a,
  input [3:0] b,
  input wire sel,
  output [3:0] Cout,
  output carry
);
    wire [2:0]s;
    wire [3:0]l;
    assign l[0] = b[0] ^ sel;
    assign l[1] = b[1] ^ sel;
    assign l[2] = b[2] ^ sel;
    assign l[3] = b[3] ^ sel;
  full_adder f1(a[0],l[0],sel,Cout[0],s[0]);
  full_adder f2(a[1],l[1],s[0],Cout[1],s[1]);
  full_adder f3(a[2],l[2],s[1],Cout[2],s[2]);
  full_adder f4(a[3],l[3],s[2],Cout[3],carry_barrow);

endmodule
