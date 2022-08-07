import uvm_pkg::*;

class base_test extends uvm_test;
  
  `uvm_component_utils(base_test)
  
  adder_tb tb;
  
  //constructor
  function new(string name, uvm_component parent );
    super.new(name, parent);
  endfunction
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_int::set( this, "*", "recording_detail", 1);
    `uvm_info("BUILD", "Build phase of test is being executed", UVM_HIGH)
    tb = adder_tb::type_id::create("tb", this);
    
    uvm_config_wrapper::set(this, "tb.adder.agent.sequencer.run_phase", "default_sequence", adder_base_seq::get_type());
    
  endfunction

  
  function void check_phase(uvm_phase phase);
     check_config_usage();
  endfunction : check_phase

  
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
endclass
