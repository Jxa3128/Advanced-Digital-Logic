module RCAddSub(
	input AddSub, //this is the operation if we want to add or subtract
	input [3:0] A,B, 
	output [3:0] S,
	output [6:0] Hex5, Hex4, Hex3, Hex2, Hex1, Hex0,
	output OVR,
	output Cout);
	wire [3:0] Bb;
	wire [4:0] C;
	
	
	assign Bb[3:0] = {AddSub^B[3],AddSub^B[2],AddSub^B[1],AddSub^B[0]}; 
	assign C[0] = AddSub; //Add 0 for addition, 1 for subtraction assign 
	assign Cout = C[4]; //rename carry out port
	assign OVR = C[4] ^ C[3];
//instantiate the full adder module for each stage of the ripple carry adder
//select add (AddSub=0) or subtract (AddSub=1) operation //declare input ports


	
	FAbehave s0 (S[0], C[1], A[0], Bb[0], C[0]); //stage 0
	FAbehave s1 (S[1], C[2], A[1], Bb[1], C[1]); //stage 1
	FAbehave s2 (S[2], C[3], A[2], Bb[2], C[2]); //stage 2
	FAbehave s3 (S[3], C[4], A[3], Bb[3], C[3]); //stage 3

	BinToSevenSegment d0 (A,Hex5,Hex4); //print A
	BinToSevenSegment d1 (B,Hex3,Hex2); //print B 
	BinToSevenSegment d2 (S,Hex1,Hex0); //print Result
endmodule


module FAbehave (
	output reg s,cout,
	input a,b,cin);
	always @ (a,b,cin)
		{cout,s} = a + b + cin;
endmodule

module BinToSevenSegment (
	input [3:0] value,
	output reg [6:0] left, right);
		always @ (value) begin
		case (value)
		
				4'b0000: begin left = 7'b1111111; right = 7'b1000000; end  //0
				
            4'b0001: begin left = 7'b1111111; right = 7'b1111001; end  //1
				
            4'b0010: begin left = 7'b1111111; right = 7'b0100100; end  //2
				
            4'b0011: begin left = 7'b1111111; right = 7'b0110000; end  //3
				
            4'b0100: begin left = 7'b1111111; right = 7'b0011001; end  //4
				
            4'b0101: begin left = 7'b1111111; right = 7'b0010010; end  //5
				
            4'b0110: begin left = 7'b1111111; right = 7'b0000010; end  //6
				
            4'b0111: begin left = 7'b1111111; right = 7'b1111000; end  //7
				
            4'b1000: begin left = 7'b0111111; right = 7'b0000000; end  //-8
				
            4'b1001: begin left = 7'b0111111; right = 7'b1111000; end  //-7
				
            4'b1010: begin left = 7'b0111111; right = 7'b0000010; end  //-6
				
            4'b1011: begin left = 7'b0111111; right = 7'b1110010; end  //-5
				
            4'b1100: begin left = 7'b0111111; right = 7'b0011001; end  //-4
				
            4'b1101: begin left = 7'b0111111; right = 7'b0110000; end  //-3
				
            4'b1110: begin left = 7'b0111111; right = 7'b0100100; end  //-2
				
            4'b1111: begin left = 7'b0111111; right = 7'b1111001; end  //-1
		
		endcase 
	end
endmodule 


/*
module bin2sev (
	input [3:0] BIN,
	output reg [0:6] SEV);
	always @ (BIN) 
		case ({BIN[3:0]})
			4'b0000: (SEV{0:6]) = 7'b00000001;
			endcase
endmodule
*/

/*
4'b0000: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010000001; //0
		
		4'b0001: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000011001111; //1
		
		4'b0010: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010010010; //2
		
		4'b0011: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010000110; //3
		
		4'b0100: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000011001100; //4
		
		4'b0101: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010100100; //5
		
		4'b0110: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010100000; //6
		
		4'b0111: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010001111; //7
		
		4'b1000: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b11111100000000; //-8
		
		4'b1001: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b11111100001111; //-7
		
		4'b1010: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b11111100100000; //-6
		
		4'b1011: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b11111100100100; //-5
		
		4'b1100: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b11111101001100; //-4
		
		4'b1101: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b11111100000110; //-3
		
		4'b1110: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b11111100010010; //-2
		
		4'b1111: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b11111101001111; //-1
		*/