`timescale 1ns/10ps
`include "sixbitpow.v"

module testbench;
    reg[5:0] ain;
    reg[5:0] bin;
    wire[5:0] pow;
    wire overflow;

    integer i, j;

    sixbitpow pow1 (ain, bin, pow, overflow);

    initial begin

        $dumpfile("sixbitpow_wave.vcd");
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
