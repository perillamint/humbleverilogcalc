`timescale 1ns/10ps
`include "fulladder.v"

module testbench;
	reg[2:0] testinput;
	wire[1:0] testoutput;

	integer i;

	fulladder fad1 (testinput[0], testinput[1], testinput[2], testoutput[0], testoutput[1]);

	initial begin

		$dumpfile("fulladder_wave.vcd");
		$dumpvars(0, testbench);
	
		for(i = 0; i < 8; i = i + 1)
		begin
			testinput = i;
			#250;
		end
	end
endmodule
