// Claude Garrett V, 8/27/2020

module HHMM24HourClock(input clock_1MHz,
							  input [23:0]setTime, // 4 top bits are for hours (0-31), bottom 5 are for minutes (0-63).
							  input reset,
							  output [6:0]displayOutput,
							  output [3:0]select
							  );
	
	parameter CyclesPerSec = 1000000;
	
	// Settings Registers:
	reg _12_24;
	
	// Time Registers:
	reg [3:0]hourTens;
	reg [3:0]hourOnes;
	reg [3:0]minTens;
	reg [3:0]minOnes;
	reg [3:0]secTens;
	reg [3:0]secOnes;
	reg [19:0]cycles;
	
	//module QuadSevenSegmentController(input clock, input [15:0]count, output reg [6:0]displayOutput, output reg [3:0]select );
	QuadSevenSegmentController clockToQuad7(cycles[10], // Currently alternates between the 7 segments every 1/64 seconds.
														 {minTens, minOnes, secTens, secOnes},
														 displayOutput, 
														 select
														 );
	
	initial begin
		_12_24 = 1'b_0;
		hourTens = setTime[23:20];
		hourOnes = setTime[19:16];
		minTens = setTime[15:12];
		minOnes = setTime[11:8];
		secTens = setTime[7:4];
		secOnes = setTime[3:0];
	end
	
	always @ (posedge clock_1MHz) begin
		if(reset) begin
			hourTens <= setTime[23:20];
			hourOnes <= setTime[19:16];
			minTens <= setTime[15:12];
			minOnes <= setTime[11:8];
			secTens <= setTime[7:4];
			secOnes <= setTime[3:0];
		end
	
		cycles = cycles + 1;
		
		if(cycles == CyclesPerSec) begin cycles <= 0; secOnes <= secOnes + 1; end
		
		if(secOnes == 10) begin secOnes <= 0; secTens <= secTens + 1; end
		if(secTens == 6) begin secTens <= 0; minOnes <= minOnes + 1; end
		
		if(minOnes == 10) begin minOnes <= 0; minTens <= minTens + 1; end
		if(minTens == 6) begin minTens <= 0; hourOnes <= hourOnes + 1; end
		
		if(hourOnes == 10) begin hourOnes <= 0; hourTens <= hourTens + 1; end
		
		
		if(hourTens == 2 && hourOnes == 4 && _12_24 == 1'b_0) begin hourTens <= 0; hourOnes <= 0; end // Reset hours to 00 at midnight.
		if(hourTens == 1 && hourOnes == 3 && _12_24 == 1'b_1) begin hourTens <= 0; hourOnes <= 1; end // Reset hours to 01 at 1 AM or 1 PM.
		
	end
	
endmodule