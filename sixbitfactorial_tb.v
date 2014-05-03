`timescale 1ns/10ps
`include "sixbitfactorial.v"

module testbench;
    reg[5:0] ain;
    wire[5:0] out;
    wire overflow;

    integer i;

    sixbitfactorial ft1 (ain, out, overflow);

    initial begin

        $dumpfile("sixbitfactorial_wave.vcd");
        $dumpvars(0, testbench);
    
        for(i = 0; i < 64; i = i + 1)
        begin
            ain = i;
            #250;
        end
    end
endmodule
