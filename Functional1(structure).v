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
// CREATED		"Wed Feb  5 09:07:20 2020"

module Functional1(
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

not(o1,A1);
not(o2,B1);
not(o3,I1);
not(o4,I0);
and(o5,o1,o2,I1);
and(o6,o1,B1,I0);
and(o7,A1,B1,o4);
and(o8,A1,o3,I0);
or(F2,o6,o7,o8,o5);

not(o9,A0);
not(o10,B0);
not(o11,I1);
not(o12,I0);
and(o13,o9,o10,I1);
and(o14,o9,B0,I0);
and(o15,A0,B0,o12);
and(o16,A0,o11,I0);
or(F1,o14,o15,o16,o13);

endmodule