module Testbench;

   parameter N = 25; // This may change later
   reg reset, CLK;

   //weight ranges from 0 - 2047
   reg [11:0] weight;

   wire [7:0] Grp1, Grp2, Grp3, Grp4, Grp5, Grp6;
   wire [2:0] currentGrp;

   reg [11:0] weightArray[1:N];
   reg [2:0]  currentGrpResult[1:N];

   reg [7:0] Grp1Result, Grp2Result, Grp3Result, Grp4Result, Grp5Result, Grp6Result;

   integer error;
   initial
   begin
      reset = 0;
      CLK = 0;
      weight = 0;

      weightArray[0] = 0;
      weightArray[1] = 2001;
      weightArray[2] = 0;
      weightArray[3] = 1001;
      weightArray[4] = 0;
      weightArray[5] = 801;
      weightArray[6] = 0;
      // All packages before this comment will not be in total due to reset
      weightArray[7] = 501;
      weightArray[8] = 0;
      weightArray[9] = 5;
      weightArray[10] = 0;
      weightArray[11] = 1;
      weightArray[12] = 0;
      weightArray[13] = 201;
      weightArray[14] = 0;
      weightArray[15] = 501;
      weightArray[16] = 0;
      weightArray[17] = 801;
      weightArray[18] = 0;
      weightArray[19] = 1001;
      weightArray[20] = 0;
      weightArray[21] = 2001;
      weightArray[22] = 1001; // Not counted
      weightArray[23] = 0;
      weightArray[24] = 5;
      weightArray[25] = 505; //Not counted

      currentGrpResult[0] = 0;
      currentGrpResult[1] = 6;
      currentGrpResult[2] = 0;
      currentGrpResult[3] = 5;
      currentGrpResult[4] = 0;
      currentGrpResult[5] = 4;
      currentGrpResult[6] = 0;
      currentGrpResult[7] = 3;
      currentGrpResult[8] = 0;
      currentGrpResult[9] = 1;
      currentGrpResult[10] = 0;
      currentGrpResult[11] = 1;
      currentGrpResult[12] = 0;
      currentGrpResult[13] = 2;
      currentGrpResult[14] = 0;
      currentGrpResult[15] = 3;
      currentGrpResult[16] = 0;
      currentGrpResult[17] = 4;
      currentGrpResult[18] = 0;
      currentGrpResult[19] = 5;
      currentGrpResult[20] = 0;
      currentGrpResult[21] = 6;
      currentGrpResult[22] = 5;
      currentGrpResult[23] = 0;
      currentGrpResult[24] = 1;
      currentGrpResult[25] = 3;

      Grp1Result = 3;
      Grp2Result = 1;
      Grp3Result = 2;
      Grp4Result = 1;
      Grp5Result = 1;
      Grp6Result = 1;

      error = 0;
   end

   integer i;

   always
   begin
      for(i = 0; i < N; i = i + 1)
      begin
         if(((i > 4) && (i < 7)) || (i == 0))     // reset is high on iteration 0, 8, 9, 10
         begin
            weight <= weightArray[i];
            reset <= 1;
         end else
         begin
            weight <= weightArray[i];
            reset <=0;
         end

         #5;
         CLK <= 1;
         // Let circuit settle and test inputs
         #3;
         if(currentGrp != currentGrpResult[i]) begin 
            $display("Wrong Group for weight of %d. on iteration %d", weight, i);
            error <= 1;
         end
         else $write("");

         // finish active edge and toggle clock
         #2;
         CLK <= 0;
      end

      if(Grp1Result != Grp1) begin
         $display("Wrong number for Grp1");
         error <= 1;
      end
      else $write("");
      if(Grp2Result != Grp2) begin
         $display("Wrong number for Grp2");
         error <= 1;
      end
      else $write("");
      if(Grp3Result != Grp3) begin
         $display("Wrong number for Grp3");
         error <= 1;
      end
      else $write("");
      if(Grp4Result != Grp4) begin
         $display("Wrong number for Grp4");
         error <= 1;
      end
      else $write("");
      if(Grp5Result != Grp5) begin 
         $display("Wrong number for Grp5");
         error <= 1;
      end
      else $write("");
      if(Grp6Result != Grp6) begin
         $display("Wrong number for Grp6");
         error <= 1;
      end
      else $write("");
      
      // Allow time for error to get updated before assigning pass/fail
      #1;
      
      if(error == 0) $display("Test Passed!");
      else $display("TEST FAILED");
      
      // Long Idle time to indicate end of test
      #200;
   end

   Package_Sorter Ps(weight, Grp1, Grp2, Grp3, Grp4, Grp5, Grp6, currentGrp, reset, CLK);
endmodule