module Plus3_Struct(X, CLK, S, V);
   input X, CLK;
   output S, V;

   // Inverted input
   wire Xn;

   // AND gate outputs
   wire ABnC, AnBC, AnBXn, AnBnXn, AnBnC, AnBX, AnX, AnBCn, AnCnXn, BCXn, ABnX, BnCX;

   // Flip flop inputs
   wire D1, D2, D3;

   // Flip flop outputs
   wire Q1, Q2, Q3, Q1n, Q2n, Q3n;

   Inverter1 I1(X, Xn);

   // Minterms
   AND3 A1(Q1, Q2n, Q3, ABnC);
   AND3 A2(Q1n, Q2, Q3, AnBC);
   AND3 A3(Q1n, Q2, Xn, AnBXn);
   AND3 A4(Q1n, Q2n, Xn, AnBnXn);
   AND3 A5(Q1n, Q2n, Q3, AnBnC);
   AND3 A6(Q1n, Q2, X, AnBX);
   AND2 A7(Q1n, X, AnX);
   AND3 A8(Q1n, Q2, Q3n, AnBCn);
   AND3 A9(Q1n, Q3n, Xn, AnCnXn);
   AND3 A10(Q2, Q3, Xn, BCXn);
   AND3 A11(Q1, Q2n, X, ABnX);
   AND3 A12(Q2n, Q3, X, BnCX);

   // Next States
   OR3 O1(ABnC, AnBC, AnBXn, D1);
   OR3 O2(AnBnXn, AnBnC, AnBX, D2);
   OR3 O3(AnX, AnBCn, AnBnC, D3);

   //Flip Flop Declarations
   DFF F1(D1, CLK, Q1, Q1n);
   DFF F2(D2, CLK, Q2, Q2n);
   DFF F3(D3, CLK, Q3, Q3n);

   //Outputs
   OR4 O4(AnCnXn, BCXn, ABnX, BnCX, S);
   AND4 A13(Q1, Q2, Q3, X, V);
endmodule


module DFF(D, CLK, Q, Qn);
   input D, CLK;
   output reg Q, Qn;

   initial
   begin
      Q = 1'b0;
      Qn = 1'b1;
   end

   always @(posedge CLK)
   begin
      Q <= D;
      Qn <= ~D;
   end
endmodule

module OR3(A, B, C, O);
   input A, B, C;
   output O;

   assign O = (A | B | C);
endmodule

module OR4(A, B, C, D, O);
   input A, B, C, D;
   output O;
   
   assign O = (A| B | C | D);
endmodule

module AND2(A, B, O);
   input A, B;
   output O;
   
   assign O = A & B;
endmodule

module AND3(A, B, C, O);
   input A, B, C;
   output O;
   
   assign O = (A & B & C);
endmodule

module AND4(A, B, C, D, O);
   input A, B, C, D;
   output O;
   
   assign O = (A & B & C & D);
endmodule

module Inverter1(X, Xn);
   input X;
   output Xn;
   
   assign Xn = ~(X);
endmodule

