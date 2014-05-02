`ifndef _sixbitpow_incl
`define _sixbitpow_incl


module sixbitpow (base, exponent, result, overflow);
    input[5:0] base;
    input[5:0] exponent;
    output[5:0] result;
    output overflow;
    
endmodule

`endif