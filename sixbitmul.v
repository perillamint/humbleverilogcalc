`ifndef _sixbitmul_incl
`define _sixbitmul_incl

`include "sixbitadd.v"
`include "sixbitsub.v"

module sixbitmul (ain, bin, prod, overflow);
	input[5:0] ain;
	input[5:0] bin;
	output[5:0] prod;
	output overflow;

	wire[5:0] sumwire1;
	wire[5:0] sumwire2;
	wire[5:0] sumwire3;
	wire[5:0] sumwire4;
	wire[5:0] sumwire5;
	wire[5:0] int_overflow;

	sixbitadd ad1 (0, bin[0] ? ain : 0, sumwire1, int_overflow[0]);
	sixbitadd ad2 (sumwire1, bin[1] ? (ain << 1) : 0, sumwire2, int_overflow[1]);
	sixbitadd ad3 (sumwire2, bin[2] ? (ain << 2) : 0, sumwire3, int_overflow[2]);
	sixbitadd ad4 (sumwire3, bin[3] ? (ain << 3) : 0, sumwire4, int_overflow[3]);
	sixbitadd ad5 (sumwire4, bin[4] ? (ain << 4) : 0, sumwire5, int_overflow[4]);
	sixbitadd ad6 (sumwire5, bin[5] ? (ain << 5) : 0, prod, int_overflow[5]);

    wire[1:0] ovfcalc;
    
    xor(ovfcalc[0], sumwire1[5], sumwire2[5], sumwire3[5], sumwire4[5], sumwire5[5]);
    xor(ovfcalc[1], ain[5], bin[5]);
    
    xor(overflow, ovfcalc);
    /*
    or (overflow, int_overflow);
    
	assign overflow = ain[4] & bin[2] ||
			ain[3] & bin[3] || ain[4] & bin[3] ||
			ain[2] & bin[4] || ain[3] & bin[4] || ain[4] & bin[4];
    */
endmodule

`endif