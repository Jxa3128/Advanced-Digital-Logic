//Jorge Avila 
//mavID: 1001543128
//Assignment #2

//This acts as the main code where everything will be called
module KnightRiderFlasher(


	// I will need CLOCK_50 -> PIN_AF14 
	// On/Off Toggle Module
	// Clock Divider 
	// Up/Down Counter 
	// Module Instantiation
	// Pin Assignment -> The 0:9 LEDR on the DE1-Soc board
	
	
	
	
	
//	input OnOff,
//	input ClockKey,
//	output LEDRArray[9:0]);


	input clock, reset, output [0:6] Aout, Bout);
	
	wire [3:0] A,B;
	wire five, ten, k1, k0, sec0, sec1;
	wire [3:0] count5, count10;
	wire [9:0] count100L, count1000M;
	
	//instantiations
	/*
	divideX5 div5
	(
		.CLK(clock),
		.CLEAR(reset),
		.OUT(five),
		.COUNT(count5)
	
	);
	*/

	
endmodule

module BinaryUpDown(
	
	input CLK,CLEAR, UP,
	output reg [N-1:0] COUNT);
	parameter N = 3'd3;
		always @ (posedge CLK, negedge CLEAR)
			if(CLEAR == 0) COUNT <= 0; //clear is active low
			else 
				if(UP == 0)
					COUNT <= COUNT + 1'b1;
				else 
					COUNT <= COUNT + 1'b1;
					
endmodule


//OnOff Toggle Latch. Assumes an normally-on push button switch for OnOff.
module ToggleLatch ( 
	input OnOff, IN, CLR,
	output OUT);
	reg state, nextstate;
	parameter ON=1'b1, OFF=1'b0;
		always @ (negedge OnOff, negedge CLR) //Active-low CLR.
			if (CLR==1'b0) state <= OFF; else state <= nextstate;
				always @ (state) 
					case(state)
						OFF: nextstate = ON;
						ON: nextstate = OFF;
						//CLR turns the switch off.
						//Pushing OnOff turns the switch on. //Pushing OnOff turns the switch off.
					endcase
	assign OUT = state*IN; //Out = In when switch in on. Otherwise, Out = 0.
	
endmodule


// Divide by 1000 counter
module divideX1000 ( 
	
	input CLK, CLEAR,
	output reg [9:0] COUNT,
	output reg OUT);
	parameter N=10'd1000;
		always @ (negedge CLK, negedge CLEAR)
			if (CLEAR==1'b0) COUNT <= 10'b0; 
			else
			begin
				if (COUNT == N-2'd2) begin OUT <= 1'b1; COUNT <= N-1'd1; end // Once COUNT = N-2 OUT = 1
			else
			if (COUNT == N-1'd1) begin OUT <=1'b0; COUNT <= 10'b0; end //Once COUNT = N-1 OUT=0
				else begin OUT <= 1'b0; COUNT <= COUNT + 1'b1; end // COUNT is incremented
			end 
endmodule 

