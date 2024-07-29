`timescale 1ns / 1ps

module CPU(clk, nextInstruction, rst, Flags, OUT, aluOutput, MEM_OUT, REGA, REGB, ADDRA, FULLOP);

	reg [15:0] data_a, data_b, imm, NextIns, WRITEBACK, FullOp;
	reg [9:0] addr_a, addr_b, ProgramCounter;
	output[9:0] nextInstruction;
	reg we_a, we_b, WriteReg;
	input clk, rst;
	wire [15:0] q_b, q_a;
	output [15:0] OUT, aluOutput;
	output wire [4:0] Flags;
	
	reg [3:0] Rsrc, Rdest;
	
	wire [15:0] MuxBout, regfileA, regfileB;
	reg ctrlMuxB;
	
	reg[1:0] TriCount;
	
	reg[4:0] JcondFlags;
	
	output [15:0] MEM_OUT, REGA, REGB, FULLOP;
	output [9:0] ADDRA;
	
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
	
	parameter JAL = 8'b01001000;
	parameter JCOND = 8'b01001100;

mem_lab mem
(
	.data_a(data_a),
	.data_b(data_b),
	.addr_a(addr_a),
	.addr_b(addr_b),
	.we_a(we_a),
	.we_b(we_b),
	.clk(clk),
	.q_a(q_a),
	.q_b(q_b)
);


    ALU_16 ALU(
				  .A(regfileA), 
				  .B(MuxBout), 
				  .C(aluOutput),
				  .Opcode({FullOp[15:12], FullOp[7:4]}), 
				  .Flags(Flags)
				  );
					
	regfile RegFile(
						.Rdest(Rdest),
						.Rsrc(Rsrc),
						.EnableWrite(WriteReg),
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
		  .enable(1'b1),
		  .out(MuxBout)
		  );

assign nextInstruction = ProgramCounter;
assign OUT = WRITEBACK;
assign ADDRA = addr_a;
assign MEM_OUT = q_a;
assign REGA = regfileA;
assign REGB = MuxBout;
assign FULLOP = FullOp;

always@(posedge clk, posedge rst)
		begin
		
		
		if(rst) begin
		imm = 0;
		FullOp = 16'b0;
		
	   addr_a = 10'b0;
		data_a = 16'bx;
		we_a = 0;
		
		addr_b = 10'bx;
		data_b = 16'bx;
		we_b = 0;
		
		ProgramCounter= -1;
		WriteReg = 0;
	   Rsrc = 4'b0;
		Rdest = 4'b0;
		
	   ctrlMuxB = 1;
	   TriCount = -1;
		NextIns = 16'b0;
		WRITEBACK = 16'b0;
		
		end
		
		else begin
		
		TriCount = TriCount + 1;
		
			case(TriCount)
			
			0: begin // decode
			WriteReg = 0;
			
			FullOp = NextIns;

			Rdest = FullOp[11:8];
			Rsrc  = FullOp[3:0];
			
			case(FullOp[7:4])
			
			4'b0: begin
				//imm = FullOp[3:0];
				imm = 5;
				ctrlMuxB = 0;
			end
			
			default: begin
				ctrlMuxB = 1;
			end
			
			endcase
			
			case({FullOp[15:12],FullOp[7:4]})
			
			JAL: begin
				addr_a = regfileB;
				we_a = 0;
			end
			
			JCOND: begin
			
				case(JcondFlags[3])
				
				0: begin
					addr_a = regfileB;
					we_a = 0;
				end
				
				
				1: begin
					ProgramCounter = ProgramCounter + 1;
					addr_a = ProgramCounter;
					we_a = 0;
				end
				
				endcase
				
			end
			
			default: begin
			ProgramCounter = ProgramCounter + 1;
			addr_a = ProgramCounter;
			we_a = 0;
			end
			
			endcase
			
			end
			
			1: begin
			
			case({FullOp[15:12],FullOp[7:4]})
			
				CMP, CMPI, CMPU: begin
					JcondFlags = Flags;
				end
			
				LOAD: begin
					addr_a = regfileB;
					we_a = 0;
				end
				
				JAL, JCOND: begin
					we_a = 0;
				end
			
				default: begin
			end
			
			endcase

			NextIns = q_a;
			
			end
			2: begin
			
			case({FullOp[15:12],FullOp[7:4]})
			
			STORE:
			begin
				data_a = regfileB;
				addr_a = regfileA;
		   	we_a = 1;
				WriteReg = 0;
				WRITEBACK = regfileB;
			end
			
			CMP, CMPI, CMPU, WAIT:
			begin
				WriteReg = 0;
				WRITEBACK = 0;
			end
			
			LOAD: begin
				WRITEBACK = q_a;
				WriteReg = 1;
				TriCount = TriCount - 1;
			end
			
			JAL: begin
				WRITEBACK = ProgramCounter;
				WriteReg = 1;
				ProgramCounter = regfileB;
			end
			
			JCOND: begin
				WRITEBACK = ProgramCounter;
				WriteReg = 0;
				ProgramCounter = regfileB;
			end
			
			default:
			begin
				WRITEBACK = aluOutput;
				WriteReg = 1;
			end
			
			endcase
			
			TriCount = -1;
			
			end
			
			default: begin
			end
			
			endcase
			
		end
	end
		
		
endmodule 
		
