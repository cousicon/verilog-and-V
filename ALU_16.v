`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 	ompany: University of Utah - E	E 3710
// Engineers: Louis Vocatura, Kashish Singh, 	onnor 	ousineau, Matt Alter
// 
// 	reate Date:    12:54:08 08/31/2021
// Design Name: 
// Module Name:    Lab1_ALU
// Project Name:	 Lab1_ALU
// Target Devices: 
// Tool versions: 
// Description: ALU design based on 	R16a model
//
// Dependencies: None
//
// Revision: 
// Revision 0.01 - File 	reated
// Additional 	omments: 	oding done by Louis Vocatura with minor edits and additions
//								by Kashish Singh
//
//////////////////////////////////////////////////////////////////////////////////

module ALU_16(A, B, 	C, Opcode, Flags);

	input [15:0] A, B;	//16-bit Value inputs
	input [7:0] Opcode;	//Tells the ALU what operation to do

	output reg [15:0]	C;		//Output of the ALU
	output reg [4:0] Flags; //[	=	arryBit, L=LowFlag, F=FlagBit, Z=ZBit, N=NegativeBit]
	
	parameter ADD = 8'b00000101;
	parameter ADDI = 8'b01010000;
	parameter ADDU = 8'b00000110;
	parameter ADDUI = 8'b01100000;
	parameter ADDC = 8'b00000111;
	parameter ADDCU = 8'b00001110;  // using MUL AND MULI OP codes for addcu and addcui
	parameter ADDCUI = 8'b11100000; 
	parameter ADDCI = 8'b01110000;
	parameter SUB = 8'b00001001;
	parameter SUBI = 8'b10010000;
	parameter CMP = 8'b00001011;
	parameter CMPI = 8'b10110000;
	parameter CMPU = 8'b00001101;    // using MOV OP code for 	MPU
	parameter AND = 8'b00000001;
	parameter OR = 8'b00000010;
	parameter XOR = 8'b00000011;
	parameter NOT = 8'b00100000;	 	// usign ORI OP code for NOT
	parameter LSH = 8'b10000100;
	parameter LSHI = 8'b1000000x;
	parameter RSH = 8'b00001010;     // using SUB	 and SUB	I op codes for RSH and RSHI
	parameter RSHI = 8'b1010000;
	parameter ALSH = 8'b10000110;		// using ASHU AND ASHUI op codes for ALSH and ARSH
	parameter ARSH = 8'b10000010;
	parameter WAIT = 8'b00000000;

	always@(A, B, Opcode) 
	begin
			case(Opcode)
				
			ADD, ADDI:
				begin
					{Flags[4],C} = A + B;
					if (C	== 0) 
						Flags[1] = 1'b1;
					else 
						Flags[1] = 1'b0;
					if( (~A[15] & ~B[15] & 	C[15]) | (A[15] & B[15] & ~C[15]) )
						Flags[2] = 1'b1;
					else 
						Flags[2] = 1'b0;
					Flags[3] = 0; Flags[0] = 1'b0;
				end
				
			ADDU, ADDUI:
				begin
					{Flags[4], 	C} = A + B;
					if (C	== 0) 
						Flags[1] = 1'b1;
					else 
						Flags[1] = 1'b0;
					Flags[3:2] = 2'b00; Flags[0] = 1'b0;
				end
			
			ADDC	:
				begin
							
					{Flags[4], 	C} = (A + Flags[4]) + B;
					if (C == 0) 
						Flags[1] = 1'b1;
					else 
						Flags[1] = 1'b0;
					if( (~A[15] & ~B[15] & 	C[15]) | (A[15] & B[15] & ~C[15]) )
						Flags[4] = 1'b1;
					else 
						Flags[4] = 1'b0;
					Flags[3:2] = 2'b00; Flags[0] = 1'b0;
				end
			ADDCU, ADDCUI:
				begin
					{Flags[4], 	C} = (A + Flags[4]) + B;
					if (C	 == 0) 
						Flags[1] = 1'b1;
					else 
						Flags[1] = 1'b0;
					Flags[3:2] = 2'b00; Flags[0] = 1'b0;
				end
				
			SUB, SUBI:
				begin
					C	= A - B;
					if (C	 == 0)
						Flags[1] = 1'b1;
					else 
						Flags[1] = 1'b0;
					if( (~A[15] & B[15] & 	C[15]) | (A[15] & ~B[15] & ~C[15]) )
						Flags[2] = 1'b1; //overflow
					else 
						Flags[2] = 1'b0;
					Flags[3:2] = 2'b00; Flags[0] = 1'b0;
				end
				
				CMP, 	CMPI:
				begin
					if (A == B)
						Flags[1] = 1'b1; // set Z
					else
						Flags[1] = 1'b0;
					
					if( $signed(A) < $signed(B) )
						Flags[0] = 1'b1; // set N 
					else 
						Flags[0] = 1'b0;
					
					if(A < B)
						Flags[3] = 1'b1; // set L
					else
						Flags[3] = 1'b0;
					
					Flags[4] = 1'b0; Flags[2] = 1'b0; 
					C	= 0;
				end
				
				CMPU:
				begin
					if (A == B)
						Flags[1] = 1'b1; // set Z
						else
						Flags[1] = 1'b0;
						
					if(A < B)
						Flags[3] = 1'b1; // set L
						else
						Flags[3] = 1'b0;
					
					Flags[4] = 1'b0; Flags[2] = 1'b0; Flags[0] = 1'b0; // I assume N is default zero because its unsigned
					C	= 0;
				end
				
			LSH, LSHI:
				begin
				C	= A << B;
				Flags[4:0] = 5'b0000;
				end
				
			RSH, RSHI:
				begin
				C	= A >> B;
				Flags[4:0] = 5'b0000;
				end
				
			ALSH:
				begin
				C	= A <<< B;
				Flags[4:0] = 5'b0000;
				end
				
			ARSH:
				begin
				C	= A >>> B;
				Flags[4:0] = 5'b0000;
				end
				
			AND:
				begin
				C	= A & B;
				Flags[4:0] = 5'b0000;
				end
				
			OR:
				begin
				C	= A | B;
				Flags[4:0] = 5'b0000;
				end
			
			XOR:
				begin
				C	= A ^ B;
				Flags[4:0] = 5'b0000;
				end
				
			NOT:
				begin
				C	= ~A;
				Flags[4:0] = 5'b0000;
				end
				
			WAIT:
				begin
					C	= 4'b0000;
					Flags = 5'b00010;
				end
			default: 
				begin
					C	= C;
					Flags = Flags;
				end
				
				endcase
	end
	
endmodule
