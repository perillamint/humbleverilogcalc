`include "sixbitadd.v"
`include "sixbitsub.v"
`include "sixbitmul.v"
`include "sixbitdiv.v"
`include "sixbitpow.v"
//`include "sixbitlog.v"
`include "sixbitfactorial.v"
`include "sixbitexp.v"
`include "sixbitsin.v"
`include "sixbitcos.v"
//`include "sixbittan.v"

`include "multiplexer.v"

module calculator (data_in1, data_in2, operator, data_out, error);
    input[5:0] data_in1;
    input[5:0] data_in2;
    input[3:0] operator;
    output[5:0] data_out;
    output error;
    
    wire[5:0] sum;
    wire[5:0] diff;
    wire[5:0] prod;
    wire[5:0] quotient;
    wire[5:0] remainder;
    wire[5:0] power;
    wire[5:0] log;
    wire[5:0] factorial;
    wire[5:0] exp;
    wire[5:0] sin;
    wire[5:0] cos;
    wire[5:0] tan;
    wire[12:0] overflow;
    
    sixbitadd add1 (data_in1, data_in2, sum, overflow[0]);
    sixbitsub sub1 (data_in1, data_in2, diff, overflow[1]);
    sixbitmul mul1 (data_in1, data_in2, prod, overflow[2]);
    sixbitdiv div1 (data_in1, data_in2, quotient, remainder, overflow[3]);
    sixbitpow pow1 (data_in1, data_in2, power, overflow[5]);
    //overflow[6], log
    sixbitfactorial fact1 (data_in1, factorial, overflow[7]);
    sixbitexp exp1 (data_in1, exp, overflow[8]);
    sixbitsin sin1 (data_in1, sin, overflow[9]);
    sixbitcos cos1 (data_in1, cos, overflow[10]);
    sixbittan tan1 (data_in1, tan, overflow[11]);
    
    assign overflow[4] = overflow[3];
    
    multiplexer mux1 (sum, diff, prod, quotient, remainder, power, log, factorial, exp, sin, cos, tan, 0, 0, 0, 0, operator, data_out);
    assign error = overflow[operator];
endmodule
    