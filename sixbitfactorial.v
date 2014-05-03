`ifndef _sixbitfactorial_incl
`define _sixbitfactorial_incl

`include "sixbitmul.v"
`include "multiplexer.v"

module sixbitfactorial(ain, out, overflow);
    input[5:0] ain;
    output[5:0] out;
    output overflow;
    
    wire[15:0] ovf;
    wire[15:0] ovf_sum;
    wire[5:0] fact1;
    wire[5:0] fact2;
    wire[5:0] fact3;
    wire[5:0] fact4;
    wire[5:0] fact5;
    wire[5:0] fact6;
    wire[5:0] fact7;
    wire[5:0] fact8;
    wire[5:0] fact9;
    wire[5:0] fact10;
    wire[5:0] fact11;
    wire[5:0] fact12;
    wire[5:0] fact13;
    wire[5:0] fact14;
    wire[5:0] fact15;
    
    wire[5:0] tmpout;
    
    assign ovf[0] = 0;
    assign ovf_sum[0] = 0;
    
    sixbitmul mul1 (1, 1, fact1, ovf[1]);
    sixbitmul mul2 (fact1, 2, fact2, ovf[2]);
    sixbitmul mul3 (fact2, 3, fact3, ovf[3]);
    sixbitmul mul4 (fact3, 4, fact4, ovf[4]);
    sixbitmul mul5 (fact4, 5, fact5, ovf[5]);
    sixbitmul mul6 (fact5, 6, fact6, ovf[6]);
    sixbitmul mul7 (fact6, 7, fact7, ovf[7]);
    sixbitmul mul8 (fact7, 8, fact8, ovf[8]);
    sixbitmul mul9 (fact8, 9, fact9, ovf[9]);
    sixbitmul mul10 (fact9, 10, fact10, ovf[10]);
    sixbitmul mul11 (fact10, 11, fact11, ovf[11]);
    sixbitmul mul12 (fact11, 12, fact12, ovf[12]);
    sixbitmul mul13 (fact12, 12, fact13, ovf[13]);
    sixbitmul mul14 (fact13, 12, fact14, ovf[14]);
    sixbitmul mul15 (fact14, 12, fact15, ovf[15]);
    
    or (ovf_sum[1], ovf_sum[0], ovf[1]);
    or (ovf_sum[2], ovf_sum[1], ovf[2]);
    or (ovf_sum[3], ovf_sum[2], ovf[3]);
    or (ovf_sum[4], ovf_sum[3], ovf[4]);
    or (ovf_sum[5], ovf_sum[4], ovf[5]);
    or (ovf_sum[6], ovf_sum[5], ovf[6]);
    or (ovf_sum[7], ovf_sum[6], ovf[7]);
    or (ovf_sum[8], ovf_sum[7], ovf[8]);
    or (ovf_sum[9], ovf_sum[8], ovf[9]);
    or (ovf_sum[10], ovf_sum[9], ovf[10]);
    or (ovf_sum[11], ovf_sum[10], ovf[11]);
    or (ovf_sum[12], ovf_sum[11], ovf[12]);
    or (ovf_sum[13], ovf_sum[12], ovf[13]);
    or (ovf_sum[14], ovf_sum[13], ovf[14]);
    or (ovf_sum[15], ovf_sum[14], ovf[15]);
    
    multiplexer mux1 (1, fact1, fact2, fact3, fact4, fact5, fact6, fact7, fact8, fact9, fact10,
                fact11, fact12, fact13, fact14, fact15, ain[3:0], tmpout);
                
    assign out = (ain[4] || ain[5]) ? 0 : tmpout;
    assign overflow = (ain[4] || ain[5]) ? 1 : ovf_sum[ain[3:0]];
endmodule

`endif