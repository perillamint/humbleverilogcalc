`timescale 1ns/10ps
`include "sixbitmul.v"

module testbench;
	reg[5:0] ain;
	reg[5:0] bin;
	wire[5:0] prod;
	wire overflow;

	integer i, j;

	sixbitmul sm1 (ain, bin, prod, overflow);

	initial begin

		$dumpfile("sixbitmul_wave.vcd");
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
