// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Wed Jan 22 10:38:20 2020"

module TwoBitComputer(
	A1,
	B1,
	I1,
	I0,
	A0,
	B0,
	F1,
	F2
);


input wire	A1;
input wire	B1;
input wire	I1;
input wire	I0;
input wire	A0;
input wire	B0;
output wire	F1;
output wire	F2;


assign F2 = ~A1 & ~B1 & I1 | ~A1 & B1 & I0 | A1 & B1 & ~I0 | A1 & ~I1 & I0;
assign F1 = ~A0 & ~B0 & I1 | ~A0 & B0 & I0 | A0 & B0 & ~I0 | A0 & ~I1 & I0;


//wire	SYNTHESIZED_WIRE_0;
//wire	SYNTHESIZED_WIRE_1;
//wire	SYNTHESIZED_WIRE_2;
//wire	SYNTHESIZED_WIRE_3;
//wire	SYNTHESIZED_WIRE_4;
//wire	SYNTHESIZED_WIRE_5;
//wire	SYNTHESIZED_WIRE_6;
//wire	SYNTHESIZED_WIRE_7;
//wire	SYNTHESIZED_WIRE_8;
//wire	SYNTHESIZED_WIRE_9;
//wire	SYNTHESIZED_WIRE_10;
//wire	SYNTHESIZED_WIRE_11;
//wire	SYNTHESIZED_WIRE_12;
//wire	SYNTHESIZED_WIRE_13;
//wire	SYNTHESIZED_WIRE_14;
//wire	SYNTHESIZED_WIRE_15;
//wire	SYNTHESIZED_WIRE_16;
//wire	SYNTHESIZED_WIRE_17;
//wire	SYNTHESIZED_WIRE_18;
//wire	SYNTHESIZED_WIRE_19;
//wire	SYNTHESIZED_WIRE_20;
//wire	SYNTHESIZED_WIRE_21;
//wire	SYNTHESIZED_WIRE_22;
//wire	SYNTHESIZED_WIRE_23;
//
//
//
//
//assign	SYNTHESIZED_WIRE_12 = A1 & B1;
//
//assign	SYNTHESIZED_WIRE_8 = SYNTHESIZED_WIRE_0 & SYNTHESIZED_WIRE_1 & SYNTHESIZED_WIRE_2;
//
//assign	SYNTHESIZED_WIRE_11 = SYNTHESIZED_WIRE_3 & SYNTHESIZED_WIRE_4 & I0;
//
//assign	SYNTHESIZED_WIRE_13 =  ~I1;
//
//assign	SYNTHESIZED_WIRE_14 =  ~I0;
//
//assign	SYNTHESIZED_WIRE_16 =  ~I1;
//
//assign	SYNTHESIZED_WIRE_18 =  ~I0;
//
//assign	SYNTHESIZED_WIRE_19 =  ~A1;
//
//assign	SYNTHESIZED_WIRE_0 = A0 & B0;
//
//assign	SYNTHESIZED_WIRE_9 = SYNTHESIZED_WIRE_5 & I1 & SYNTHESIZED_WIRE_6;
//
//assign	SYNTHESIZED_WIRE_10 = SYNTHESIZED_WIRE_7 & I1 & I0;
//
//assign	F2 = SYNTHESIZED_WIRE_8 | SYNTHESIZED_WIRE_9 | SYNTHESIZED_WIRE_10 | SYNTHESIZED_WIRE_11;
//
//assign	SYNTHESIZED_WIRE_3 = B0 | A0;
//
//assign	SYNTHESIZED_WIRE_5 = A0 ~^ B0;
//
//assign	SYNTHESIZED_WIRE_1 =  ~I1;
//
//assign	SYNTHESIZED_WIRE_2 =  ~I0;
//
//assign	SYNTHESIZED_WIRE_4 =  ~I1;
//
//assign	SYNTHESIZED_WIRE_6 =  ~I0;
//
//assign	SYNTHESIZED_WIRE_7 =  ~A0;
//
//assign	SYNTHESIZED_WIRE_20 = SYNTHESIZED_WIRE_12 & SYNTHESIZED_WIRE_13 & SYNTHESIZED_WIRE_14;
//
//assign	SYNTHESIZED_WIRE_23 = SYNTHESIZED_WIRE_15 & SYNTHESIZED_WIRE_16 & I0;
//
//assign	SYNTHESIZED_WIRE_21 = SYNTHESIZED_WIRE_17 & I1 & SYNTHESIZED_WIRE_18;
//
//assign	SYNTHESIZED_WIRE_22 = SYNTHESIZED_WIRE_19 & I1 & I0;
//
//assign	F1 = SYNTHESIZED_WIRE_20 | SYNTHESIZED_WIRE_21 | SYNTHESIZED_WIRE_22 | SYNTHESIZED_WIRE_23;
//
//assign	SYNTHESIZED_WIRE_15 = B1 | A1;
//
//assign	SYNTHESIZED_WIRE_17 = A1 ~^ B1;


endmodule
