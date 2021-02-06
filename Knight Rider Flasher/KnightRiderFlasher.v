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
	
	
	
	
	
	input OnOff, //key1
	input ClockKey, //clock_50
	output [9:0] LEDRArray); //the 10 LEDR


	//input wires from the schematic
	wire divisor;
	wire en;
	wire [3:0] bufferCounter;
	
	ToggleLatch tl (OnOff, ClockKey, en);
	
	//CLOCK_50 && Divisor Input 
	// this tells me if it is a 1 or a 0
	//since we need an output every 10 clocks
	
	//call it 3 diff times for the report
	divideX4_5 fn1 (ClockKey,divisor);
	//divideX9 fn1 (ClockKey,divisor);
	//divideX18 fn1 (ClockKey,divisor);
	
	
	//decade counter is called
	DecadeUpDown DU1 (divisor, OnOff, leftRight, bufferCounter);
	
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
	input OnOff, IN,
	output OUT);
	
	reg state, nextstate;
	parameter ON= 1, OFF= 0;
	
		always @ (negedge OnOff)
			state <= nextstate;
		always @ (state) 
				case(state)
					OFF: nextstate = ON;
					ON: nextstate = OFF;
					//CLR turns the switch off.
					//Pushing OnOff turns the switch on. //Pushing OnOff turns the switch off.
					endcase
	assign OUT = state*IN; //Out = In when switch in on. Otherwise, Out = 0.
	
endmodule

//twice per second
module divideX4_5 ( 
	
	input CLK,
	output reg OUT);
	parameter N= 2500000; //(50e6/10LED)/2
		reg [31:0] COUNT;
		always @ (negedge CLK)
			begin
			if (COUNT == N-2) 
				begin 
					OUT <= 1; 
					COUNT <= N-1; end 
			else
			if (COUNT == N-1) 
				begin 
					OUT <=1'b0; 
					COUNT <= 0; end 
			else 
				begin 
					OUT <= 0; 
					COUNT <= COUNT + 1; end 
			end 
endmodule 

// once per second
module divideX9 ( 
	
	input CLK,
	output reg OUT);
	parameter N= 5000000; //(50e6)/10LEDR
		reg [31:0] COUNT;
		always @ (negedge CLK)
			begin
			if (COUNT == N-2) 
				begin 
					OUT <= 1; 
					COUNT <= N-1; end 
			else
			if (COUNT == N-1) 
				begin 
					OUT <=1'b0; 
					COUNT <= 0; end 
			else 
				begin 
					OUT <= 0; 
					COUNT <= COUNT + 1; end 
			end 
endmodule 

// once per twice a second
module divideX18 ( 
	
	input CLK,
	output reg OUT);
	parameter N= 100000000; //(50e6/10LED)*2
		reg [31:0] COUNT;
		always @ (negedge CLK)
			begin
			if (COUNT == N-2) 
				begin 
					OUT <= 1; 
					COUNT <= N-1; end 
			else
			if (COUNT == N-1) 
				begin 
					OUT <=1'b0; 
					COUNT <= 0; end 
			else 
				begin 
					OUT <= 0; 
					COUNT <= COUNT + 1; end 
			end 
endmodule 