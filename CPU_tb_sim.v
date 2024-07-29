module CPU_tb_sim (Flags, aluOutput);


	reg next_instr;
	wire [9:0] Counter;
	integer counter;
	wire rst;
	output wire [15:0]aluOutput;
	wire [15:0] FullOp;
   output wire [4:0] Flags;
	
	
CPU uut(
	.clk(next_instr),
	.nextInstruction(Counter),
	.rst(rst),
	.Flags(Flags),
	.FullOp(FullOp),
	.aluOutput(aluOutput)
);

always@(next_instr) begin
	#100
	next_instr = ~next_instr;
end

endmodule

