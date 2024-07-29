`timescale 1ns / 1ps

module mux(imm, Rin, ctrl, enable, out);

	input [15:0] imm, Rin;
	input ctrl, enable;
	output reg [15:0] out;
	
	always@(imm, Rin, ctrl, enable)
	begin
		if(ctrl)
			out <= Rin;
		else
			out <= imm;
	end
	
endmodule
