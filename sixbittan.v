`ifndef _sixbittan_incl
`define _sixbittan_incl

`include "sixbitadd.v"
`include "sixbitpow.v"

module sixbittan(ain, out, overflow);
    input[5:0] ain;
    output[5:0] out;
    output overflow;
    
    //We have to calculate x + x^3 / 3 + 2 * x^5 / 15;
    
    wire[6:0] ovf;
    wire[5:0] pow_1;
    wire[5:0] pow_2;
    wire[5:0] divisor1;
    wire[5:0] remainder1;
    wire[5:0] divisor2;
    wire[5:0] remainder2;
    wire[5:0] mul;
    wire[5:0] add;
    
    sixbitpow pow1 (ain, 3, pow_1, ovf[0]);
    sixbitdiv div1 (pow_1, 3, divisor1, remainder1, ovf[1]);
    sixbitadd add1 (ain, (ovf[0] || ovf[1]) ? 0 : divisor1, add, ovf[2]);
    sixbitpow pow2 (ain, 5, pow_2, ovf[3]);
    sixbitdiv div2 (pow_2, 15, divisor2, remainder2, ovf[4]);
    sixbitmul mul1 (divisor2, 2, mul, ovf[5]);
    sixbitadd add1 (add, (ovf[3] || ovf[4] || ovf[5]) ? 0 : mul, out, ovf[6]);
    
    assign overflow = |ovf;
endmodule

`endif