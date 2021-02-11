//Jorge Avila Juarez 1001543128
module CLA (
inout AddSub,
input [7:0] A,B,
output [7:0] R,
output Cout,
output OVR);

wire [7:0] p,g,c;

//compute the p for each stage
assign p[7:0] = {A[7]^B[7],A[6]^B[6],A[5]^B[5],A[4]^B[4],A[3]^B[3],A[2]^B[2],A[1]^B[1],A[0]^B[0]};
//compute the g for each stage
assign g[7:0] = {A[7]&B[7],A[6]&B[6],A[5]&B[5],A[4]&B[4],A[3]&B[3],A[2]&B[2],A[1]&B[1],A[0]&B[0]};

assign c[7:0] = {};

assign R[7:0] = {};
endmodule 

/*
module FAbehave (s,cout,a,b,cin);
	input a,b,cin;
	output reg s,cout;
	always @ (a,b,cin)
		{cout,s} = a + b + cin;
endmodule
*/