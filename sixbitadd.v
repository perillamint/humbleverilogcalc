`ifndef _sixbitadd_incl
`define _sixbitadd_incl

`include "fulladder.v"

module sixbitadd (a, b, sum, overflow);
	input[5:0] a;
	input[5:0] b;
	output[5:0] sum;
	output overflow;

	wire[5:0] carry;

	fulladder fad1 (a[0], b[0], 0, carry[0], sum[0]);
	fulladder fad2 (a[1], b[1], carry[0], carry[1], sum[1]);
	fulladder fad3 (a[2], b[2], carry[1], carry[2], sum[2]);
	fulladder fad4 (a[3], b[3], carry[2], carry[3], sum[3]);
	fulladder fad5 (a[4], b[4], carry[3], carry[4], sum[4]);
	fulladder fad6 (a[5], b[5], carry[4], carry[5], sum[5]);

	assign overflow = carry[5] ^ carry[4];


endmodule

`endif