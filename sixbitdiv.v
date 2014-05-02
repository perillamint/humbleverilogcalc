`ifndef _sixbitdiv_incl
`define _sixbitdiv_incl

`include "sixbitsub.v"

module sixbitdiv (dividend, divisor, quotient, remainder, err);
	input[5:0] dividend;
	input[5:0] divisor;
	output[5:0] quotient;
	output[5:0] remainder;
	output err;
	
	wire[5:0] posdividend;
	wire[5:0] posdivisor;
    wire[5:0] posquotient;
    wire[5:0] posremainder;
	
	wire[5:0] sub1;
    wire[5:0] sub2;
    wire[5:0] sub3;
    wire[5:0] sub4;
    wire[5:0] sub5;
    wire[5:0] sub6;
    
	wire[5:0] div1;
    wire[5:0] div2;
    wire[5:0] div3;
    wire[5:0] div4;
    wire[5:0] div5;
    
	wire[5:0] overflow;
	wire divzero;
	
	
	assign divzero = !(divisor[0] || divisor[1] || divisor[2] || divisor[3] ||
	                 divisor[4] || divisor[5]);
	
	
	assign posdividend = dividend[5] ? ~(dividend - 1) : dividend;
    assign posdivisor = divisor[5] ? ~(divisor - 1) : divisor;

    /*
    sixbitsub sb1 (posdividend, (posdivisor << 5) & 'h0x1F , sub1, overflow[0]); 
    assign posquotient[5] = !(sub1[5] || overflow[0]);
    assign div1 = posquotient[5] ? sub1 : posdividend;
    */
    
    assign div1 = posdividend;
    assign posquotient[5] = 0;
    
    sixbitsub sb2 (div1, (posdivisor << 4) & 'h1F, sub2, overflow[1]);
    nor (posquotient[4], sub2[5], overflow[1], posdivisor[1], posdivisor[2], posdivisor[3], posdivisor[4], posdivisor[5]);
    assign div2 = posquotient[4] ? sub2 : div1;
    
    sixbitsub sb3 (div2, (posdivisor << 3) & 'h1F, sub3, overflow[2]);
    nor (posquotient[3], sub3[5], overflow[2], posdivisor[2], posdivisor[3], posdivisor[4], posdivisor[5]);
    assign div3 = posquotient[3] ? sub3 : div2;
    
    sixbitsub sb4 (div3, (posdivisor << 2) & 'h1F, sub4, overflow[3]);
    nor (posquotient[2], sub4[5], overflow[3], posdivisor[3], posdivisor[4], posdivisor[5]);
    assign div4 = posquotient[2] ? sub4 : div3;
    
    sixbitsub sb5 (div4, (posdivisor << 1) & 'h1F, sub5, overflow[4]);
    nor (posquotient[1], sub5[5], overflow[4], posdivisor[4], posdivisor[5]);
    assign div5 = posquotient[1] ? sub5 : div4;
    
    sixbitsub sb6 (div5, (posdivisor) & 'h1F, sub6, overflow[5]);
    nor (posquotient[0], sub6[5], overflow[5], posdivisor[5]);
    assign posremainder = posquotient[0] ? sub6 : div5;
    
    assign err = overflow[0] || overflow[1] || overflow[2] || overflow[3] ||
                 overflow[4] || overflow[5] || divzero;
                 
    assign quotient = (dividend[5] ^ divisor[5]) ? ~posquotient + 1 : posquotient;
    assign remainder = dividend[5] ? ~posremainder + 1 : posremainder;
    
endmodule

`endif