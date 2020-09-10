module BinaryToSevenSegment(input [3:0]character,
									 output [6:0]segmentData // Includes a decimal place. A-G and Dec, A at index 0.
									 );
									 
	parameter A = 3'h_0;
	parameter B = 3'h_1;
	parameter C = 3'h_2;
	parameter D = 3'h_3;
	parameter E = 3'h_4;
	parameter F = 3'h_5;
	parameter G = 3'h_6;
	//parameter Dec = 3'h_7;
	
	assign segmentData[A] = character == 0 | character == 2 | character == 3 | character == 5 | character == 6 | character == 7 | character == 8 | character == 9 | character == 10 | character == 14 | character == 15;
	assign segmentData[B] = character == 0 | character == 1 | character == 2 | character == 3 | character == 4 | character == 7 | character == 8 | character == 9 | character == 10 | character == 13;
	assign segmentData[C] = character == 0 | character == 1 | character == 3 | character == 4 | character == 5 | character == 6 | character == 7 | character == 8 | character == 9  | character == 10 | character == 11 | character == 13;
	assign segmentData[D] = character == 0 | character == 2 | character == 3 | character == 5 | character == 6 | character == 8 | character == 9 | character == 11| character == 12 | character == 13 | character == 14;
	assign segmentData[E] = character == 0 | character == 2 | character == 6 | character == 8 | character == 10| character == 11| character == 12| character == 13| character == 14 | character == 15;
	assign segmentData[F] = character == 0 | character == 4 | character == 5 | character == 6 | character == 8 | character == 9 | character == 10| character == 11| character == 14 | character == 15;
	assign segmentData[G] = character == 2 | character == 3 | character == 4 | character == 5 | character == 6 | character == 8 | character == 9 | character == 10| character == 11 | character == 12 | character == 13 | character == 14 | character == 15;
	//assign segmentData[Dec] = 0;

endmodule