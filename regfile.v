`timescale 1ns / 1ps

/*
	This is a regfile that has 16 16 bit registers.  It take a write value from the alu output bus, has a clock signal,
	a unique enable signal for each of the registers, and readA and readB that output to the a and b buses for the alu inputs.
*/
module regfile(Rdest, Rsrc, EnableWrite, A, B, write, rst, clk);
					
	input [3:0] Rdest, Rsrc;
	input [15:0] write;
	input EnableWrite, rst, clk;
	
	wire[15:0] readReg [0:15];
	
	wire [15:0] writeEnable;
	
	output wire[15:0] A, B;
	
	
	assign A = readReg[Rdest];
	assign B = readReg[Rsrc];
	assign writeEnable[15:0] = (EnableWrite << Rdest);
	
					
	//Registers
		register R0(.clk(clk), .write(write), .EnableWrite(writeEnable[0]), .read(readReg[0]), .rst(rst));
		register R1(.clk(clk), .write(write), .EnableWrite(writeEnable[1]), .read(readReg[1]), .rst(rst));
		register R2(.clk(clk), .write(write), .EnableWrite(writeEnable[2]), .read(readReg[2]), .rst(rst));
		register R3(.clk(clk), .write(write), .EnableWrite(writeEnable[3]), .read(readReg[3]), .rst(rst));
		register R4(.clk(clk), .write(write), .EnableWrite(writeEnable[4]), .read(readReg[4]), .rst(rst));
		register R5(.clk(clk), .write(write), .EnableWrite(writeEnable[5]), .read(readReg[5]), .rst(rst));
		register R6(.clk(clk), .write(write), .EnableWrite(writeEnable[6]), .read(readReg[6]), .rst(rst));
		register R7(.clk(clk), .write(write), .EnableWrite(writeEnable[7]), .read(readReg[7]), .rst(rst));
		register R8(.clk(clk), .write(write), .EnableWrite(writeEnable[8]), .read(readReg[8]), .rst(rst));
		register R9(.clk(clk), .write(write), .EnableWrite(writeEnable[9]), .read(readReg[9]), .rst(rst));
		register R10(.clk(clk), .write(write), .EnableWrite(writeEnable[10]), .read(readReg[10]), .rst(rst));
		register R11(.clk(clk), .write(write), .EnableWrite(writeEnable[11]), .read(readReg[11]), .rst(rst));
		register R12(.clk(clk), .write(write), .EnableWrite(writeEnable[12]), .read(readReg[12]), .rst(rst));
		register R13(.clk(clk), .write(write), .EnableWrite(writeEnable[13]), .read(readReg[13]), .rst(rst));
		register R14(.clk(clk), .write(write), .EnableWrite(writeEnable[14]), .read(readReg[14]), .rst(rst));
		register R15(.clk(clk), .write(write), .EnableWrite(writeEnable[15]), .read(readReg[15]), .rst(rst));
	
	
endmodule
