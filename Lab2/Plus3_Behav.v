module Plus3_Behav(X, CLK, S, V);
input X, CLK;
output S, V;
reg [2:0] State;

initial
begin
   State = 0;
end

always @(posedge CLK)
begin
   case(State)
      0: begin
            if(X == 1'b0) State <= 1;
            else State <= 2;
         end
      1: begin
            if(X == 1'b0) State <= 3;
            else State <= 4;
         end
      2: State <= 4;
      3: State <= 5;
      4: begin
            if(X == 1'b0) State <= 5;
            else State <= 6;
         end
      5: State <= 0;
      6: State <= 0;
   endcase
end

assign S = ((State == 0 && X == 0) || (State == 1 && X == 0)
            || (State == 4 && X == 0) || (State == 6 && X == 0)
            || (State == 2 && X == 1) || (State == 3 && X == 1)
            || (State == 5 && X == 1));
            
assign V = (State == 6 && X == 1);

endmodule
