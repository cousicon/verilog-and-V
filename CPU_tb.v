`timescale 1ns / 1ps

module CPU_tb (Flags, lcd1, lcd2, lcd3, lcd4, lcd6,rst,next_instr);
 
	output [6:0] lcd1, lcd2, lcd3, lcd4, lcd6;
	wire [9:0] Counter;
	input rst,next_instr;
	wire [15:0] aluOutput, bruh, FULLOP;
   output wire [4:0] Flags;
	
	wire [15:0] MEM_OUT, REGA, REGB;
	wire [9:0] ADDRA;
	
CPU uut(
	.clk(next_instr),
	.nextInstruction(Counter),
	.rst(rst),
	.Flags(Flags),
	.OUT(bruh),
	.aluOutput(aluOutput),
	.MEM_OUT(MEM_OUT), 
	.REGA(REGA), 
	.REGB(REGB), 
	.FULLOP(FULLOP),
	.ADDRA(ADDRA)
);

	hexTo7Seg seg1(bruh[3:0], lcd1);
	hexTo7Seg seg2(bruh[7:4], lcd2);
	hexTo7Seg seg3(bruh[11:8], lcd3);
	hexTo7Seg seg4(bruh[15:12], lcd4);
	hexTo7Seg seg5(Counter[3:0], lcd6);


//initial begin
//rst = 1;
//next_instr = 1;
//#500;
//rst = 0;
//end

//always #100 next_instr = ~next_instr;


endmodule

module hexTo7Seg(
		input [3:0]x, 
		output reg [6:0]z
		);
		always @*
			case(x)
				4'b0000 :			//Hexadecimal 0
					z = ~7'b0111111;
  				4'b0001 :			//Hexadecimal 1
					z = ~7'b0000110;
   			4'b0010 :			//Hexadecimal 2
					z = ~7'b1011011;
   			4'b0011 : 			//Hexadecimal 3
					z = ~7'b1001111;
   			4'b0100 : 			//Hexadecimal 4
					z = ~7'b1100110;
   			4'b0101 : 			//Hexadecimal 5
					z = ~7'b1101101;
   			4'b0110 : 			//Hexadecimal 6
					z = ~7'b1111101;
   			4'b0111 :			//Hexadecimal 7
					z = ~7'b0000111;
   			4'b1000 : 			//Hexadecimal 8
					z = ~7'b1111111;
			   4'b1001 : 			//Hexadecimal 9
					z = ~7'b1100111;
				4'b1010 : 			//Hexadecimal A
					z = ~7'b1110111;
				4'b1011 : 			//Hexadecimal B
					z = ~7'b1111100;
				4'b1100 : 			//Hexadecimal C
					z = ~7'b1011000;
				4'b1101 : 			//Hexadecimal D
					z = ~7'b1011110;
				4'b1110 : 			//Hexadecimal E
					z = ~7'b1111001;
				4'b1111 : 			//Hexadecimal F	
					z = ~7'b1110001; 
   			default :
					z = ~7'b0000000;
			endcase
endmodule 