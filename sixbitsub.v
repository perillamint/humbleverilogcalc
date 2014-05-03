`ifndef _sixbitsub_incl
`define _sixbitsub_incl

`include "sixbitadd.v"

module sixbitsub (ain, bin, diff, overflow);
	input[5:0] ain;
	input[5:0] bin;
	output[5:0] diff;
	output overflow;

	wire[5:0] notb = ~bin + 1;

	sixbitadd ad1 (ain, notb, diff, overflow);
endmodule

`endif