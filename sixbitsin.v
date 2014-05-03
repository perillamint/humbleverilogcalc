`ifndef _sixbitsin_incl
`define _sixbitsin_incl

`include "sixbitadd.v"
`include "sixbitpow.v"

module sixbitsin(ain, out, overflow);
    input[5:0] ain;
    output[5:0] out;
    output overflow;
    
    //We have to calculate x - x^3 / 6 + (x^5 / 120 we cannot calc this whthin 6 bit.)
    
    wire[2:0] ovf;
    wire[5:0] pow;
    wire[5:0] divisor;
    wire[5:0] remainder;
    
    sixbitpow pow1 (ain, 3, pow, ovf[1]);
    sixbitdiv div1 (pow, 6, divisor, remainder, ovf[2]);
    sixbitsub sub1 (ain, (ovf[1] || ovf[2]) ? 0 : divisor, out, ovf[0]);
    
    assign overflow = |ovf;
endmodule

`endif