module RCAddSub(
	input AddSub,
	input [3:0] A,B,
	output [3:0] S,
	output Cout);
	wire [3:0] Bb;
	wire [4:0] C;
	
	assign Bb[3:0] = {AddSub^B[3],AddSub^B[2],AddSub^B[1],AddSub^B[0]}; 
	assign C[0] = AddSub; //Add 0 for addition, 1 for subtraction assign 
	assign Cout = C[4]; //rename carry out port
//instantiate the full adder module for each stage of the ripple carry adder
//select add (AddSub=0) or subtract (AddSub=1) operation //declare input ports
FAbehave s0 (S[0], C[1], A[0], Bb[0], C[0]); 
FAbehave s1 (S[1], C[2], A[1], Bb[1], C[1]); 
FAbehave s2 (S[2], C[3], A[2], Bb[2], C[2]); 
FAbehave s3 (S[3], C[4], A[3], Bb[3], C[3]);
endmodule


module FAbehave (s,cout,a,b,cin);
	input a,b,cin;
	output reg s,cout;
	always @ (a,b,cin)
		{cout,s} = a + b + cin;
endmodule
