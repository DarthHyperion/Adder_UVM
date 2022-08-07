import uvm_pkg::*;


class adder_tb extends uvm_env;
  
  `uvm_component_utils(adder_tb)
  
  adder_env adder;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MSG", "Testbench build phase executed", UVM_HIGH)
    adder = adder_env::type_id::create("adder", this);
  endfunction
  
endclass:adder_tb
  