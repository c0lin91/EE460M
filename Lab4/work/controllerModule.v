// This module should have a 4 digit BCD and should be loading
module controllerModule(B0, B1, B2, B3, _4BCD, Q1, Q2, Q3, Q4, CLK);
   input B0, B1, B2, B3, CLK;
   // The 4 digit BCD counter value
   output [15:0] _4BCD;

   reg CLR;
   reg [13:0] addTime;
   output [3:0] Q1, Q2, Q3, Q4;
   wire Enable;
   wire [3:0] S1, S2, S3, S4, D1, D2, D3, D4;
   reg Load;
   initial begin
      addTime = 0;
      CLR = 1;
   end

   always @ (B0, B1, B2, B3)
   begin
      if(B0) begin
         addTime <= 50;
         Load <= 1;
      end
      else if(B1) begin
         addTime <= 150;
         Load <= 1;
      end
      else if(B2) begin
         addTime <= 200;
         Load <= 1;
      end
      else if(B3) begin
         addTime <= 500;
         Load <= 1;
      end
      else begin
         addTime <= 0;
         Load <= 0;
      end
   end

   Adder9999 adder(S1, S2, S3, S4, Q1, Q2, Q3, Q4, addTime, Load);

   assign D1 = S1;
   assign D2 = S2;
   assign D3 = S3;
   assign D4 = S4;

   BCD4 bcd(CLK, D1, D2, D3, D4, Q1, Q2, Q3, Q4, CLR, Load, Enable);

   assign _4BCD = (Load) ? {S4, S3, S2, S1} : {Q4, Q3, Q2, Q1};

   //BCD is only enabled when the counter is above 0 or a button is pushed. This prevents underflow
   assign Enable = ({Q4, Q3, Q2, Q1} > 0) || (Load);
endmodule
