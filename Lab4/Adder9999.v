//Adds the 4 digit BCD value {Q1, Q2, Q3, Q4} and the binary value binVal and stores result in {D1, D2, D3, D4}
//Max value of 9999 for the sum
module Adder9999(S1, S2, S3, S4, Q1, Q2, Q3, Q4, binVal, Load);
input [3:0] Q1, Q2, Q3, Q4;
input [13:0] binVal;
input Load;
output reg [3:0] S1, S2, S3, S4;
integer i;

reg [3:0] thousand, hundred, ten, one;

reg [14:0] binSum;

// convert it to BCD
always @ (posedge Load) begin
   // Adds the two numbers clips the sum
   binSum = (((Q1) + (Q2 * 10) + (Q3 * 100) + (Q4 * 1000) + binVal) > 9999) ? 9999 : ((Q1) + (Q2 * 10) + (Q3 * 100) + (Q4 * 1000) + binVal);
   thousand = 0;
   hundred = 0;
   ten = 0;
   one = 0;

   for(i = 13; i >=0; i = i - 1) begin
      if(thousand >= 5) begin
         thousand = thousand + 3;
      end
      if(hundred >= 5) begin
         hundred = hundred + 3;
      end
      if(ten >= 5) begin
         ten = ten + 3;
      end
      if(one >= 5) begin
         one = one + 3;
      end
      
      thousand = thousand << 1;
      thousand[0] = hundred[3];
      hundred = hundred << 1;
      hundred[0] = ten[3];
      ten = ten << 1;
      ten[0] = one[3];
      one = one << 1;
      one[0] = binSum[i];
      S4 = thousand;
      S3 = hundred;
      S2 = ten;
      S1 = one;
   end
end

endmodule

