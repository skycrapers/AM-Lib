`include "common.vh"
module top
  #(parameter
	  k     = 8, //selecting k bits
	  n     = 16,//length of original number
	  log_n = `C_LOG_2(n) //bits number of encoder result
  )
  (
   input  wire [n-1  :0] a,
   input  wire [n-1  :0] b,
   output wire [2*n-1:0] result
   );

wire [n-1:0] lod_a,lod_b;
LOD #(.n(n))lod1(.in(a),.out(lod_a));
LOD #(.n(n))lod2(.in(b),.out(lod_b));

wire [log_n-1:0] lod_a_en,lod_b_en;
ENCODER #(.n(n),.k(k))encode1(.in(lod_a),.out(lod_a_en));
ENCODER #(.n(n),.k(k))encode2(.in(lod_b),.out(lod_b_en));

wire [log_n:0] en_sum;
ADDER #(.n(log_n))add_shift(.a(lod_a_en),.b(lod_b_en),.cin(1'b0),.result(en_sum));

wire [k-1:0] multa,multb;
MUX #(.n(n),.k(k))mux1(.in(a),.lod_en(lod_a_en),.out(multa));
MUX #(.n(n),.k(k))mux2(.in(b),.lod_en(lod_b_en),.out(multb));

wire [2*k-1:0] multc;
MULT_DIR #(.n(k)) mult0(.a(multa),.b(multb),.result(multc));
BARREL_SHIFTER #(.n(2*k),.k(k),.shift_n(log_n+1),.result_n(2*n))shift_result(.approx(multc),.encode_sum(en_sum),.result(result));

endmodule
