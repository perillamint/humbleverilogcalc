`timescale 1ns/10ps
`include "sixbitdiv.v"

module testbench;
	reg[5:0] dividend;
	reg[5:0] divisor;
	wire[5:0] quotient;
	wire[5:0] remainder;
	wire overflow;

	integer i, j;

	sixbitdiv sd1 (dividend, divisor, quotient, remainder, overflow);

	initial begin

		$dumpfile("sixbitdiv_wave.vcd");
		$dumpvars(0, testbench);
	
		for(i = 0; i < 64; i = i + 1)
		begin
			dividend = i;
			for(j = 0; j < 64; j = j + 1)
			begin
				divisor = j;
				#250;
			end
		end
	end
endmodule
