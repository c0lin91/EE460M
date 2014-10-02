module BCDCounter(D, Enable, Load, Up, Clr, Q, Co, CLK);
   input Enable, Load, Up, Clr, CLK;
   input [3:0] D;

   output Co;
   output reg [3:0] Q;

   initial begin
      Q = 0;
   end

   always @(Clr)
   begin
      if(Clr == 0) Q <= 0;
   end

   always @(posedge CLK)
   begin
      if(Clr == 1) begin
         if((Load == 1) && (Enable == 1)) Q <= D;
         else if((Load == 0) && (Enable == 1) && (Up == 1)) begin
            if(Q == 9) Q <= 0;
            else Q <= Q + 1;
         end
         else if((Load == 0) && (Enable == 1) && (Up == 0)) begin
            if(Q == 0) Q <= 9;
            else Q <= Q - 1;
         end
      end
   end

   assign Co = ((Enable == 1) && (((Q == 9) && (Up == 1)) || ((Q == 0) && (Up == 0))));
endmodule

module BCDCounter_100(D1, D2, Enable, Load, Up, Clr, Q1, Q2, Co, CLK);
   input Enable, Load, Up, Clr, CLK;
   input [3:0] D1, D2;

   output Co;
   output [3:0] Q1, Q2;

   wire Carry, B2En;
   wire [7:0] FinalCount;
   
   // Enable the high bit counter if there was a carry or if loading.
   assign B2En = (((Enable == 1)) && ((Carry || Load)));

   BCDCounter B1(D1, Enable, Load, Up, Clr, Q1, Carry, CLK);
   BCDCounter B2(D2, B2En, Load, Up, Clr, Q2, Co, CLK);
   
   assign FinalCount = {Q2, Q1};
endmodule






