// Claude Garrett V, 8/28/2020

// This will be the clock SPI control state machine.

// Commands:

	// Change/set the time to a new time (input the new time).
	// Change from 12 to 24 hour time.
	// 
	
// Potential Commands:

	// Reset the default time?
	
module HHMM24HourClockController(input clock_1MHz,
											//input reset, // Make this a button in the future.
											output [6:0]displayOutput,
											output [3:0]select
											);
											
	reg [23:0]setTime;
	reg reset;
												
	HHMM24HourClock clockHHMM (clock_1MHz, setTime, reset, displayOutput, select);
	
	initial begin setTime = 24'b_0; reset = 1'b_0; end
	
endmodule
