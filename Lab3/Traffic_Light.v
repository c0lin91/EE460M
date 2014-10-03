module TrafficLightController(Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw, Rst, CLK);

   input Rst, CLK;
   output Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw;

   reg [2:0] State;
   reg [3:0] Counter;
   initial begin
      State = 0;
      Counter = 1;
   end

   always @(posedge CLK or Rst) begin
      if(Rst == 1) begin
         State <= 6;
         Counter <= 1;
      end else begin
         case(State)
            0: begin
               if(Counter == 4) begin
                  State <= 1;
                  Counter <= 1;
               end else begin
                  State <= 0;
                  Counter <= Counter + 1;
               end
            end
            1: begin
               if(Counter == 2) begin
                  State <= 2;
                  Counter <= 1;
               end else begin
                  State <= 1;
                  Counter <= Counter + 1;
               end
            end
            2: begin
               if(Counter == 3) begin
                  State <=3;
                  Counter <= 1;
               end else begin
                  State <= 2;
                  Counter <= Counter + 1;
               end
            end
            3: begin
               State <= 4;
               Counter <= 1;
            end
            4: begin
               if(Counter == 2) begin
                  State <= 5;
                  Counter <= 1;
               end else begin
                  State <= 4;
                  Counter <= Counter + 1;
               end
            end
            5: begin
               if(Counter == 4) begin
                  State <= 0;
                  Counter <= 1;
               end else begin
                  State <= 5;
                  Counter <= Counter + 1;
               end
            end
            6: begin    // Returning from maintenance mode, put back in state 0
               State <= 0;
               Counter <= 1;
            end
            default: begin
               State <= State;
               Counter <= Counter;
            end
         endcase
      end
   end

   assign Ga = (State == 0);
   assign Ya = (State == 1);
   // A is Red on states 2, 3, 4, and 5. Blinks on 6.
   assign Ra = (((State > 1) && (State < 6)) || ((State == 6) && (CLK == 0)));
   assign Gb = (State == 2);
   assign Yb = (State == 3);
   // B is Red on states 1, 2, 4, and 5. Blinks on 6.
   assign Rb = (((State != 2) && (State !=3) && (State != 6)) || ((State == 6) && (CLK == 0)));
   assign Gw = (State == 4);
   // W is Red on states 1, 2, and 3. Blinks on 5 and 6
   assign Rw = ((State < 4) || ((State > 4) && (CLK == 0)));
endmodule

