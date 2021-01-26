module BinToSevenSegment (
	input w,x,y,z,
	output reg a,b,c,d,e,f,g,h,i,j,k,l,m,n);
		always @ (w,x,y,z) begin
		case ({w,x,y,z})
		
		4'b0000: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010000001; //0
		
		4'b0001: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000011001111; //1
		
		4'b0010: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010010010; //2
		
		4'b0011: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010000110; //3
		
		4'b0100: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000011001100; //4
		
		4'b0101: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010100100; //5
		
		4'b0110: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010100000; //6
		
		4'b0111: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010001111; //7
		
		4'b1000: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010000000; //8
		
		4'b1001: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010001100; //9
		
		4'b1010: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010001000; //A
		
		4'b1011: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010000001; //b
		
		4'b1100: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010110000; //C
		
		4'b1101: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000011000010; //d
		
		4'b1110: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010110000; //E
		
		4'b1111: {h,i,j,k,l,m,n,a,b,c,d,e,f,g} = 14'b00000010111000; //F
		
		endcase 
	end
endmodule 
