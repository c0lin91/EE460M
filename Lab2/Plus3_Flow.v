module Plus3_Flow(X, CLK, S, V);
input X, CLK;
output S, V;
reg Q1, Q2, Q3;

initial
begin
   Q1 = 0;
   Q2 = 0;
   Q3 = 0;
end

always @(posedge CLK)

begin
   Q1 <= ((Q1 & ~Q2 & Q3) | (~Q1 & Q2 & Q3) | (~Q1 & Q2 & ~X));
   Q2 <= ((~Q1 & ~Q2 & ~X) | (~Q1 & ~Q2 & Q3) | (~Q1 & Q2 & X));
   Q3 <= ((~Q1 & X) | (~Q1 & Q2 & ~Q3) | (~Q1 & ~Q2 & Q3));
end

assign S = ((~Q1 & ~Q3 & ~X) | (Q2 & Q3 & ~X) 
            | (Q1 & ~Q2 & X) | (~Q2 & Q3 & X));

assign V = (Q1 & Q2 & Q3 & X);

endmodule