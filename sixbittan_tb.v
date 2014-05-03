`timescale 1ns/10ps
`include "sixbittan.v"

module testbench;
    reg[5:0] ain;
    wire[5:0] out;
    wire overflow;

    integer i;

    sixbittan tan1 (ain, out, overflow);

    initial begin

        $dumpfile("sixbittan_wave.vcd");
        $dumpvars(0, testbench);
    
        for(i = 0; i < 64; i = i + 1)
        begin
            ain = i;
            #250;
        end
    end
endmodule
