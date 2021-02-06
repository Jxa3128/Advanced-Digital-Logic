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
	input Clock50, //clock_50
	output [9:0] LEDRArray); //the 10 LEDR

	wire clock_toggle;
	wire clock_final;
	reg direction = 0; //direction where it will start
	wire [3:0] ledNumber;

	ToggleLatch toggy (OnOff,Clock50,clock_toggle);
	
	divideX d(clock_toggle,clock_final);
	
	UpDownCounter udc(clock_final,direction,OnOff,ledNumber);
	
	always @ (ledNumber)
		begin
			if(ledNumber <= 1)
			  direction = 0;
			if(ledNumber >= 9)
				direction = 1;
		end
		
	decoder2N d2n(ledNumber,clock_toggle,LEDRArray);
	
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
	assign OUT = state&IN; //Out = In when switch in on. Otherwise, Out = 0.
	
endmodule

module divideX (
	input CLK,
	output reg OUT);
	
	parameter N = 5000000;	
	reg [31:0] count;								//32bit register
	
	always @ (negedge CLK)
	begin
		count = count + 1;						//increment 
		if(count >= (N-1))
			count = 0;								//reset counter
		if(count < (N/2)) 	
			OUT = 1;
		else
			OUT=0;
	end
endmodule

module UpDownCounter(
	
	input CLK, UP, clr,
	output reg [N-1:0] COUNT);
	parameter N = 4;
		always @ (posedge CLK, negedge clr)
				if(clr == 0)
					COUNT <= 0; //clear this b
				else
					if (UP == 0)
						COUNT <= COUNT + 1;
					else 
						COUNT <= COUNT - 1;
					
endmodule

//N to 2**N decoder - Bill Carroll's
module decoder2N #(parameter N = 4) 
	(input[N-1:0] in,
	input enable,output[2**N-1:0] out);
	assign out = (enable) ? (1 << in) : 0;
endmodule
