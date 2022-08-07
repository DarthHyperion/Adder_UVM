class adder_agent extends uvm_agent;
  
  `uvm_component_utils(adder_agent)

  adder_monitor monitor;
  adder_sequencer sequencer;
  adder_driver driver;
  
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor = adder_monitor::type_id::create("monitor", this);
    driver = adder_driver::type_id::create("driver", this);
    sequencer = adder_sequencer::type_id::create("sequencer", this);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);   
      driver.seq_item_port.connect(sequencer.seq_item_export);
      
  endfunction
 
endclass:adder_agent
    
    
 