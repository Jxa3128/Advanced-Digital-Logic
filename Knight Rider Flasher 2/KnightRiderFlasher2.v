//Jorge Avila 
//mavID: 1001543128
//Assignment #2

//This acts as the main code where everything will be called
module KnightRiderFlasher2(


	// I will need CLOCK_50 -> PIN_AF14 
	// On/Off Toggle Module
	// Clock Divider 
	// Up/Down Counter 
	// Module Instantiation
	// Pin Assignment -> The 0:9 LEDR on the DE1-Soc board
	
	
	
	
	
	input OnOff, //key1
	input ClockKey, //clock_50
	output [9:0] LEDRArray); //the 10 LEDR

	
	
	divideX4_5 fn1 (ClockKey,LEDRArray[9]);
	//div6 x (ClockKey,LEDRArray[9]);
	
endmodule

//lets assume this bit is right
module DecadeUpDown(
	
	input CLK, UP,
	output reg [N-1:0] COUNT);
	parameter N = 4'd10;
		always @ (posedge CLK)
				if(UP == 0)
					COUNT <= COUNT + 4'd1;
				else 
					COUNT <= COUNT + 4'd1;
					
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

// Two/Ninth across 50e6/4.5 => 11,111,111.111111112 (2 seconds)
module divideX4_5 ( 
	
	input CLK,
	output reg OUT);
	parameter N=28'd1111111;
		reg [28:0] COUNT;
		always @ (negedge CLK)
			begin
			if (COUNT == N-28'd2) begin OUT <= 1'b1; COUNT <= N-1'd1; end // Once COUNT = N-2 OUT = 1
				else
				if (COUNT == N-1'd1) begin OUT <=1'b0; COUNT <= 10'b0; end //Once COUNT = N-1 OUT=0
					else begin OUT <= 1'b0; COUNT <= COUNT + 1'b1; end // COUNT is incremented
			end 
endmodule 


// One/Ninth across (clock freq/spaces) 50e6/9 => 5,555,555. (1 second)
module divideX9 ( 
	
	input CLK, CLEAR,
	output reg [9:0] COUNT,
	output reg OUT);
	parameter N=24'd55555555;
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

// One/2*Ninth across 50e6/18 => 27,777,777.777777776 (.5 seconds)
module divideX18 ( 
	
	input CLK, CLEAR,
	output reg [9:0] COUNT,
	output reg OUT);
	parameter N=24'd27777777;
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

    
module div6 (
	input clock,
	output reg out);
	parameter N = 3'd6;
	reg [2:0] buffer;
		always @(negedge clock)
			begin
			if(buffer ==N-2'd2) begin out <= 1'b1; buffer <= N-1'd1;end
				else 
				if(buffer==N-1'd1) begin out <= 1'b0; buffer <= 3'b0; end
					else begin out <= 1'b0; buffer <= buffer + 1'b1; end
			
			end
endmodule

