module BCD4(CLK, D1, D2, D3, D4, Q1, Q2, Q3, Q4, CLR, LOAD, ENABLE);
   input CLK, LOAD, CLR, ENABLE;
   input [3:0] D1, D2, D3, D4;
   output [3:0]Q1, Q2, Q3, Q4;
   wire CO;
   wire CO2, CO3, CO4, ENABLE2, ENABLE3, ENABLE4;

   BCDCounterA T1(CLK, D1, ENABLE, LOAD, 1'b0, 1'b1, Q1, CO);
   BCDCounterA T2(CLK, D2, ENABLE2, LOAD, 1'b0, 1'b1, Q2, CO2);
   BCDCounterA T3(CLK, D3, ENABLE3, LOAD, 1'b0, 1'b1, Q3, CO3);
   BCDCounterA T4(CLK, D4, ENABLE4, LOAD, 1'b0, 1'b1, Q4, CO4);

   assign ENABLE2 = (ENABLE && ((Q1 == 4'd0))) || (LOAD == 1);
   assign ENABLE3 = (ENABLE2 && ((Q2 == 4'd0))) || (LOAD == 1);
   assign ENABLE4 = (ENABLE3 && ((Q3 == 4'd0))) || (LOAD == 1);
   
endmodule
