`ifndef _sixbitexp_incl
`define _sixbitexp_incl

`include "sixbitadd.v"
`include "sixbitpow.v"

module sixbitexp(ain, out, overflow);
    input[5:0] ain;
    output[5:0] out;
    output overflow;
    
    //We have to calculate 1 + ain + ain^2 / 2!;
    
    wire[5:0] sum;
    wire[3:0] ovf;
    wire[5:0] pow;
    wire[5:0] divisor;
    wire[5:0] remainder;
    
    sixbitadd add1 (1, ain, sum, ovf[0]);
    sixbitpow pow1 (ain, 2, pow, ovf[1]);
    sixbitdiv div1 (pow, 2, divisor, remainder, ovf[2]);
    sixbitadd add2 (sum, (ovf[1] || ovf[2]) ? 0 : divisor, out, ovf[3]);
    
    assign overflow = |ovf;
endmodule

`endif