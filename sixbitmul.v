`ifndef _sixbitmul_incl
`define _sixbitmul_incl

`include "sixbitadd.v"
`include "sixbitsub.v"

module fifteenbitadd (a, b, sum, overflow);
    input[14:0] a;
    input[14:0] b;
    output[14:0] sum;
    output overflow;
    
    wire[14:0] carry;
    
    fulladder fad1 (a[0], b[0], 0, carry[0], sum[0]);
    fulladder fad2 (a[1], b[1], carry[0], carry[1], sum[1]);
    fulladder fad3 (a[2], b[2], carry[1], carry[2], sum[2]);
    fulladder fad4 (a[3], b[3], carry[2], carry[3], sum[3]);
    fulladder fad5 (a[4], b[4], carry[3], carry[4], sum[4]);
    fulladder fad6 (a[5], b[5], carry[4], carry[5], sum[5]);
    fulladder fad7 (a[6], b[6], carry[5], carry[6], sum[6]);
    fulladder fad8 (a[7], b[7], carry[6], carry[7], sum[7]);
    fulladder fad9 (a[8], b[8], carry[7], carry[8], sum[8]);
    fulladder fad10 (a[9], b[9], carry[8], carry[9], sum[9]);
    fulladder fad11 (a[10], b[10], carry[9], carry[10], sum[10]);
    fulladder fad12 (a[11], b[11], carry[10], carry[11], sum[11]);
    fulladder fad13 (a[12], b[12], carry[11], carry[12], sum[12]);
    fulladder fad14 (a[13], b[13], carry[12], carry[13], sum[13]);
    fulladder fad15 (a[13], b[13], carry[13], overflow, sum[14]);
endmodule

module sixbitmul (ain, bin, prod, overflow);
	input[5:0] ain;
	input[5:0] bin;
	output[5:0] prod;
	output overflow;

    wire[14:0] a;
    wire[14:0] s;
    wire[14:0] p;
	wire[14:0] pa1;
	wire[14:0] pa2;
	wire[14:0] pa3;
	wire[14:0] pa4;
	wire[14:0] pa5;
	wire[14:0] pa6;
	wire[14:0] pa7;
	wire[14:0] ps1;
	wire[14:0] ps2;
	wire[14:0] ps3;
	wire[14:0] ps4;
	wire[14:0] ps5;
	wire[14:0] ps6;
	wire[14:0] ps7;
	wire[14:0] midres1;
	wire[14:0] midres2;
	wire[14:0] midres3;
	wire[14:0] midres4;
	wire[14:0] midres5;
	wire[14:0] midres6;
	wire[14:0] res;
	wire[13:0] int_overflow;
	
	assign a[14:8] = {ain[5], ain};
	assign s[14:8] = ~{ain[5], ain} + 1;
	assign p[7:1] = {bin[5], bin};
	
	assign a[7:0] = 0;
	assign s[7:0] = 0;
	assign p[14:8] = 0;
	assign p[0] = 0;
	
	fifteenbitadd ad1 (p, a, pa1, int_overflow[0]);
    fifteenbitadd ad2 (p, s, ps1, int_overflow[1]);
    assign midres1[13:0] = ((p[1] ^ p[0]) ? p[0] ? pa1 : ps1 : p) >> 1;
    assign midres1[14] = midres1[13];
    fifteenbitadd ad3 (midres1, a, pa2, int_overflow[2]);
    fifteenbitadd ad4 (midres1, s, ps2, int_overflow[3]);
    assign midres2[13:0] = ((midres1[1] ^ midres1[0]) ? midres1[0] ? pa2 : ps2 : midres1) >> 1;
    assign midres2[14] = midres2[13];
    fifteenbitadd ad5 (midres2, a, pa3, int_overflow[4]);
    fifteenbitadd ad6 (midres2, s, ps3, int_overflow[5]);
    assign midres3[13:0] = ((midres2[1] ^ midres2[0]) ? midres2[0] ? pa3 : ps3 : midres2) >> 1;
    assign midres3[14] = midres3[13];
    fifteenbitadd ad7 (midres3, a, pa4, int_overflow[6]);
    fifteenbitadd ad8 (midres3, s, ps4, int_overflow[7]);
    assign midres4[13:0] = ((midres3[1] ^ midres3[0]) ? midres3[0] ? pa4 : ps4 : midres3) >> 1;
    assign midres4[14] = midres4[13];
    fifteenbitadd ad9 (midres4, a, pa5, int_overflow[8]);
    fifteenbitadd ad10 (midres4, s, ps5, int_overflow[9]);
    assign midres5[13:0] = ((midres4[1] ^ midres4[0]) ? midres4[0] ? pa5 : ps5 : midres4) >> 1;
    assign midres5[14] = midres5[13];
    fifteenbitadd ad11 (midres5, a, pa6, int_overflow[10]);
    fifteenbitadd ad12 (midres5, s, ps6, int_overflow[11]);
    assign midres6[13:0] = ((midres5[1] ^ midres5[0]) ? midres5[0] ? pa6 : ps6: midres5) >> 1;
    assign midres6[14] = midres6[13];
    fifteenbitadd ad13 (midres6, a, pa7, int_overflow[12]);
    fifteenbitadd ad14 (midres6, s, ps7, int_overflow[13]);
    assign res[13:0] = ((midres6[1] ^ midres6[0]) ? midres6[0] ? pa7 : ps7: midres6) >> 1;
    assign res[14] = res[13];
    
    assign prod = res[6:1];
    
    wire[2:0] chkovf;
     
    and(chkovf[0], res[14], res[13], res[12], res[11], res[10], res[9], res[8], res[7]);
    or(chkovf[1], res[14], res[13], res[12], res[11], res[10], res[9], res[8], res[7]);
    xor(chkovf[2], chkovf[0], chkovf[1]);
    
    wire[2:0] chksign;
    
    xor(chksign[0], ain[5], bin[5]);
    xor(chksign[1], ain[5], res[12]);
    xor(chksign[2], bin[5], res[12]);
    
    wire overflow_ncz;
    
    or(overflow_ncz, chkovf[2], chksign[0] ? !res[12] : (chksign[1] ^ chksign[2]));
    
    wire[1:0] iszero;
    
    nor(iszero[0], ain[0], ain[1], ain[2], ain[3], ain[4], ain[5]);
    nor(iszero[1], bin[0], bin[1], bin[2], bin[3], bin[4], bin[5]);
    
    and(overflow, overflow_ncz, !iszero[0], !iszero[1]);
endmodule

`endif