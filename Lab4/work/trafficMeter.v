module trafficMeter(B0, B1, B2, B3, SW0, SW1, CLK, LOAD, CLR, D1, D2, D3, D4, Q1, Q2, Q3, Q4);
   input B0, B1, B2, B3, SW0, SW1, CLK, LOAD, CLR;
   input [3:0] D1, D2, D3, D4;
   output [3:0]Q1, Q2, Q3, Q4;

   wire CO, CO2, CO3, CO4, ENABLE2, ENABLE3, ENABLE4;



   //inputModule(B0, B1, B2, B3, SW0, SW1, CLK);
   //controllerModule(/*not sure what needs to go here yet*/);
   //outputModule(/*segmented display outputs*/);

   BCDCounterA T1(CLK, D1, ENABLE, LOAD, 0, CLR, Q1, CO);
   BCDCounterA T2(CLK, D2, ENABLE2, LOAD, 0, CLR, Q2, CO2);
   BCDCounterA T3(CLK, D3, ENABLE3, LOAD, 0, CLR, Q3, CO3);
   BCDCounterA T4(CLK, D4, ENABLE4, LOAD, 0, CLR, Q4, CO4);

   assign ENABLE2 = (ENABLE && ((Q1 == 4'd0) || (LOAD == 1)));
   assign ENABLE3 = (ENABLE2 && ((Q2 == 4'd0) || (LOAD == 1)));
   assign ENABLE4 = (ENABLE3 && ((Q3 == 4'd0) || (LOAD == 1)));

endmodule
