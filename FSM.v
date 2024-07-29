`timescale 1ns / 1ps

module FSM(rst, clk, FullOp, Flags, aluOutput, imm, Rdest, Rsrc, TriCount, Write, ctrlMuxB, WRITEBACK);

	input rst, clk, Write;
	input [7:0] FullOp;
	input [15:0] imm;
	input [3:0] Rdest, Rsrc;
	input [15:0] WRITEBACK;

	output wire [15:0] aluOutput;
	output [4:0] Flags;
	
	wire [15:0] MuxBout, regfileA, regfileB;
	reg ctrlMuxB;
	
	integer TriCount;
	
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
	parameter CMPU = 8'b00001101;    // using MOV OP code for CMPU
	parameter AND = 8'b00000001;
	parameter OR = 8'b00000010;
	parameter XOR = 8'b00000011;
	parameter NOT = 8'b00100000;	 	// usign ORI OP code for NOT
	parameter LSH = 8'b10000100;
	parameter LSHI = 8'b1000000x;
	parameter RSH = 8'b00001010;     // using SUBC and SUBCI op codes for RSH and RSHI
	parameter RSHI = 8'b1010000;
	parameter ALSH = 8'b10000110;		// using ASHU AND ASHUI op codes for ALSH and ARSH
	parameter ARSH = 8'b10000010;
	parameter WAIT = 8'b00000000;
	
	parameter LOAD = 8'b01000000;
	parameter STORE = 8'b01000100;
	
	ALU_16 ALU(
				  .A(regfileA), 
				  .B(MuxBout), 
				  .C(aluOutput),
				  .Opcode(FullOp), 
				  .Flags(Flags)
				  );
					
	regfile RegFile(
						.Rdest(Rdest),
						.Rsrc(Rsrc),
						.EnableWrite(Write),
						.A(regfileA),
						.B(regfileB),
						.write(WRITEBACK),
						.rst(rst),
						.clk(clk)
						);
							
	mux muxB(
		  .imm(imm), 
		  .Rin(regfileB), 
		  .ctrl(ctrlMuxB),
		  .out(MuxBout)
		  );
			

endmodule


