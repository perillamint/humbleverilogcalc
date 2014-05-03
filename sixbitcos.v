`ifndef _sixbitcos_incl
`define _sixbitcos_incl

`include "sixbitadd.v"
`include "sixbitpow.v"

module sixbitcos(ain, out, overflow);
    input[5:0] ain;
    output[5:0] out;
    output overflow;
    
    //We have to calculate 1 - x^2 / 2 + x^4 / 24;
    
    wire[5:0] ovf;
    wire[5:0] pow_1;
    wire[5:0] pow_2;
    wire[5:0] divisor1;
    wire[5:0] remainder1;
    wire[5:0] divisor2;
    wire[5:0] remainder2;
    wire[5:0] sub;
    
    sixbitpow pow1 (ain, 2, pow_1, ovf[0]);
    sixbitdiv div1 (pow_1, 2, divisor1, remainder1, ovf[1]);
    sixbitsub sub1 (1, (ovf[0] || ovf[1]) ? 0 : divisor1, sub, ovf[2]);
    sixbitpow pow2 (ain, 4, pow_2, ovf[3]);
    sixbitdiv div2 (pow_2, 24, divisor2, remainder2, ovf[4]);
    sixbitadd add1 (sub, (ovf[3] || ovf[4]) ? 0 : divisor2, out, ovf[5]);
    
    assign overflow = |ovf;
endmodule

`endif