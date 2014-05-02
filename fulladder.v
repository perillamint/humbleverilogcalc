`ifndef _fulladder_incl
`define _fulladder_incl

module fulladder(a, b, cin, cout, sum);
	input a, b, cin;
	output cout, sum;

	wire carry_int;
	wire sum_int;
	wire carry_res;

	assign carry_int = a & b;
	assign sum_int = a ^ b;

    assign carry_res = sum_int & cin;
    assign sum = sum_int ^ cin;

	assign cout = carry_res | carry_int;
endmodule

`endif