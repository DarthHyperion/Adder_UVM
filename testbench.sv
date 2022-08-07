`define LENGTH 16



module top;

  import uvm_pkg::*;

  `include "uvm_macros.svh"
  `include "adder_seq_item.sv"
  `include "adder_monitor.sv"
  `include "adder_sequencer.sv"
  `include "adder_seq.sv"
  `include "adder_driver.sv"
  `include "adder_agent.sv"
  `include "adder_scoreboard.sv"
  `include "adder_env.sv"
  `include "adder_tb.sv"
  `include "adder_test_lib.sv"
	  

   
  reg         clk;
  always #20 clk = ~clk;
  
   // adder Interface to the DUT
  adder_if in0(clk);
  
  NBit_adder#(`LENGTH) dut(in0.addend1_in, in0.addend2_in, in0.correct, in0.sum, clk);
  
  
   initial begin
      clk <= 1'b0;
     uvm_config_db#(virtual adder_if)::set(null, "*", "vif", in0);

   // Start the test
     run_test();
  end

  

endmodule