module Package_Sorter(weight, Grp1, Grp2, Grp3, Grp4, Grp5, Grp6, currentGrp, reset, CLK);

   input reset, CLK;
   input [11:0] weight;

   output reg [7:0] Grp1, Grp2, Grp3, Grp4, Grp5, Grp6;
   output reg [2:0] currentGrp;

   reg [2:0] State;

   initial begin
      State = 0;
      currentGrp = 0;
      Grp1 = 0;
      Grp2 = 0;
      Grp3 = 0;
      Grp4 = 0;
      Grp5 = 0;
      Grp6 = 0;
   end

   always @(negedge CLK or posedge reset) begin
      if(reset == 1) begin
         Grp1 <= 0;
         Grp2 <= 0;
         Grp3 <= 0;
         Grp4 <= 0;
         Grp5 <= 0;
         Grp6 <= 0;
      end

      if(weight == 0) State <= 0;
      else if((State == 0) && (reset == 0)) begin // Platform was empty before this, one of the groups can update
         case(currentGrp)
            1: Grp1 <= Grp1 + 1;
            2: Grp2 <= Grp2 + 1;
            3: Grp3 <= Grp3 + 1;
            4: Grp4 <= Grp4 + 1;
            5: Grp5 <= Grp5 + 1;
            6: Grp6 <= Grp6 + 1;
            default: Grp1 <= Grp1;  // To avoid a latch. I'm not sure what would be best to put in this default, unreachable anyways
         endcase
         State <= currentGrp;
      end else State <= currentGrp;
   end

   always @(weight) begin
      if(weight > 2000) currentGrp = 6;
      else if(weight > 1000) currentGrp = 5;
      else if(weight > 800) currentGrp = 4;
      else if(weight > 500) currentGrp = 3;
      else if(weight > 200) currentGrp = 2;
      else if(weight > 0) currentGrp = 1;
      else currentGrp = 0;
   end
endmodule