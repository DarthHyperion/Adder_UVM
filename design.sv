module NBit_adder #(parameter WIDTH = 4) (a, b, correct, out, clk);
    input bit [WIDTH-1:0] a, b;
    input logic clk;
  	input bit correct;
    output bit [WIDTH:0] out;

    always@(posedge clk) begin
      if (correct == 1'b1)
      	out <= a + b;
      else 
      	out <= a ^ b + 1;
    end

endmodule
