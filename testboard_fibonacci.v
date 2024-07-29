`timescale 1ns / 1ps

module testboard_fibonacci(next_instr, Flags, lcd1, lcd2, lcd3, lcd4, lcd6);

	input next_instr;
	
	output [6:0] lcd1, lcd2, lcd3, lcd4, lcd6;
	output wire [4:0] Flags;
	
	wire [15:0] C;
	
	reg[15:0] i;
	reg reset = 1;
	reg[15:0] counter = -2; //For debugging only
	reg clock = 0;
	
	FSM uut
	(
		.rst(reset), 
		.clk(next_instr), 
		.FullOp(i), 
		.Flags(Flags), 
		.aluOutput(C),
		.imm(counter)
	);
	hexTo7Seg seg1(C[3:0], lcd1);
	hexTo7Seg seg2(C[7:4], lcd2);
	hexTo7Seg seg3(C[11:8], lcd3);
	hexTo7Seg seg4(C[15:12], lcd4);
	
	
	hexTo7Seg seg6(counter, lcd6);
	
	
	
	//always #5 clock = ~clock;
	
	always@(posedge next_instr)
		begin
			counter = counter + 1; //For debugging only
				case(counter)
				
				
				//ADDI
				0:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				1:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				2:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				3:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				4:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				5:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				6:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				7:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				8:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				9:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
						end
				10:begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				
				/*
				
				//ADDI
				0:	begin
						i = 16'b0101000000000000; //ADDI R0, imm
					end
				1:	begin
						i = 16'b0101000100000000; //ADDI R1, imm
					end
				//ADD
				2:	begin
						i = 16'b0000001001010000; //ADD R2, R0
					end
				3:	begin
						i = 16'b0000001001010001; //ADD R2, R1
					end
				4:	begin
						i = 16'b0000001101010001; //ADD R3, R1
					end
				5:	begin
						i = 16'b0000001101010010; //ADD R3, R2
					end
				6:	begin
						i = 16'b0000010001010010; //ADD R4, R2
					end
				7:	begin
						i = 16'b0000010001010011; //ADD R4, R3
					end
				8:	begin
						i = 16'b0000010101010011; //ADD R5, R3
					end
				9:	begin
						i = 16'b0000010101010100; //ADD R5, R4
					end
				10:begin
						i = 16'b0000011001010100; //ADD R6, R4
					end
				11:begin
						i = 16'b0000011001010101; //ADD R6, R5
					end
				12:	begin
						i = 16'b0000011101010101; //ADD R7, R5
					end
				13:begin
						i = 16'b0000011101010110; //ADD R7, R6
					end
				14:	begin
						i = 16'b0000100001010110; //ADD R8, R6
					end
				15:begin
						i = 16'b0000100001010111;
					end
				16:	begin
						i = 16'b0000100101010111;
					end
				17:begin
						i = 16'b0000100101011000;
					end
				18:begin
						i = 16'b0000101001011000;
					end
				19:begin
						i = 16'b0000101001011001;
					end
				20:begin
						i = 16'b0000101101011001;
					end
				21:begin
						i = 16'b0000101101011010;
					end
				22:begin
						i = 16'b0000110001011010;
					end
				23:begin
						i = 16'b0000110001011011;
					end
				24:begin
						i = 16'b0000110101011011;
					end
				25:begin
						i = 16'b0000110101011100;
					end
				26:begin
						i = 16'b0000111001011100;
					end
				27:begin
						i = 16'b0000111001011101;
					end
				28:begin
						i = 16'b0000111101011101;
					end
				29:begin
						i = 16'b0000111101011110;
					end
					*/
				default:begin
						i = 16'b0000000000000000; 
						#1
						reset = 0;
					end
			endcase
		end

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

