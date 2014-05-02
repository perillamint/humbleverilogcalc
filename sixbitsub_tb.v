`timescale 1ns/10ps
`include "sixbitsub.v"

module testbench;
	reg[5:0] ain;
	reg[5:0] bin;
	wire[5:0] diff;
	wire overflow;

	integer i, j;

	sixbitsub sb1 (ain, bin, diff, overflow);

	initial begin

		$dumpfile("sixbitsub_wave.vcd");
		$dumpvars(0, testbench);
	
		for(i = 0; i < 64; i = i + 1)
		begin
			ain = i;
			for(j = 0; j < 64; j = j + 1)
			begin
				bin = j;
				#250;
			end
		end
	end
endmodule
