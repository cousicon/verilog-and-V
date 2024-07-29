`timescale 1ns / 1ps

module register(clk, write, EnableWrite, read, rst);

	input [15:0] write;
	input clk, rst, EnableWrite;
	output wire [15:0] read;
	
	reg [15:0] register;
	
	
	assign read = register;
	

	always @(posedge clk, posedge rst)
	begin
		if(rst)
			register = 0;
		else if(EnableWrite)
			register = write;
	end
	
endmodule
