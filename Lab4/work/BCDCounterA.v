module BCDCounterA(CLK, D, ENABLE, LOAD, UP, CLR, Q, CO);

input CLK, ENABLE, LOAD, UP, CLR;
input [3:0] D;

output reg CO;
output reg [3:0] Q;

initial begin
	Q <= 4'd0;
	CO <= 1'b0;
end

always @ (posedge CLK) begin
	if(CLR == 1) begin
		if(LOAD == 1 && ENABLE == 1) begin
			Q <= D;
		end
		else if(LOAD == 0 && ENABLE == 1 && UP == 1) begin
			Q <= Q + 4'd1;
			if(Q == 4'd9) begin
				Q <= 4'd0;
				CO <= 1'b1;
			end
			else begin
				CO <= 1'b0;
			end
		end
		else if(LOAD == 0 && ENABLE == 1 && UP == 0) begin
			Q <= Q - 4'd1;
			if(Q == 4'd0) begin
				Q <= 4'd9;
				CO <= 1'b1;
			end
			else begin
				CO <= 1'b0;
			end
		end
	end
	else begin
		Q <= 4'd0;
	end
end

endmodule
