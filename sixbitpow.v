`ifndef _sixbitpow_incl
`define _sixbitpow_incl

`include "sixbitdiv.v"
`include "sixbitmul.v"

module sixbitpow (ain, bin, out, overflow);
    input[5:0] ain;
    input[5:0] bin;
    output[5:0] out;
    output overflow;
    
    wire[9:0] ovf;
    wire[5:0] pow[10:0];
    assign pow[0] = 1;
    
    generate
        genvar i;    
        for(i = 0; i < 10; i = i + 1) begin
            sixbitmul mul1 (pow[i], (bin > i) ? ain : 1, pow[i+1], ovf[i]);
        end
    endgenerate
    
    assign out = bin[5] ? 0 : pow[10];
    assign overflow = |ovf;
endmodule

`endif