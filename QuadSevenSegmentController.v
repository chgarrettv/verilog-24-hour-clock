// Claude Garrett V, 8-12-2020

module QuadSevenSegmentController(input clock,
											 input [15:0]count,
											 output reg [6:0]displayOutput,
											 output reg [3:0]select
											 );
											 
	reg [27:0]segmentData;

	
	BinaryToSevenSegment binTo7 [3:0] (count, segmentData);
	
	initial begin
		segmentData = 28'b_0;
		displayOutput = segmentData[6:0];
		select = 4'b_1110;
	end
	
	always @ (posedge clock) begin
		case(select)
			4'b_1110: begin 
				select = 4'b_1101;
				displayOutput = segmentData[13:7];
				end
			4'b_1101: begin
				select = 4'b_1011;
				displayOutput = segmentData[20:14];
				end
			4'b_1011: begin
				select = 4'b_0111;
				displayOutput = segmentData[27:21];
				end
			4'b_0111: begin
				select = 4'b_1110;
				displayOutput = segmentData[6:0];
				end
				
			default: begin
				select = 4'b_1110;
				displayOutput = segmentData[6:0];
				end
		endcase
	end
	
endmodule